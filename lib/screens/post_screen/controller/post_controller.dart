import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/post_model.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/services/post_service.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final PostService _service = PostService();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var isLoadingUser = false.obs;
  var isErrorUser = false.obs;
  var errorMsgUser = "".obs;
  RxList<PostModel> allUsers = <PostModel>[].obs;
  RxList<PostModel> filteredUsers = <PostModel>[].obs;
  Rx<PostModel> user = PostModel.empty().obs;
  var selectedRole = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAllPosts();
  }

  Future<void> getAllPosts() async {
    try {
      isLoading(true);
      var result = await _service.getAllPosts();
      isLoading(false);
      if (result is List<PostModel>) {
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

  

  var currentPage = 1.obs;
  final int itemsPerPage = 8;
  final int pagesPerGroup = 4;

  List<PostModel> get pagedUsers {
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

  void filterPosts() {
    List<PostModel> result = allUsers;

    final role = selectedRole.value.trim().toLowerCase();

    if (role == "approved") {
      result = result.where((post) => post.approved == true).toList();
    } else if (role == "rejected") {
      result = result.where((post) => post.approved == false).toList();
    }

    filteredUsers.assignAll(result);
    currentPage.value = 1;
  }

  void resetFilter() {
    selectedRole.value = '';
    filteredUsers.assignAll(allUsers);
    currentPage.value = 1;
  }

  void deletePost({required String postId, required BuildContext context}) async {
  Get.back(); 
  try {
    final result = await _service.removePost(postId: postId);
    if (result == true) {
      allUsers.removeWhere((post) => post.postId == postId);
      filteredUsers.removeWhere((post) => post.postId == postId);
      showCustomSnackbar("Success", "Post deleted successfully",backgroundColor: kGreenColor );
    } else {
      showCustomSnackbar("Error", result.toString(),);
    }
  } catch (e) {
    showCustomSnackbar("Error", e.toString(), );
  }
}

}
