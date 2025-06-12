import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool isObscure;
  final double width;
  final Color borderColor;
  final Color hintColor;
  final bool isStyle;
  final TextInputType textInputType;
  final bool readOnly;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? suffixText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final bool isFilled;
  final Color fillColor;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    required this.hintText,
    this.isObscure = false,
    this.width = double.infinity,
    this.borderColor = kPrimaryColor,
    this.fillColor = kWhiteColor,
    this.isFilled = false,
    this.hintColor = kGreyShade1Color,
    this.isStyle = false,
    this.textInputType = TextInputType.text,
    this.readOnly = false,
    this.suffix,
    this.suffixText,
    this.prefix,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
    this.borderRadius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(borderRadius),
        // boxShadow: [
        //   BoxShadow(
        //     color: kGreyShade4Color.withOpacity(0.24),
        //     offset: const Offset(0, 1),
        //     blurRadius: 2,
        //     spreadRadius: 0,
        //   ),
        // ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        focusNode: focusNode,
        obscureText: isObscure,
        readOnly: readOnly,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        onTap: onTap,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 27.h),
          hintText: hintText,
          hintStyle: AppStyles.greyTextStyle().copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: hintColor,
          ),
          suffixIcon: suffix,
          filled: isFilled,
          fillColor: isFilled ? fillColor : Colors.transparent,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: prefix,
          ),
          suffix: suffixText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: kGreyShade5Color.withOpacity(0.22), width: 1),
          ),
        ),
        style: GoogleFonts.lato(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: kBlackTextColor,
        ),
      ),
    );
  }
}
