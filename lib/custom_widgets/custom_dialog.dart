import 'package:flutter/material.dart';
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
