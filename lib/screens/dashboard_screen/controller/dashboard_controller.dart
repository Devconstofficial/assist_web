import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/screens/subscription_screen/controller/subscription_controller.dart';
import 'package:assist_web/services/auth_service.dart';
import 'package:assist_web/services/dashboard_stats_service.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DashboardController extends GetxController {
  final AuthService _service = AuthService();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController note = TextEditingController();
  RxString status = "".obs;
  RxString planName = "".obs;
  RxString imageUrl = "".obs;
  final DashboardStatsService _dashboardStatsService = DashboardStatsService();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var isLoading1 = false.obs;
  var isError1 = false.obs;
  var errorMsg1 = "".obs;
  var isLoading2 = false.obs;
  var isError2 = false.obs;
  var errorMsg2 = "".obs;
  var totalFunds = 0.0.obs;
  var averageDonationPerUser = 0.0.obs;
  var helpedApplicants = 0.0.obs;
  var selectedPercentage = 0.0.obs;
  var deniedPercentage = 0.0.obs;
  var isMonthly = true.obs;
  var isMonthly1 = true.obs;
  var selectedStatus = 'Submitted'.obs;
  var isDenied = false.obs;
  Rx<UserModel> userData = UserModel.empty().obs;
  Rx<Uint8List?> webImage = Rxn<Uint8List>();
  var nameCont = TextEditingController();
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  RxList<Map<String, dynamic>> userGraphData = <Map<String, dynamic>>[].obs;
  final SubscriptionController controller = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
    getAll();
    selectMonthly();
    selectMonthly1();
  }

  void getAll() {
    Future.wait([
      getMatrices(),
      getDonorMatrices(),
      controller.getRevenue(isMonthly1.value ? "monthly" : "yearly"),
      getUserGrowth(),
    ]);
  }

  Future getMatrices() async {
    try {
      isLoading(true);
      var result = await _dashboardStatsService.getMatrices();
      isLoading(false);
      if (result is Map<String, dynamic>) {
        totalFunds.value = result['totalFunds'];
        averageDonationPerUser.value = result['averageDonationPerUser'];
        helpedApplicants.value = result['helpedApplicants'];
        isError(false);
        errorMsg.value = '';
        return;
      } else {
        isError(true);
        errorMsg.value = result.toString();
      }
    } catch (e) {
      isLoading(false);
      isError(true);
      errorMsg.value = e.toString();
    }
  }

  Future getDonorMatrices() async {
    try {
      isLoading2(true);
      var result = await _dashboardStatsService.getDonarMatrices();
      isLoading2(false);
      if (result is Map<String, dynamic>) {
        selectedPercentage.value = result['selectedPercentage'];
        deniedPercentage.value = result['deniedPercentage'];
        isError2(false);
        errorMsg2.value = '';
        return;
      } else {
        isError2(true);
        errorMsg2.value = result.toString();
      }
    } catch (e) {
      isLoading2(false);
      isError2(true);
      errorMsg2.value = e.toString();
    }
  }

  Future getUserGrowth() async {
    try {
      isLoading1(true);
      var result = await _dashboardStatsService.getUserGrowth(
        type: isMonthly.value ? "monthly" : "yearly",
      );
      isLoading1(false);
      if (result is List<Map<String, dynamic>>) {
        userGraphData.assignAll(result);
        isError1(false);
        errorMsg1.value = '';
        return;
      } else {
        isError1(true);
        errorMsg1.value = result.toString();
      }
    } catch (e) {
      isLoading1(false);
      isError1(true);
      errorMsg1.value = e.toString();
    }
  }

  void getUserData() async {
    String userJson = await SessionManagement().getSessionToken(
      tokenKey: SessionTokenKeys.kUserModelKey,
    );

    if (userJson.isNotEmpty) {
      try {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        userData.value = UserModel.fromJson(userMap);
      } catch (e) {
        print("Error decoding user data: $e");
      }
    } else {
      print("No user data found");
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      webImage.value = bytes;
    }
  }

  Future<dynamic> uploadCategoryImage(dynamic imageBytes) async {
    try {
      String filePath =
          'profile_images/${DateTime.now().millisecondsSinceEpoch}.png';

      UploadTask uploadTask;

      uploadTask = _storage.ref(filePath).putData(imageBytes);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL after the upload is complete
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return false;
    }
  }

  void updateProfile() async {
    try {
      String imageUrl = "";
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      if (webImage.value != null) {
        var result = await uploadCategoryImage(webImage.value);
        if (result is bool) {
          Get.back();
          showCustomSnackbar("Error", "Failed to upload image");
          return;
        } else {
          imageUrl = result;
        }
      }
      var result = await _service.updateProfile(
        body: {
          "name": nameCont.text,
          if (imageUrl.isNotEmpty) "profilePicture": imageUrl,
        },
      );
      Get.back();
      if (result is UserModel) {
        Get.back();

        getUserData();
        showCustomSnackbar(
          "Success",
          "Profile updated successfully",
          backgroundColor: Colors.green,
        );
        return;
      } else {
        showCustomSnackbar("Error", result.toString());
      }
    } catch (e) {
      Get.back();
      showCustomSnackbar("Error", e.toString());
    }
  }

  void selectMonthly1() => isMonthly1.value = true;
  void selectYearly1() => isMonthly1.value = false;

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

  void _generateCurrentMonthDates() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    currentMonthDates.value = List.generate(daysInMonth, (i) => '${i + 1}');
  }

  List<FlSpot> _getIrregularMonthlyData() {
    final days = currentMonthDates.length;
    return List.generate(days, (i) {
      final y = 30 + _random.nextInt(40);
      return FlSpot(i.toDouble(), y.toDouble());
    });
  }

  void selectYearly() {
    isMonthly.value = false;
    completedSpots.value = _getYearlyData();
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
}
