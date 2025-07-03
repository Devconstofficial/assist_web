import 'package:assist_web/utils/app_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  const CustomErrorWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: AppStyles.blackTextStyle().copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
