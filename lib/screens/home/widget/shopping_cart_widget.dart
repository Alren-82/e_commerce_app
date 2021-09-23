import 'package:e_commerce_app_firebase/screens/home/widget/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_app_firebase/constants/controllers_constants.dart';
import 'package:e_commerce_app_firebase/widgets/custom_button_widget.dart';
import 'package:e_commerce_app_firebase/widgets/custom_text_widget.dart';

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CustomText(
                text: "Shopping Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: authController.userModel.value!.cart!
                      .map((cartItem) => CartItemWidget(
                            cartItem: cartItem,
                          ))
                      .toList(),
                )),
          ],
        ),
        Positioned(
            bottom: 30,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Obx(
                  () => CustomButton(
                      text:
                          "Pay (\$${cartController.totalCartPrice.value.toStringAsFixed(2)})",
                      onTap: () {
                        // paymentsController.createPaymentMethod();
                      }),
                )))
      ],
    );
  }
}
