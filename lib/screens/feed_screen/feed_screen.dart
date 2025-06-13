import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/custom_widgets/custom_dialog.dart';
import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/screens/user_screen/controller/user_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/field_container.dart';
import '../sidemenu/sidemenu.dart';

class FeedScreen extends GetView<UserController> {
  const FeedScreen({super.key});

  Widget requestContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kGreyShade13Color),
      ),
      child: Padding(
        padding: EdgeInsets.all(26.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 226.h,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 14.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 9,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Memona Channa",
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "12-2-2025",
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CustomButton(
                  title: "Donor",
                  onTap: () {},
                  color: kGreyShade5Color.withOpacity(0.22),
                  borderColor: kGreyShade5Color.withOpacity(0.22),
                  textColor: kPrimaryColor,
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  width: 60.w,
                  height: 33,
                ),
              ],
            ),
            SizedBox(height: 9.h),
            Text(
              "Big impact today — 100 kids received help, smiles, and support, all thanks to your kindness!",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 27.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Reject",
                    onTap: () {},
                    color: kGreyShade5Color.withOpacity(0.22),
                    borderColor: kGreyShade5Color.withOpacity(0.22),
                    textColor: kPrimaryColor,
                    textSize: 16,
                    fontWeight: FontWeight.w900,
                    height: 48.h,
                  ),
                ),
                SizedBox(width: 17.w),
                Expanded(
                  child: CustomButton(
                    title: "Approve",
                    onTap: () {},
                    textSize: 16,
                    fontWeight: FontWeight.w900,
                    height: 48.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget feedbackContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kGreyShade13Color),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.h,
          left: 27.w,
          right: 13.w,
          bottom: 37.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 29,
                  width: 66.w,
                  decoration: BoxDecoration(
                    color: kGreyShade13Color,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      "Applicant",
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: kGreyShade13Color),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(kAvatar1, fit: BoxFit.contain),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Zoya Channa",
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.h),
            Text(
              "Your support means the world to us. Every dollar you give brings someone closer to hope and opportunity. We’re truly grateful!",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "12-2-2025",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  createPostDialog() {
    return CustomDialog(
      width: 675.w,
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create new Post",
                    style: AppStyles.blackTextStyle().copyWith(fontSize: 20),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: kGreyShade7Color.withOpacity(0.11),
                              blurRadius: 22,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70.h),
              CustomTextField(
                hintText: "Type here...",
                maxLines: 8,
                borderRadius: 20,
                borderColor: kGreyShade13Color,
              ),
              SizedBox(height: 87.h),
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kPrimaryColor,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        kUploadIcon,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: CustomButton(
                      title: "Upload post",
                      onTap: () {},
                      height: 85,
                      textSize: 20,
                      fontWeight: FontWeight.w700,
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

  reportDialog() {
    return CustomDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 94),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reason: Violates community guidelines",
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kRedColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "This content might be offensive",
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kRedColor,
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: kRedColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(26.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 226.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            spacing: 9,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Memona Channa",
                                style: AppStyles.blackTextStyle().copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "12-2-2025",
                                style: AppStyles.blackTextStyle().copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          CustomButton(
                            title: "Donor",
                            onTap: () {},
                            color: kGreyShade5Color.withOpacity(0.22),
                            borderColor: kGreyShade5Color.withOpacity(0.22),
                            textColor: kPrimaryColor,
                            textSize: 14,
                            fontWeight: FontWeight.w600,
                            width: 60.w,
                            height: 33,
                          ),
                        ],
                      ),
                      SizedBox(height: 9.h),
                      Text(
                        "100 kids received help, smiles, and support, all thanks to your kindness!",
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 27.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              title: "Ban User",
                              onTap: () {
                                Get.back();
                              },
                              color: kGreyShade5Color.withOpacity(0.22),
                              borderColor: kGreyShade5Color.withOpacity(0.22),
                              textColor: kPrimaryColor,
                              textSize: 16,
                              fontWeight: FontWeight.w900,
                              height: 48.h,
                            ),
                          ),
                          SizedBox(width: 17.w),
                          Expanded(
                            child: CustomButton(
                              title: "Remove Post",
                              onTap: () {
                                Get.back();
                              },
                              textSize: 16,
                              fontWeight: FontWeight.w900,
                              height: 48.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                            PageHeader(pageName: "Community Feed"),
                            SizedBox(height: 19),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: kGreyShade9Color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(27),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 32.h,
                                      horizontal: 29.w,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Recent Added Posts",
                                              style: AppStyles.blackTextStyle()
                                                  .copyWith(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Spacer(),
                                            CustomButton(
                                              title: "+ Create new post",
                                              onTap: () {
                                                Get.dialog(createPostDialog());
                                              },
                                              height: 66.h,
                                              width: 180.w,
                                              color: kWhiteColor,
                                              borderColor: kGreyShade13Color,
                                              textColor: kPrimaryColor,
                                              textSize: 16,
                                            ),
                                            SizedBox(width: 7),
                                            CustomButton(
                                              title: "Moderation Queue",
                                              onTap: () {
                                                Get.dialog(reportDialog());
                                              },
                                              textSize: 18,
                                              fontWeight: FontWeight.w600,
                                              width: 235.w,
                                              height: 66.h,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.h),
                                        Row(
                                          children: [
                                            Expanded(child: requestContainer()),
                                            SizedBox(width: 24.w),
                                            Expanded(child: requestContainer()),
                                            SizedBox(width: 24.w),
                                            Expanded(child: requestContainer()),
                                          ],
                                        ),
                                        SizedBox(height: 25.h),
                                        Row(
                                          children: [
                                            Text(
                                              "Recent Feedback’s",
                                              style: AppStyles.blackTextStyle()
                                                  .copyWith(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: kGreyShade5Color,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  15,
                                                ),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      kCalendarIcon1,
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "12 December",
                                                      style: AppStyles.greyTextStyle()
                                                          .copyWith(
                                                            color:
                                                                kGreyShade5Color,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 25.h),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: feedbackContainer(),
                                            ),
                                            SizedBox(width: 24.w),
                                            Expanded(
                                              child: feedbackContainer(),
                                            ),
                                            SizedBox(width: 24.w),
                                            Expanded(
                                              child: feedbackContainer(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
