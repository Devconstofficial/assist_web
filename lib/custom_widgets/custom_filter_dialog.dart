import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/custom_widgets/custom_textfield.dart';
import 'package:assist_web/screens/application_screen/controller/application_controller.dart';
import 'package:assist_web/screens/post_screen/controller/post_controller.dart';
import 'package:assist_web/screens/user_screen/controller/user_controller.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomFilterDialog extends StatefulWidget {
  final String type;
  final bool isUser;
  const CustomFilterDialog({
    super.key,
    required this.type,
    this.isUser = false,
  });

  @override
  State<CustomFilterDialog> createState() => _CustomFilterDialogState();
}

class _CustomFilterDialogState extends State<CustomFilterDialog> {
  final ApplicationController controller = Get.find();
  final UserController userController = Get.find();
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 521.w,
        height: widget.type == "Name" ? 400.h : 300.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filter by ${widget.type}",
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 24.h),
              if (widget.type == "Role")
                Wrap(
                  spacing: 8.w,
                  runSpacing: 20.h,
                  children:
                      ['Applicant', 'Donor'].map((item) {
                        return GestureDetector(
                          onTap: () {
                            userController.selectedRole.value = item;
                            userController.selectedRole.refresh();
                          },
                          child: Obx(
                            () => Container(
                              height: 46.h,
                              width: 125.w,
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color:
                                      userController.selectedRole.value == item
                                          ? kPrimaryColor
                                          : kGreyShade13Color,
                                ),
                                color:
                                    userController.selectedRole.value == item
                                        ? kPrimaryColor
                                        : kGreyShade5Color.withOpacity(0.22),
                              ),
                              child: Center(
                                child: Text(
                                  item,
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        userController.selectedRole.value ==
                                                item
                                            ? kWhiteColor
                                            : kBlackColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              if (widget.type == "Status")
                Wrap(
                  spacing: 8.w,
                  runSpacing: 20.h,
                  children:
                      ['Approved', 'Rejected'].map((item) {
                        return GestureDetector(
                          onTap: () {
                            postController.selectedRole.value = item;
                          },
                          child: Obx(
                            () => Container(
                              height: 46.h,
                              width: 125.w,
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color:
                                      (postController.selectedRole.value) ==
                                              item
                                          ? kPrimaryColor
                                          : kGreyShade13Color,
                                ),
                                color:
                                    (postController.selectedRole.value) == item
                                        ? kPrimaryColor
                                        : kGreyShade5Color.withOpacity(0.22),
                              ),
                              child: Center(
                                child: Text(
                                  item,
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        (postController.selectedRole.value) ==
                                                item
                                            ? kWhiteColor
                                            : kBlackColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),

              if (widget.type == "Bill Type")
                Wrap(
                  spacing: 8.w,
                  runSpacing: 20.h,
                  children:
                      ['Utility', 'Rent', 'Others'].map((item) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectedBillType.value = item;
                            controller.selectedBillType.refresh();
                          },
                          child: Obx(
                            () => Container(
                              height: 46.h,
                              width: 125.w,
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color:
                                      controller.selectedBillType.value == item
                                          ? kPrimaryColor
                                          : kGreyShade13Color,
                                ),
                                color:
                                    controller.selectedBillType.value == item
                                        ? kPrimaryColor
                                        : kGreyShade5Color.withOpacity(0.22),
                              ),
                              child: Center(
                                child: Text(
                                  item,
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        controller.selectedBillType.value ==
                                                item
                                            ? kWhiteColor
                                            : kBlackColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              if (widget.type == "Name") ...[
                CustomTextField(
                  controller:
                      widget.type == "Name" && widget.isUser == true
                          ? userController.searchController
                          : controller.searchController,
                  hintText: "Search user name here",
                  borderRadius: 24,
                  isFilled: true,
                  prefix: Icon(Icons.search),
                  fillColor: kGreyShade5Color,
                  hintColor: kBlackColor,
                  onChanged: (p0) {
                    if (widget.type == "Name" && widget.isUser == true) {
                      userController.searchNameQuery.value = p0;
                    } else {
                      controller.searchNameQuery.value = p0;
                    }
                  },
                ),
                SizedBox(height: 24.h),
              ],
              if (widget.type == "Name")
                Wrap(
                  spacing: 8.w,
                  runSpacing: 20.h,
                  children:
                      ['A - Z', 'Z - A'].map((item) {
                        return GestureDetector(
                          onTap: () {
                            if (widget.type == "Name" &&
                                widget.isUser == true) {
                              userController.selectedFilter.value = item;
                            } else {
                              controller.selectedFilter.value = item;
                            }
                          },
                          child: Obx(
                            () => Container(
                              height: 46.h,
                              width: 125.w,
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color:
                                      controller.selectedFilter.value == item ||
                                              userController
                                                      .selectedFilter
                                                      .value ==
                                                  item
                                          ? kPrimaryColor
                                          : kGreyShade13Color,
                                ),
                                color:
                                    controller.selectedFilter.value == item ||
                                            userController
                                                    .selectedFilter
                                                    .value ==
                                                item
                                        ? kPrimaryColor
                                        : kGreyShade5Color.withOpacity(0.22),
                              ),
                              child: Center(
                                child: Text(
                                  item,
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        controller.selectedFilter.value ==
                                                    item ||
                                                userController
                                                        .selectedFilter
                                                        .value ==
                                                    item
                                            ? kWhiteColor
                                            : kBlackColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              SizedBox(height: 30.h),
              Divider(thickness: 0.4, color: kGreyShade3Color),
              SizedBox(height: 24.h),
              Center(
                child: CustomButton(
                  height: 40,
                  width: 129,
                  textSize: 12,
                  borderRadius: 8,
                  title: "Apply Filter",
                  onTap: () {
                    Get.back();
                    if (widget.type == "Bill Type") {
                      controller.filterApplications();
                     } else if (widget.type == "Status") {
                      postController.filterPosts();
                    }
                     else if (widget.type == "Role") {
                      userController.filterUsers();
                    } else if (widget.type == "Name" && widget.isUser == true) {
                      userController.filterUsers();
                    } else {
                      controller.filterApplications();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
