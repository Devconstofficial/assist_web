import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionGraph extends StatelessWidget {
  final bool isMonthly;
  const SubscriptionGraph({super.key, required this.isMonthly});

  @override
  Widget build(BuildContext context) {
    final monthlyData = [
      _BarData(label: 'Jan', value: 70, isFilled: false),
      _BarData(label: 'Feb', value: 100, isFilled: true, showTooltip: true, tooltipValue: '\$12,000'),
      _BarData(label: 'Mar', value: 70, isFilled: false),
      _BarData(label: 'Apr', value: 85, isFilled: true),
      _BarData(label: 'May', value: 60, isFilled: false),
      _BarData(label: 'Jun', value: 50, isFilled: true),
    ];

    final yearlyData = [
      _BarData(label: '2020', value: 320, isFilled: false),
      _BarData(label: '2021', value: 450, isFilled: true, showTooltip: true, tooltipValue: '\$45,000'),
      _BarData(label: '2022', value: 400, isFilled: false),
      _BarData(label: '2023', value: 520, isFilled: true),
      _BarData(label: '2024', value: 460, isFilled: false),
    ];

    final barData = isMonthly ? monthlyData : yearlyData;

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
                  if (isMonthly && (value % 20 != 0 || value > 100)) return const SizedBox();
                  if (!isMonthly && (value % 100 != 0 || value > 600)) return const SizedBox();
                  return Text(
                    '\$${value.toInt()}',
                    style: AppStyles.blackTextStyle().copyWith(fontSize: 12),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= barData.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      barData[index].label,
                      style: AppStyles.blackTextStyle().copyWith(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: barData.asMap().entries.map((entry) {
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
