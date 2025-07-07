import 'package:assist_web/screens/subscription_screen/controller/subscription_controller.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubscriptionGraph extends StatelessWidget {
  final bool isMonthly;
  const SubscriptionGraph({super.key, required this.isMonthly});

  @override
  Widget build(BuildContext context) {
    final SubscriptionController controller = Get.find();
    final barData =
        controller.graphData
            .where((item) => (item['totalRevenue'] ?? 0) > 0)
            .toList()
            .asMap()
            .entries
            .map<_BarData>((entry) {
              final map = entry.value;
              final id = map['_id'] ?? '';
              final revenue = (map['totalRevenue'] ?? 0).toInt();

              String label = '';
              String tooltip = '\$${revenue.toString()}';

              try {
                if (isMonthly) {
                  final date = DateTime.parse(id);
                  label = DateFormat('MMM d').format(date);
                } else {
                  final date = DateFormat('yyyy-MM').parse(id);
                  label = DateFormat('MMM yyyy').format(date);
                }
              } catch (_) {
                label = id.toString();
              }

              return _BarData(
                label: label,
                value: revenue,
                isFilled: true,
                showTooltip: true,
                tooltipValue: tooltip,
              );
            })
            .toList();

    return Obx(() {
      if (controller.isLoadingRevenue.value) {
        return SizedBox(
          height: 300.h,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.isErrorRevenue.value) {
        return SizedBox(
          height: 300.h,
          child: Center(
            child: Text(
              controller.errorMsgRevenue.value,
              style: AppStyles.blackTextStyle().copyWith(color: Colors.red),
            ),
          ),
        );
      }

      if (barData.isEmpty) {
        return SizedBox(
          height: 300.h,
          child: Center(
            child: Text(
              'No data available.',
              style: AppStyles.blackTextStyle().copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
      return SizedBox(
        height: 300.h,
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: isMonthly ? 20 : 100,
                  getTitlesWidget: (value, meta) {
                    if (isMonthly && (value % 20 != 0 || value > 100)) {
                      return const SizedBox();
                    }
                    if (!isMonthly && (value % 100 != 0 || value > 600)) {
                      return const SizedBox();
                    }
                    return Text(
                      '\$${value.toInt()}',
                      style: AppStyles.blackTextStyle().copyWith(fontSize: 12),
                    );
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= barData.length) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        barData[index].label,
                        style: AppStyles.blackTextStyle().copyWith(
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups:
                barData.asMap().entries.map((entry) {
                  int index = entry.key;
                  final data = entry.value;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data.value.toDouble(),
                        width: 70,
                        borderRadius: BorderRadius.circular(20),
                        color: data.isFilled ? kBlackColor : kGreyShade15Color,
                      ),
                    ],
                  );
                }).toList(),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final data = barData[groupIndex];
                  return data.showTooltip
                      ? BarTooltipItem(
                        data.tooltipValue ?? '',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : null;
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _BarData {
  final String label;
  final int value;
  final bool isFilled;
  final bool showTooltip;
  final String? tooltipValue;

  _BarData({
    required this.label,
    required this.value,
    required this.isFilled,
    this.showTooltip = false,
    this.tooltipValue,
  });
}
