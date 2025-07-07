import 'package:assist_web/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomReloadWidget extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  const CustomReloadWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: kWhiteColor,
      color: kPrimaryColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
