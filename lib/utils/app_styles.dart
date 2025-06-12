import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle blackTextStyle() => GoogleFonts.lato(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: kBlackTextColor,
  );
  static TextStyle whiteTextStyle() => GoogleFonts.lato(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: kWhiteColor,
  );
  static TextStyle greyTextStyle() => GoogleFonts.lato(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: kGreyShade1Color,
  );

  static BorderRadius get customBorder16=> BorderRadius.all(
    Radius.circular(16.r),
  );
}


