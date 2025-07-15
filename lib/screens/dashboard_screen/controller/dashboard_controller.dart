import 'dart:convert';
import 'dart:typed_data';
import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/application_model.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/screens/subscription_screen/controller/subscription_controller.dart';
import 'package:assist_web/services/application_service.dart';
import 'package:assist_web/services/auth_service.dart';
import 'package:assist_web/services/dashboard_stats_service.dart';
import 'package:assist_web/services/firebase_services.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  final ApplicationService _applicationService = ApplicationService();
  final FirebaseServices _firebaseService = FirebaseServices();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var isLoading1 = false.obs;
  var isError1 = false.obs;
  var errorMsg1 = "".obs;
  var isLoading2 = false.obs;
  var isError2 = false.obs;
  var errorMsg2 = "".obs;
  var isLoading3 = false.obs;
  var isError3 = false.obs;
  var errorMsg3 = "".obs;
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
  Rx<ApplicationModel> randomApplication = ApplicationModel().obs;

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

  Future getRandomApplication() async {
    try {
      isLoading3(true);
      var result = await _applicationService.getRandomApplication();
      isLoading3(false);
      if (result is ApplicationModel) {
        randomApplication.value = result;
        selectedStatus.value = result.status;
        isError3(false);
        errorMsg3.value = '';

        return;
      } else {
        isError3(true);
        errorMsg3.value = result.toString();
      }
    } catch (e) {
      isLoading3(false);
      isError3(true);
      errorMsg3.value = e.toString();
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
        if (isMonthly.value) {
          _processMonthlyUserGrowthData(result);
        } else {
          _processYearlyUserGrowthData(result);
        }
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

  void _processMonthlyUserGrowthData(List<Map<String, dynamic>> data) {
    final List<String> dates = [];
    final List<FlSpot> spots = [];

    for (int i = 0; i < data.length; i++) {
      final entry = data[i];
      final dateStr = entry['date'] as String;
      final count = entry['count'] as int;

      final date = DateTime.parse(dateStr);
      final day = date.day;

      dates.add(day.toString());
      spots.add(FlSpot(i.toDouble(), count.toDouble()));
    }

    currentMonthDates.value = dates;
    completedSpots.value = spots;
  }

  void _processYearlyUserGrowthData(List<Map<String, dynamic>> data) {
    final List<String> monthLabels = [];
    final List<FlSpot> spots = [];

    for (int i = 0; i < data.length; i++) {
      final entry = data[i];
      final monthStr = entry['month'] as String; // e.g. "2024-08"
      final count = entry['count'] as int;

      final date = DateTime.parse("$monthStr-01");

      // Format month name like "Aug", "Sep", etc.
      final formattedMonth = DateFormat.MMM().format(date);

      monthLabels.add(formattedMonth);
      spots.add(FlSpot(i.toDouble(), count.toDouble()));
    }

    months.value = monthLabels;
    completedSpots.value = spots;
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
          _firebaseService.updateParticipantImageUrl(
            userId: userData.value.userId,
            newImageUrl: result,
          );
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

  void updateApplicationStatus(String id, String status) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      var result = await _applicationService.updateApplicationStatus(
        status: status,
        id: id,
      );
      Get.back();
      if (result is bool) {
        Get.back();
        getRandomApplication();
        showCustomSnackbar(
          "Success",
          "Status updated Successfully",
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

  final RxList<String> months = <String>[].obs;

  var currentMonthDates = <String>[].obs;

  var completedSpots = <FlSpot>[].obs;

  void selectMonthly() {
    isMonthly.value = true;
  }

  void selectYearly() {
    isMonthly.value = false;
  }
}
