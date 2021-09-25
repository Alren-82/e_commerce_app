import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:uuid/uuid.dart';

import 'package:e_commerce_app_firebase/constants/app_constants.dart';
import 'package:e_commerce_app_firebase/constants/controllers_constants.dart';
import 'package:e_commerce_app_firebase/constants/firebase_constants.dart';
import 'package:e_commerce_app_firebase/helpers/loading_helper.dart';
import 'package:e_commerce_app_firebase/models/payments_model.dart';
import 'package:e_commerce_app_firebase/screens/payments/payments.dart';
import 'package:e_commerce_app_firebase/widgets/custom_text_widget.dart';

class PaymentsController extends GetxController {
  static PaymentsController instance = Get.find();
  String collection = "payments";
  String url =
      'https://us-central1-ecommerce-app-e1c13.cloudfunctions.net/createPayment';
  List<PaymentsModel>? payments = [];

  @override
  void onReady() {
    super.onReady();
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51JdYlUGORYGS8huOBVRQbtIMgoqXiDHDrab2pOzCroQdlGqNN2LRWK1zm8OeCLs2EtzXb87FrnadPdU7aAiKAhJJ00ijgyMoL2",
        androidPayMode: 'test'));
  }

  Future<void> createPaymentMethod() async {
    StripePayment.setStripeAccount(null ?? "This should not be null.");
    //step 1: add card
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    // ignore: unnecessary_null_comparison
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : _showPaymentFailedAlert();
    dismissLoadingWidget();
  }

  Future<void> processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    showLoading();

    int amount =
        // stripes process payment by cents ($1 = 100 cents)
        (double.parse(cartController.totalCartPrice.value.toStringAsFixed(2)) *
                100)
            .toInt();
    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
    final response = await Dio()
        .post('$url?amount=$amount&currency=USD&pm_id=${paymentMethod.id}');
    print('Now i decode');
    if (response.data != null && response.data != 'error') {
      final paymentIntentX = response.data;
      final status = paymentIntentX['paymentIntent']['status'];
      if (status == 'succeeded') {
        StripePayment.completeNativePayRequest();
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
        authController.updateUserData({"cart": []});
        Get.snackbar("Success", "Payment succeeded");
      } else {
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
      }
    } else {
      //case A
      StripePayment.cancelNativePayRequest();
      _showPaymentFailedAlert();
    }
  }

  void _showPaymentFailedAlert() {
    Get.defaultDialog(
        content: CustomText(
          text: "Payment failed, try another card",
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Okay",
                ),
              ))
        ]);
  }

  _addToCollection({String? paymentStatus, String? paymentId}) {
    String id = Uuid().v1();
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "clientId": authController.userModel.value!.id,
      "status": paymentStatus,
      "paymentId": paymentId,
      "cart": authController.userModel.value!.cartItemsToJson(),
      "amount": cartController.totalCartPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().millisecondsSinceEpoch,
    });
  }

  getPaymentHistory() {
    showLoading();
    payments!.clear();
    firebaseFirestore
        .collection(collection)
        .where("clientId", isEqualTo: authController.userModel.value!.id)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        PaymentsModel payment = PaymentsModel.fromMap(doc.data());
        payments!.add(payment);
      });

      logger.i("length ${payments!.length}");
      dismissLoadingWidget();
      Get.to(() => PaymentsScreen());
    });
  }
}
