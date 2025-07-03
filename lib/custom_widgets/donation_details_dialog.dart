import 'package:assist_web/models/subscription_model.dart';
import 'package:assist_web/screens/subscription_screen/controller/subscription_controller.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_images.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';

class DonationDetailsDialog extends StatefulWidget {
  final SubscriptionModel subs;
  const DonationDetailsDialog({super.key, required this.subs});

  @override
  State<DonationDetailsDialog> createState() => _DonationDetailsDialogState();
}

class _DonationDetailsDialogState extends State<DonationDetailsDialog> {
  final SubscriptionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
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
                    "Donation Details",
                    style: AppStyles.blackTextStyle().copyWith(fontSize: 22.sp),
                  ),
                ],
              ),

              Column(
                children: [
                  SizedBox(height: 33.h),
                  Obx(
                    () => CircleAvatar(
                      radius: 50,
                      backgroundColor: kGreyColor,
                      child: ClipOval(
                        child: ImageNetwork(
                          image: widget.subs.user.userImage,
                          height: 100,
                          width: 100,
                          fitWeb: BoxFitWeb.cover,
                          fitAndroidIos: BoxFit.cover,
                          onLoading: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                          onError: Image.asset(kDummyImg, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 55.h),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kGreyShade13Color),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 35.h,
                        bottom: 35.h,
                        left: 18.0.w,
                        right: 65.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 18.h,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Total Amount Donated",
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${widget.subs.amount}",
                                style: AppStyles.blackTextStyle().copyWith(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 31.h),
                  Container(
                    padding: EdgeInsets.only(left: (20), bottom: (14)),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kGreyShade3Color.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: (30),
                                  width: (33),
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: kGreyShade1Color),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      kDashboardIcon,
                                      height: (13),
                                      width: (16),
                                    ),
                                  ),
                                ),
                                SizedBox(width: (4)),
                                Text(
                                  widget.subs.type,
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: (42),
                              width: (102),
                              decoration: BoxDecoration(
                                color: kBlackColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(13),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "\$${widget.subs.amount}/month",
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: (11)),
                        Padding(
                          padding: EdgeInsets.only(right: (20)),
                          child: Divider(
                            color: kBlackColor.withOpacity(0.12),
                            height: 0,
                          ),
                        ),
                        SizedBox(height: (6)),
                        Text(
                          "Help more people with a little extra support.",
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
