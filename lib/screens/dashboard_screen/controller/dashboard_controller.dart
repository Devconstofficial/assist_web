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
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  final List<String> weekDays = [
    "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
  ];

  // Chart Data
  var completedSpots = <FlSpot>[].obs;
  var completedSpots1 = <FlSpot>[].obs;

  // Toggle Functions
  void selectMonthly() {
    isMonthly.value = true;
    completedSpots.value = _getWeeklyData(); // 7 points
  }

  void selectYearly() {
    isMonthly.value = false;
    completedSpots.value = _getYearlyData(); // 12 points
  }

  void selectMonthly1() {
    isMonthly1.value = true;
    completedSpots1.value = _getWeeklyData1();
  }

  void selectYearly1() {
    isMonthly1.value = false;
    completedSpots1.value = _getYearlyData1();
  }

  // Chart Data Samples
  List<FlSpot> _getWeeklyData() {
    return [
      FlSpot(0, 10),
      FlSpot(1, 20),
      FlSpot(2, 30),
      FlSpot(3, 25),
      FlSpot(4, 40),
      FlSpot(5, 35),
      FlSpot(6, 45),
    ];
  }

  List<FlSpot> _getYearlyData() {
    return List.generate(12, (i) => FlSpot(i.toDouble(), (i + 1) * 8.0));
  }

  List<FlSpot> _getWeeklyData1() {
    return [
      FlSpot(0, 15),
      FlSpot(1, 25),
      FlSpot(2, 35),
      FlSpot(3, 30),
      FlSpot(4, 45),
      FlSpot(5, 40),
      FlSpot(6, 50),
    ];
  }

  List<FlSpot> _getYearlyData1() {
    return List.generate(12, (i) => FlSpot(i.toDouble(), (12 - i) * 6.0));
  }

  @override
  void onInit() {
    super.onInit();
    selectMonthly();  // Default
    selectMonthly1(); // Default
  }
}
