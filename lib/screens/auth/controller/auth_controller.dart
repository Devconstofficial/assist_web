import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/services/auth_service.dart';
import 'package:assist_web/utils/app_strings.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class AuthController extends GetxController {
  final AuthService _service = AuthService();
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  final emailForgotPassController = TextEditingController();
  final passwordForgotController = TextEditingController();
  final passwordForgotConfirmController = TextEditingController();
  var isPasswordHidden = true.obs;
  var isPasswordHidden1 = true.obs;
  var isPasswordHidden2 = true.obs;
  var isRemember = true.obs;
  var selectedLanguageCode = 'en'.obs;
  var code = OtpFieldController();
  var otpCode = ''.obs;

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

  void login() async {
    if (emailLoginController.text.isEmpty ||
        passwordLoginController.text.isEmpty) {
      showCustomSnackbar('Error', 'All fields must be filled');
      return;
    } else {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );
        var result = await _service.signInUser(
          email: emailLoginController.text.trim(),
          password: passwordLoginController.text.trim(),
        );
        Get.back();
        if (result is UserModel) {
          if (result.roles.contains('admin')) {
            SessionManagement().saveBoolSession(
              tokenKey: SessionTokenKeys.kIsRememberMeKey,
              tokenValue: true,
            );
            Get.offAllNamed(kDashboardScreenRoute);
            showCustomSnackbar(
              "Success",
              "Login Successfully",
              backgroundColor: Colors.green,
            );
            return;
          } else {
            showCustomSnackbar("Error", "Only admin can login");
          }
        } else {
          showCustomSnackbar("Error", result.toString());
        }
      } catch (e) {
        Get.back();
        showCustomSnackbar("Error", e.toString());
      }
    }
  }

  void forgotPassword() async {
    if (emailForgotPassController.text.isEmpty) {
      showCustomSnackbar('Error', 'Email cannot be empty');
      return;
    } else {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );
        var result = await _service.forgotPassword(
          email: emailForgotPassController.text.trim(),
        );
        Get.back();
        if (result is bool) {
          Get.toNamed(kVerifyScreenRoute);
          return;
        } else {
          showCustomSnackbar("Error", result.toString());
        }
      } catch (e) {
        Get.back();

        showCustomSnackbar("Error", e.toString());
      }
    }
  }

  void verifyOtp() async {
    if (otpCode.value.length != 4) {
      showCustomSnackbar('Error', 'Enter a valid 4 digit OTP code');
      return;
    } else {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        var result = await _service.verifyOTP(
          email: emailForgotPassController.text.trim(),
          otp: otpCode.value,
        );
        Get.back();
        if (result is bool) {
          Get.toNamed(kSetNewPassScreenRoute);
          return;
        } else {
          showCustomSnackbar("Error", result.toString());
        }
      } catch (e) {
        Get.back();
        showCustomSnackbar("Error", e.toString());
      }
    }
  }

  void newPassword() async {
    if (passwordForgotController.text.isEmpty ||
        passwordForgotConfirmController.text.isEmpty) {
      showCustomSnackbar('Error', 'All fields must be filled');
      return;
    }

    if (passwordForgotController.text != passwordForgotConfirmController.text) {
      showCustomSnackbar('Error', 'Passwords do not match');
      return;
    } else {
      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        var result = await _service.createNewPassword(
          email: passwordForgotConfirmController.text.trim(),
          newPassword: passwordForgotController.text.trim(),
        );
        Get.back();
        if (result is bool) {
          Get.offAllNamed(kAuthScreenRoute);
          showCustomSnackbar(
            "Success",
            "Password updated successfully",
            backgroundColor: Colors.green,
          );
          return;
        } else {
          showCustomSnackbar("Error", result.toString());
        }
      } catch (e) {
        Get.back();
        showCustomSnackbar("Error", e.toString());
      }
    }
  }
}
