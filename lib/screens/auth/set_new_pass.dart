import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/auth_component.dart';
import '../../custom_widgets/custom_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import 'controller/auth_controller.dart';

class SetNewPassScreen extends GetView<AuthController> {
  const SetNewPassScreen({super.key});

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
                kSetNewPassword,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                kEnterNewPassword,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: kGreyShade3Color,
                ),
              ),
              SizedBox(height: 56.h),
              Obx(
                () => TextField(
                  controller: controller.passwordForgotController,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  obscuringCharacter: '•',
                  obscureText: controller.isPasswordHidden1.value,
                  keyboardType: TextInputType.visiblePassword,

                  decoration: InputDecoration(
                    hintText: kNewPassword,
                    hintStyle: AppStyles.blackTextStyle().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kGreyShade3Color,
                    ),
                    fillColor: kGreyShade5Color.withOpacity(0.22),
                    filled: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SvgPicture.asset(kLockIcon, height: 24, width: 24),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        icon: Icon(
                          controller.isPasswordHidden1.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kGreyShade3Color,
                        ),
                        onPressed: controller.togglePasswordVisibility1,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 27.h),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: kGreyShade5Color.withOpacity(0.22),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: kPrimaryColor, width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: kGreyShade5Color.withOpacity(0.22),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Obx(
                () => TextField(
                  controller: controller.passwordForgotConfirmController,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  obscuringCharacter: '•',
                  obscureText: controller.isPasswordHidden2.value,
                  keyboardType: TextInputType.visiblePassword,

                  decoration: InputDecoration(
                    hintText: kConfirmNewPassword,
                    hintStyle: AppStyles.blackTextStyle().copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kGreyShade3Color,
                    ),
                    fillColor: kGreyShade5Color.withOpacity(0.22),
                    filled: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SvgPicture.asset(kLockIcon, height: 24, width: 24),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        icon: Icon(
                          controller.isPasswordHidden2.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kGreyShade3Color,
                        ),
                        onPressed: controller.togglePasswordVisibility2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 27.h),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: kGreyShade5Color.withOpacity(0.22),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(color: kPrimaryColor, width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: kGreyShade5Color.withOpacity(0.22),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80.h),
              CustomButton(
                width: MediaQuery.of(context).size.width,
                title: kUpdatePassword,
                color: kPrimaryColor,
                borderColor: kPrimaryColor,
                onTap: () {
                  controller.newPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
