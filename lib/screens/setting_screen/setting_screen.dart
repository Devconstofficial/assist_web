import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/screens/setting_screen/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // CommonCode.unFocus(context);
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SideMenu(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 23.h,
                          right: 59.w,
                          bottom: 32.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PageHeader(pageName: "Setting"),
                            SizedBox(height: 19),
                            Container(
                              width: width,
                              height: Get.height / 1.24,
                              decoration: BoxDecoration(
                                color: kGreyShade9Color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 62.h,horizontal: 76.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Your Profile Picture",style: AppStyles.blackTextStyle().copyWith(fontSize: 16.sp,fontWeight: FontWeight.w500),),
                                    SizedBox(height: 13,),
                                    Obx(() {
                                      return MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: controller.pickFromGallery,
                                          child: Container(
                                            height: 130,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                              border: Border.all(color: kGreyShade14Color),
                                            ),
                                            child: controller.pickedImage.value != null
                                                ? ClipRRect(
                                              borderRadius: BorderRadius.circular(18),
                                              child: Image.memory(
                                                controller.pickedImage.value!,
                                                fit: BoxFit.cover,
                                                width: 130,
                                                height: 130,
                                              ),
                                            )
                                                : Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              spacing: 15.h,
                                              children: [
                                                SvgPicture.asset(kGalleryIcon, height: 36, width: 36),
                                                Text(
                                                  "Upload your\nphoto",
                                                  style: AppStyles.blackTextStyle().copyWith(
                                                    fontSize: 12.sp,
                                                    color: kGreyShade14Color,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 38,),
                                    Padding(
                                      padding: EdgeInsets.only(right: 100.w),
                                      child: Row(
                                        children: [
                                          Expanded(child: CustomTextField(hintText: "debra.holt@example.com",prefix: SvgPicture.asset(kMailIcon,height: 24,width: 24,),fillColor: kWhiteColor,isFilled: true,)),
                                          SizedBox(width: 30.w,),
                                          Expanded(
                                            child: Obx(
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
                                                  fillColor: kWhiteColor,
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
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
