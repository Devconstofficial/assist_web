import 'package:assist_web/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AuthComponent(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(kWelcomeBack,style: AppStyles.blackTextStyle().copyWith(fontSize: 34.sp,fontWeight: FontWeight.w700,),),
              SizedBox(height: 8),
              Text(
                kLoginDetail,
                style: AppStyles.blackTextStyle().
                copyWith(fontSize: 18.sp,color: kGreyShade6Color),),
              SizedBox(height: 57),
              CustomTextField(hintText: "debra.holt@example.com",prefix: SvgPicture.asset(kMailIcon,height: 24,width: 24,),fillColor: kGreyShade5Color.withOpacity(0.22),isFilled: true,),
              SizedBox(height: 18),
              Obx(
                    () => TextField(
                      style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      ),
                      obscuringCharacter: '•',
                      obscureText: controller.isPasswordHidden.value,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: kPassword,
                        hintStyle: AppStyles.blackTextStyle().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          color: kGreyShade3Color
                        ),
                        fillColor: kGreyShade5Color.withOpacity(0.22),
                        filled: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: SvgPicture.asset(kLockIcon,height: 24,width: 24,),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: kGreyShade3Color,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 27.h),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: kGreyShade5Color.withOpacity(0.22), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: kPrimaryColor, width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: kGreyShade5Color.withOpacity(0.22), width: 1),
                        ),
                      ),
                    ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Get.toNamed(kSendOtpScreenRoute);
                    },
                    child: Text(
                      kForgotPassword,
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              CustomButton(
                width: MediaQuery.of(context).size.width,
                title: kSignIn,
                color: kPrimaryColor,
                borderColor: kPrimaryColor,
                onTap: () {
                  Get.toNamed(kDashboardScreenRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
