import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/custom_widgets/custom_error_widget.dart';
import 'package:assist_web/custom_widgets/custom_textfield.dart';
import 'package:assist_web/screens/user_screen/controller/user_controller.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_images.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';

class UserDetailDialog extends StatefulWidget {
  final String id;
  const UserDetailDialog({super.key, required this.id});

  @override
  State<UserDetailDialog> createState() => _UserDetailDialogState();
}

class _UserDetailDialogState extends State<UserDetailDialog> {
  final UserController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getSpcificUser(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        height: double.infinity,
        width: 457.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 55.h),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlackTextColor5, width: 0.5),
                      ),
                      child: Center(child: Icon(Icons.arrow_back)),
                    ),
                  ),
                  SizedBox(width: 11.w),
                  Text(
                    "Profile Details",
                    style: AppStyles.blackTextStyle().copyWith(fontSize: 22.sp),
                  ),
                ],
              ),
              Obx(
                () =>
                    controller.isLoadingUser.value
                        ? Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        )
                        : controller.isErrorUser.value
                        ? Expanded(
                          child: CustomErrorWidget(
                            title: controller.errorMsgUser.value,
                          ),
                        )
                        : controller.user.value.userId.isEmpty
                        ? Expanded(
                          child: CustomErrorWidget(title: "No data found"),
                        )
                        : Column(
                          children: [
                            SizedBox(height: 33.h),
                            Obx(
                              () => CircleAvatar(
                                radius: 50,
                                backgroundColor: kGreyColor,
                                child: ClipOval(
                                  child: ImageNetwork(
                                    image: controller.user.value.userImage,
                                    height: 100,
                                    width: 100,
                                    fitWeb: BoxFitWeb.cover,
                                    fitAndroidIos: BoxFit.cover,
                                    onLoading: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                    onError: Image.asset(
                                      kDummyImg,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.h),
                            CustomTextField(
                              controller: TextEditingController(
                                text: controller.user.value.name,
                              ),
                              hintText: 'Name',
                              readOnly: true,
                              fillColor: kGreyShade5Color.withOpacity(0.22),
                              isFilled: true,
                            ),
                            SizedBox(height: 21.h),
                            CustomTextField(
                              controller: TextEditingController(
                                text: controller.user.value.email,
                              ),
                              hintText: 'Email',
                              readOnly: true,
                              fillColor: kGreyShade5Color.withOpacity(0.22),
                              isFilled: true,
                            ),
                            SizedBox(height: 21.h),
                            CustomTextField(
                              controller: TextEditingController(
                                text: controller.user.value.phoneNumber,
                              ),
                              hintText: 'Phone number',
                              readOnly: true,
                              fillColor: kGreyShade5Color.withOpacity(0.22),
                              isFilled: true,
                            ),
                            SizedBox(height: 150.h),

                            CustomButton(
                              height: 61,
                              title:
                                  controller.user.value.blocked == false
                                      ? "Block ${controller.user.value.roles.isNotEmpty && controller.user.value.roles.last == "applicant" ? "User" : "Donar"}"
                                      : "Unblock ${controller.user.value.roles.isNotEmpty && controller.user.value.roles.last == "applicant" ? "User" : "Donar"}",
                              onTap: () {
                                if (controller.user.value.blocked == false) {
                                  controller.blockUser(widget.id);
                                } else {
                                  controller.unblockUser(widget.id);
                                }
                              },
                            ),
                            SizedBox(height: 15.h),
                            CustomButton(
                              height: 61,
                              color: kGreyShade13Color,
                              textColor: kBlackColor,
                              borderColor: kGreyShade13Color,
                              title: "Cancel",
                              onTap: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
