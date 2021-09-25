import 'package:get/get.dart';
import 'package:e_commerce_app_firebase/constants/assets_path.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  RxBool isLoginWidgetDisplayed = true.obs;

  changeDisplayedAuthWidget() {
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }

  String changeDIsplayedImage() {
    String image = isLoginWidgetDisplayed.value ? login : register;
    return image;
  }

  double changeDisplayedImageSize() {
    double size = isLoginWidgetDisplayed.value ? 210.0 : 180.0;
    return size;
  }
}
