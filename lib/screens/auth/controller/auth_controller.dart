import 'dart:ui';
import 'package:get/get.dart';


class AuthController extends GetxController {
  var isPasswordHidden = true.obs;
  var isPasswordHidden1 = true.obs;
  var isPasswordHidden2 = true.obs;
  var isRemember = true.obs;
  var selectedLanguageCode = 'en'.obs;

  void changeLanguage(String localeCode) {
    selectedLanguageCode.value = localeCode;

    update();
    if (localeCode == 'en') {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('ar', 'SA'));
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void togglePasswordVisibility1() {
    isPasswordHidden1.value = !isPasswordHidden1.value;
  }

  void togglePasswordVisibility2() {
    isPasswordHidden2.value = !isPasswordHidden2.value;
  }

}