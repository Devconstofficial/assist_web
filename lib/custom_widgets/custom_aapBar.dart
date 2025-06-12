import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

AppBar customAppBar({required String title}) {
  return AppBar(
    backgroundColor: kWhiteColor,
    surfaceTintColor: kWhiteColor,
    centerTitle: true,
    leading: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Icon(
        Icons.arrow_back_ios_new,
        color: kBlackTextColor,
        size: 18.sp,
      ),
    ),
    title: Text(
      title,
      style: AppStyles.blackTextStyle().copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
