import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_app_firebase/controllers/app_controller.dart';
import 'package:e_commerce_app_firebase/screens/authentication/widgets/bottom_text_widget.dart';
import 'package:e_commerce_app_firebase/screens/authentication/widgets/login_widget.dart';
import 'package:e_commerce_app_firebase/screens/authentication/widgets/register_widget.dart';

class AuthenticationScreen extends StatelessWidget {
  final AppController _appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width / 3),
                Image.network(
                  "https://images.pexels.com/photos/1337386/pexels-photo-1337386.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  width: 200,
                ),
                SizedBox(height: MediaQuery.of(context).size.width / 5),
                Visibility(
                    visible: _appController.isLoginWidgetDisplayed.value,
                    child: LoginWidget()),
                Visibility(
                    visible: !_appController.isLoginWidgetDisplayed.value,
                    child: RegisterWidget()),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: _appController.isLoginWidgetDisplayed.value,
                  child: BottomTextWidget(
                    onTap: () {
                      _appController.changeDIsplayedAuthWidget();
                    },
                    text1: "Don\'t have an account?",
                    text2: "Create account!",
                  ),
                ),
                Visibility(
                  visible: !_appController.isLoginWidgetDisplayed.value,
                  child: BottomTextWidget(
                    onTap: () {
                      _appController.changeDIsplayedAuthWidget();
                    },
                    text1: "Already have an account?",
                    text2: "Sign in!!",
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
