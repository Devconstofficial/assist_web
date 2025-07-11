import 'package:assist_web/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DonorMetricsChart extends StatelessWidget {
  final double selectedPercentage;

  const DonorMetricsChart({super.key, required this.selectedPercentage});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Donor Metrics",
          style: AppStyles.blackTextStyle().copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: kBlackColor,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 220.h,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -120,
                  sections: [
                    PieChartSectionData(
                      color: kBlackColor,
                      value: selectedPercentage,
                      radius: 48,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      color: kGreyShade10Color,
                      value: 100 - selectedPercentage,
                      radius: 48,
                      showTitle: false,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "${selectedPercentage.toInt()}%",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Obx(
              () => Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.isDenied.value = true;
                    },
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color:
                            controller.isDenied.value
                                ? Colors.black
                                : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Denied"),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Obx(
              () => Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.isDenied.value = false;
                    },
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color:
                            controller.isDenied.value
                                ? Colors.grey.shade400
                                : Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Selected"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
