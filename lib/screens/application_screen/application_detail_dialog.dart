import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/custom_widgets/custom_textfield.dart';
import 'package:assist_web/models/application_model.dart';
import 'package:assist_web/screens/application_screen/controller/application_controller.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_images.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationDetailDialog extends StatefulWidget {
  final ApplicationModel application;
  const ApplicationDetailDialog({super.key, required this.application});

  @override
  State<ApplicationDetailDialog> createState() =>
      _ApplicationDetailDialogState();
}

class _ApplicationDetailDialogState extends State<ApplicationDetailDialog> {
  final ApplicationController controller = Get.find();

  bool isPdfUrl(String url) {
    try {
      Uri uri = Uri.parse(url);
      String path = Uri.decodeFull(uri.path);
      String filename = path.split('/').last;
      return filename.toLowerCase().endsWith('.pdf');
    } catch (e) {
      return false;
    }
  }

  Future<void> openInNewTab(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.selectedStatus.value = widget.application.status;
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          border: Border.all(
                            color: kBlackTextColor5,
                            width: 0.5,
                          ),
                        ),
                        child: Center(child: Icon(Icons.arrow_back)),
                      ),
                    ),
                    SizedBox(width: 11.w),
                    Text(
                      "Application Details",
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 22.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 34.h),
                Text(
                  "Bill Type",
                  style: AppStyles.blackTextStyle().copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  controller: TextEditingController(
                    text: widget.application.billCategory,
                  ),
                  hintText: 'type',
                  readOnly: true,
                  fillColor: kGreyShade5Color.withOpacity(0.22),
                  isFilled: true,
                ),
                SizedBox(height: 14.h),
                Text(
                  "Reason",
                  style: AppStyles.blackTextStyle().copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  maxLines: 4,
                  borderRadius: 12,
                  controller: TextEditingController(
                    text: widget.application.reason,
                  ),
                  hintText: 'reason',
                  readOnly: true,
                  fillColor: kGreyShade5Color.withOpacity(0.22),
                  isFilled: true,
                ),
                SizedBox(height: 24.h),
                Text(
                  "Contact Information",
                  style: AppStyles.blackTextStyle().copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  controller: TextEditingController(
                    text: widget.application.user.name,
                  ),
                  hintText: 'Name',
                  readOnly: true,
                  fillColor: kGreyShade5Color.withOpacity(0.22),
                  isFilled: true,
                ),
                SizedBox(height: 21.h),
                CustomTextField(
                  controller: TextEditingController(
                    text: widget.application.user.email,
                  ),
                  hintText: 'Email',
                  readOnly: true,
                  fillColor: kGreyShade5Color.withOpacity(0.22),
                  isFilled: true,
                ),

                SizedBox(height: 24.h),
                Text(
                  "Application Bill",
                  style: AppStyles.blackTextStyle().copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: (95),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kGreyShade3Color.withOpacity(0.22),
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(kPdf1Icon, height: (34), width: (34)),
                          SizedBox(width: (10)),
                          SizedBox(
                            width: (160),
                            child: Text(
                              "bill slip",
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        height: 34,
                        width: 85,
                        borderRadius: 100,
                        textColor: kBlackColor,
                        borderColor: kGreyColor,
                        color: Colors.transparent,
                        textSize: 14,
                        title: 'Open',
                        onTap: () {
                          if (isPdfUrl(widget.application.billFile)) {
                            openInNewTab(widget.application.billFile);
                          } else {
                            controller.openImage(widget.application.billFile);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  "Application Stats",
                  style: AppStyles.blackTextStyle().copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: 24.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 20.h,
                  children:
                      [
                        'Submitted',
                        'In Pool',
                        'Selected',
                        'Paid',
                        'Denied',
                      ].map((item) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectedStatus.value = item;
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
                                      controller.selectedStatus.value == item
                                          ? kPrimaryColor
                                          : kGreyShade13Color,
                                ),
                                color:
                                    controller.selectedStatus.value == item
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
                                        controller.selectedStatus.value == item
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
                SizedBox(height: 150.h),
                CustomButton(
                  height: 61,
                  title: "Update",
                  onTap: () {
                    controller.updateStatus(widget.application.applicationId);
                  },
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
