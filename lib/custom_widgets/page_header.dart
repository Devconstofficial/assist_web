import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';
import '../utils/app_styles.dart';
import 'dart:typed_data';

// ignore: must_be_immutable
class PageHeader extends StatefulWidget {
  String pageName;
  PageHeader({super.key, required this.pageName});

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  Uint8List? webImage;
  @override
  Widget build(BuildContext context) {
    Future<void> pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          webImage = bytes;
        });
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: kGreyShade9Color,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 24),
        child: Row(
          children: [
            Text(
              widget.pageName,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: Container(
                height: 68,
                width: 68,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child:
                    webImage != null
                        ? Image.memory(webImage!, fit: BoxFit.cover)
                        : Image.asset(kAvatar, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 7.w),
            Text(
              "Admin",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
