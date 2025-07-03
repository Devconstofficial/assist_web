import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import 'controller/auth_controller.dart';

class SendOtpScreen extends GetView<AuthController> {
  const SendOtpScreen({super.key});

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
              SizedBox(height: 28),
              Text(
                kResetPassword,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                kResetPasswordInstruction,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kGreyShade3Color,
                ),
              ),
              SizedBox(height: 56.h),
              CustomTextField(
                controller: controller.emailForgotPassController,
                hintText: "debra.holt@example.com",
                prefix: SvgPicture.asset(kMailIcon, height: 24, width: 24),
                fillColor: kGreyShade5Color.withOpacity(0.22),
                isFilled: true,
              ),
              SizedBox(height: 100.h),
              CustomButton(
                width: MediaQuery.of(context).size.width,
                title: kSendLink,
                color: kPrimaryColor,
                borderColor: kPrimaryColor,
                onTap: () {
                  controller.forgotPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
