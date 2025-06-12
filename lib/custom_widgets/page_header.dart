import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';
import '../utils/app_styles.dart';

class PageHeader extends StatelessWidget {
  String pageName;
  PageHeader({super.key,required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kGreyShade9Color,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 37,vertical: 28),
        child: Row(
          children: [
            Text(
              pageName,
              style: AppStyles.blackTextStyle()
                  .copyWith(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Container(
              height: 68,
              width: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.asset(
                kAvatar,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 7.w),
            Text(
              "Luckey ",
              style: AppStyles.blackTextStyle()
                  .copyWith(
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
