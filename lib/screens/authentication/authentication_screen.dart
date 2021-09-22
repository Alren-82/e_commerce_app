import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:e_commerce_app_firebase/constants/controllers_constants.dart';
import 'package:e_commerce_app_firebase/screens/authentication/widgets/bottom_text_widget.dart';
import 'package:e_commerce_app_firebase/screens/authentication/widgets/login_widget.dart';
import 'package:e_commerce_app_firebase/screens/authentication/widgets/register_widget.dart';

class AuthenticationScreen extends StatelessWidget {
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
                SvgPicture.asset(
                  appController.changeDIsplayedImage(),
                  width: appController.changeDisplayedImageSize(),
                ),
                SizedBox(height: MediaQuery.of(context).size.width / 5),
                Visibility(
                    visible: appController.isLoginWidgetDisplayed.value,
                    child: LoginWidget()),
                Visibility(
                    visible: !appController.isLoginWidgetDisplayed.value,
                    child: RegisterWidget()),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: appController.isLoginWidgetDisplayed.value,
                  child: BottomTextWidget(
                    onTap: () {
                      appController.changeDisplayedAuthWidget();
                    },
                    text1: "Don\'t have an account?",
                    text2: "Create account!",
                  ),
                ),
                Visibility(
                  visible: !appController.isLoginWidgetDisplayed.value,
                  child: BottomTextWidget(
                    onTap: () {
                      appController.changeDisplayedAuthWidget();
                    },
                    text1: "Already have an account?",
                    text2: "Sign in!",
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
