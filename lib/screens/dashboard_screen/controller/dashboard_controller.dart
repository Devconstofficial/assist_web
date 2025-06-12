import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';

class DashboardController extends GetxController {
  RxString selectedOption = "".obs;
  List<String> options = ["Last 7 days", "Monthly", "Yearly"];
  void selectOption(String option) {
    selectedOption.value = option;
  }

  final yInterval = 20;

  var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'].obs;

  var completedSpots = <FlSpot>[
    FlSpot(0, 20),
    FlSpot(1, 25),
    FlSpot(2, 60),
    FlSpot(3, 55),
    FlSpot(4, 50),
    FlSpot(5, 58),
    FlSpot(6, 70),
  ].obs;

  LineChartBarData get completedLine => LineChartBarData(
    spots: completedSpots,
    isCurved: true,
    color: kBlackColor,
    barWidth: 2,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
  );

  List<LineChartBarData> get lineBars => [completedLine];

  var isMonthly = true.obs;
  var isMonthly1 = true.obs;

  void selectMonthly() => isMonthly.value = true;
  void selectMonthly1() => isMonthly1.value = true;
  void selectYearly() => isMonthly.value = false;
  void selectYearly1() => isMonthly1.value = false;

}