import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  RxBool isLoginWidgetDisplayed = true.obs;

  changeDisplayedAuthWidget() {
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }

  String changeDIsplayedImage() {
    String image = isLoginWidgetDisplayed.value
        ? "assets/images/login.svg"
        : "assets/images/register.svg";
    return image;
  }

  double changeDisplayedImageSize() {
    double size = isLoginWidgetDisplayed.value ? 210.0 : 180.0;
    return size;
  }
}
