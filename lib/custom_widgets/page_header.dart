import 'package:assist_web/custom_widgets/update_details_dialog.dart';
import 'package:assist_web/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_styles.dart';

// ignore: must_be_immutable
class PageHeader extends StatefulWidget {
  String pageName;
  PageHeader({super.key, required this.pageName});

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  final DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
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
            Obx(
              () =>
                  controller.userData.value.userId.isEmpty
                      ? SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(child: CircularProgressIndicator()),
                      )
                      : ClipOval(
                        child: ImageNetwork(
                          image: controller.userData.value.userImage,
                          height: 100,
                          width: 100,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => UpdateDetailsDialog(),
                            );
                          },
                          fitWeb: BoxFitWeb.cover,
                          fitAndroidIos: BoxFit.cover,
                          onLoading: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                          onError: Image.asset(kDummyImg, fit: BoxFit.cover),
                        ),
                      ),
            ),
            SizedBox(width: 7.w),
            Obx(
              () => Text(
                controller.userData.value.name,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
