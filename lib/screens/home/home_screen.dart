import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_app_firebase/constants/controllers_constants.dart';
import 'package:e_commerce_app_firebase/screens/home/widget/products_widget.dart';
import 'package:e_commerce_app_firebase/widgets/custom_text_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: CustomText(
            text: "Watches",
            size: 24,
            weight: FontWeight.bold,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // showBarModalBottomSheet(
                  //   context: context,
                  //   builder: (context) => Container(
                  //     color: Colors.white,
                  //     child: ShoppingCartWidget(),
                  //   ),
                  // );
                })
          ],
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: [
              Obx(() => UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  accountName: Text(authController.userModel.value!.name ?? ""),
                  accountEmail:
                      Text(authController.userModel.value!.email ?? ""))),
              ListTile(
                leading: Icon(Icons.book),
                title: CustomText(
                  text: "Payments History",
                ),
                onTap: () async {
                  //  paymentsController.getPaymentHistory();
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: CustomText(
                  text: "My Cart",
                ),
                onTap: () async {},
              ),
              ListTile(
                onTap: () {
                  authController.signOut();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Log out"),
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.white30,
          child: ProductsWidget(),
        ));
  }
}
