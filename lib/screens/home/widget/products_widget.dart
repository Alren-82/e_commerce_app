import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_app_firebase/constants/controllers.dart';
import 'package:e_commerce_app_firebase/models/products_model.dart';
import 'package:e_commerce_app_firebase/screens/home/widget/single_product_widget.dart';

class ProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .63,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 10,
        children: productController.products.map((ProductModel product) {
          return SingleProductWidget(
            product: product,
          );
        }).toList()));
  }
}
