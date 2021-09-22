import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/firebase.dart';
import 'controllers/app_controller.dart';
import 'controllers/auth_controller.dart';
import 'package:e_commerce_app_firebase/controllers/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialized firebase and controllers
  await initialization.then((value) {
    Get.put(AppController());
    Get.put(AuthController());
    Get.put(ProductController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello World"),
          centerTitle: true,
        ),
      ),
    );
  }
}
