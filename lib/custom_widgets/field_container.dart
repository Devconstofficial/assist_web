import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

Widget fieldContainer(text,){
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
      color: kGreyShade5Color.withOpacity(0.22),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 32.w),
      child: Text(text,style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 18),),
    ),
  );
}
