import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/application_model.dart';
import 'package:assist_web/screens/application_screen/full_image_view_screen.dart'
    show FullImageViewScreen;
import 'package:assist_web/services/application_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController {
  final ApplicationService _service = ApplicationService();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var isLoadingUser = false.obs;
  var isErrorUser = false.obs;
  var errorMsgUser = "".obs;
  RxList<ApplicationModel> allApplications = <ApplicationModel>[].obs;
  RxList<ApplicationModel> filteredApplications = <ApplicationModel>[].obs;
  var selectedStatus = "".obs;
  var selectedBillType = "".obs;
  var searchNameQuery = "".obs;
  var selectedFilter = "".obs;
  var searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getApplications();
  }

  void getApplications() async {
    try {
      isLoading(true);
      var result = await _service.getApplications();
      isLoading(false);
      if (result is List<ApplicationModel>) {
        allApplications.assignAll(result);
        filteredApplications.assignAll(result);
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

  var currentPage = 1.obs;
  final int itemsPerPage = 8;
  final int pagesPerGroup = 4;

  List<ApplicationModel> get pagedUsers {
    final filtered = filteredApplications;
    int start = (currentPage.value - 1) * itemsPerPage;
    if (start >= filtered.length) return [];
    int end = start + itemsPerPage;
    return filtered.sublist(
      start,
      end > filtered.length ? filtered.length : end,
    );
  }

  int get totalPages => (filteredApplications.length / itemsPerPage).ceil();

  int get currentGroup => ((currentPage.value - 1) / pagesPerGroup).floor();

  List<int> get visiblePageNumbers {
    int startPage = currentGroup * pagesPerGroup + 1;
    int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage.value = page;
  }

  void goToNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  void openImage(String url) {
    Get.to(() => FullImageViewScreen(imageUrl: url));
  }

  void updateStatus(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      var result = await _service.updateApplicationStatus(
        status: selectedStatus.value,
        id: id,
      );
      Get.back();
      if (result is bool) {
        Get.back();
        getApplications();
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

  void filterApplications() {
    List<ApplicationModel> result = [];

    final billType = selectedBillType.value.trim().toLowerCase();
    final search = searchNameQuery.value.toLowerCase();
    final sortOrder = selectedFilter.value;

    if (billType.isNotEmpty && search.isNotEmpty) {
      result =
          allApplications.where((app) {
            final matchesBillType = app.billCategory.toLowerCase() == billType;

            final matchesSearch = app.user.name.toLowerCase().contains(search);

            return matchesBillType && matchesSearch;
          }).toList();
    } else if (billType.isNotEmpty) {
      result =
          allApplications.where((app) {
            return app.billCategory.toLowerCase() == billType;
          }).toList();
    } else {
      result =
          allApplications.where((app) {
            return app.user.name.toLowerCase().contains(search);
          }).toList();
    }

    if (sortOrder == 'A - Z') {
      result.sort(
        (a, b) =>
            a.user.name.toLowerCase().compareTo(b.user.name.toLowerCase()),
      );
    } else if (sortOrder == 'Z - A') {
      result.sort(
        (a, b) =>
            b.user.name.toLowerCase().compareTo(a.user.name.toLowerCase()),
      );
    }
    filteredApplications.assignAll(result);
    currentPage.value = 1;
  }
}
