import 'package:get/get.dart';

import 'package:e_commerce_app_firebase/constants/firebase.dart';
import 'package:e_commerce_app_firebase/models/products_model.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "products";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}
