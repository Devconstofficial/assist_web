import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/view_profile_dialog.dart';

class UserController extends GetxController {
  final UserService _service = UserService();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var isLoadingUser = false.obs;
  var isErrorUser = false.obs;
  var errorMsgUser = "".obs;
  RxList<UserModel> allUsers = <UserModel>[].obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs;
  Rx<UserModel> user = UserModel.empty().obs;
  var selectedRole = "".obs;
  var searchNameQuery = "".obs;
  var selectedFilter = "".obs;
  var searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsers();
  }

  void getUsers() async {
    try {
      isLoading(true);
      var result = await _service.getUsers();
      isLoading(false);
      if (result is List<UserModel>) {
        allUsers.assignAll(result);
        filteredUsers.assignAll(result);
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

  void getSpcificUser(String id) async {
    try {
      isLoadingUser(true);
      var result = await _service.getSpecificUser(userId: id);
      isLoadingUser(false);
      if (result is UserModel) {
        user.value = result;
        isErrorUser(false);
        errorMsgUser.value = '';
        return;
      } else {
        isErrorUser(true);
        errorMsg.value = result.toString();
      }
    } catch (e) {
      isLoadingUser(false);
      isErrorUser(true);
      errorMsgUser.value = e.toString();
    }
  }

  void blockUser(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      var result = await _service.blockUser(userId: id);
      Get.back();
      if (result is bool) {
        Get.back();
        getUsers();
        showCustomSnackbar(
          "Success",
          "Blocked Successfully",
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

  void unblockUser(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      var result = await _service.unblockUser(userId: id);
      Get.back();
      if (result is bool) {
        Get.back();
        getUsers();
        showCustomSnackbar(
          "Success",
          "Unblocked Successfully",
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

  var currentPage = 1.obs;
  final int itemsPerPage = 8;
  final int pagesPerGroup = 4;

  List<UserModel> get pagedUsers {
    final filtered = filteredUsers;
    int start = (currentPage.value - 1) * itemsPerPage;
    if (start >= filtered.length) return [];
    int end = start + itemsPerPage;
    return filtered.sublist(
      start,
      end > filtered.length ? filtered.length : end,
    );
  }

  int get totalPages => (filteredUsers.length / itemsPerPage).ceil();

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

  void deleteUserAt(int index) {
    allUsers.removeAt(index);
  }

  void editUserAt(int index) {
    final user = allUsers[index];
    if (user.roles.contains('Subscriber')) {
      Get.dialog(viewProfileDialog(isSubscriber: true));
    } else {
      Get.dialog(viewProfileDialog());
    }
  }

  void filterUsers() {
    List<UserModel> result = [];

    final role = selectedRole.value.trim().toLowerCase();
    final search = searchNameQuery.value.toLowerCase();
    final sortOrder = selectedFilter.value;

    if (role.isNotEmpty && search.isNotEmpty) {
      result =
          allUsers.where((user) {
            final hasRoles = user.roles.isNotEmpty;
            final lastRole = hasRoles ? user.roles.last.toLowerCase() : '';

            final matchesRole = lastRole == role;
            final matchesSearch = user.name.toLowerCase().contains(search);

            return matchesRole && matchesSearch;
          }).toList();
    } else if (role.isNotEmpty) {
      result =
          allUsers.where((user) {
            final hasRoles = user.roles.isNotEmpty;
            final lastRole = hasRoles ? user.roles.last.toLowerCase() : '';

            return lastRole == role;
          }).toList();
    } else {
      result =
          allUsers.where((user) {
            return user.name.toLowerCase().contains(search);
          }).toList();
    }

    if (sortOrder == 'A - Z') {
      result.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    } else if (sortOrder == 'Z - A') {
      result.sort(
        (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
      );
    }

    filteredUsers.assignAll(result);
    currentPage.value = 1;
  }
}
