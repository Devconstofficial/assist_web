import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';

class CustomDialog extends StatelessWidget {
  final Widget content;
  final double? width;

  const CustomDialog({
    super.key,
    required this.content,
    this.width = 421,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none
      ),
      backgroundColor: kWhiteColor,
      child: SizedBox(
        width: width,
          child: content
      ),
    );
  }
}
