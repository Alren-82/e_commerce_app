import 'package:e_commerce_app_firebase/widgets/custom_text_widget.dart';
import 'package:e_commerce_app_firebase/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: "Please wait...",
            size: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Loading()
        ],
      ),
    );
  }
}
