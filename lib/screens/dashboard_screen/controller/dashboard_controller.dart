import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isMonthly = true.obs;
  var isMonthly1 = true.obs;
  var selectedStatus = 'Submitted'.obs;

  void updateStatus(String status) {
    selectedStatus.value = status;
  }

  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  var currentMonthDates = <String>[].obs;

  var completedSpots = <FlSpot>[].obs;
  var completedSpots1 = <FlSpot>[].obs;

  final Random _random = Random();

  void selectMonthly() {
    isMonthly.value = true;
    _generateCurrentMonthDates();
    completedSpots.value = _getIrregularMonthlyData();
  }

  void selectMonthly1() {
    isMonthly1.value = true;
    _generateCurrentMonthDates(); // ensure both use same date base
    completedSpots1.value = _getIrregularMonthlyData1();
  }

  void _generateCurrentMonthDates() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    currentMonthDates.value = List.generate(daysInMonth, (i) => '${i + 1}');
  }

  List<FlSpot> _getIrregularMonthlyData() {
    final days = currentMonthDates.length;
    return List.generate(days, (i) {
      final y = 30 + _random.nextInt(40); // values between 30-70
      return FlSpot(i.toDouble(), y.toDouble());
    });
  }

  List<FlSpot> _getIrregularMonthlyData1() {
    final days = currentMonthDates.length;
    return List.generate(days, (i) {
      final y = 20 + _random.nextInt(60); // values between 20-80
      return FlSpot(i.toDouble(), y.toDouble());
    });
  }

  List<FlSpot> _getMonthlyData() {
    final days = currentMonthDates.length;
    return List.generate(
      days,
      (i) => FlSpot(i.toDouble(), (10 + i * 2) % 60 + 10),
    );
  }

  List<FlSpot> _getMonthlyData1() {
    final days = currentMonthDates.length;
    return List.generate(
      days,
      (i) => FlSpot(i.toDouble(), (15 + i * 3) % 70 + 5),
    );
  }

  void selectYearly() {
    isMonthly.value = false;
    completedSpots.value = _getYearlyData();
  }

  void selectYearly1() {
    isMonthly1.value = false;
    completedSpots1.value = _getYearlyData1();
  }

  List<FlSpot> _getYearlyData() {
    return [
      FlSpot(0, 25),
      FlSpot(1, 40),
      FlSpot(2, 35),
      FlSpot(3, 30),
      FlSpot(4, 45),
      FlSpot(5, 80),
      FlSpot(6, 65),
      FlSpot(7, 70),
      FlSpot(8, 55),
      FlSpot(9, 58),
      FlSpot(10, 60),
      FlSpot(11, 85),
    ];
  }

  List<FlSpot> _getYearlyData1() {
    return [
      FlSpot(0, 80),
      FlSpot(1, 75),
      FlSpot(2, 65),
      FlSpot(3, 70),
      FlSpot(4, 55),
      FlSpot(5, 60),
      FlSpot(6, 50),
      FlSpot(7, 45),
      FlSpot(8, 40),
      FlSpot(9, 35),
      FlSpot(10, 30),
      FlSpot(11, 25),
    ];
  }

  @override
  void onInit() {
    super.onInit();
    selectMonthly(); // Default
    selectMonthly1(); // Default
  }
}
