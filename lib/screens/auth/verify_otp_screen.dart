import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../utils/app_strings.dart';
import 'controller/auth_controller.dart';

class VerifyOtpScreen extends GetView<AuthController> {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthComponent(
        withBackButton: true,
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: kWhiteColor,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              Text(
                kVerifyOtp,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                kOtpInstruction,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16,
                  color: kGreyShade3Color,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 56.h),
              OTPTextField(
                controller: controller.code,
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.center,
                fieldWidth: 70.w,
                margin: EdgeInsets.only(left: 16),
                otpFieldStyle: OtpFieldStyle(
                  enabledBorderColor: kGreyShade5Color.withOpacity(0.22),
                  borderColor: kGreyShade3Color,
                  focusBorderColor: kPrimaryColor,
                  disabledBorderColor: kGreyShade5Color.withOpacity(0.22),
                  backgroundColor: kGreyShade5Color.withOpacity(0.22),
                ),
                fieldStyle: FieldStyle.box,
                contentPadding: EdgeInsets.symmetric(vertical: 25.h),
                outlineBorderRadius: 16.r,
                style: const TextStyle(fontSize: 17, color: kBlackColor),
                onChanged: (pin) {},
                onCompleted: (pin) async {
                  controller.otpCode.value = pin;
                },
              ),
              SizedBox(height: 25.h),
              Center(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      kResendCode,
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 92.h),
              CustomButton(
                width: MediaQuery.of(context).size.width,
                title: kContinue,
                color: kPrimaryColor,
                borderColor: kPrimaryColor,
                onTap: () {
                  controller.verifyOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
