import 'dart:typed_data';
import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/post_model.dart';
import 'package:assist_web/services/post_service.dart';
import 'package:assist_web/services/user_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FeedController extends GetxController {
  final PostService _service = PostService();
  final UserService _userService = UserService();
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  var isLoadingUser = false.obs;
  var isErrorUser = false.obs;
  var errorMsgUser = "".obs;
  RxList<PostModel> allRequests = <PostModel>[].obs;
  RxList<PostModel> allReports = <PostModel>[].obs;
  var descCont = TextEditingController();
  Rx<Uint8List?> webImage = Rxn<Uint8List>();
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      webImage.value = bytes;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPostRequests();
  }

  void getPostRequests() async {
    try {
      isLoading(true);
      var result = await _service.getPostRequests();
      isLoading(false);
      if (result is List<PostModel>) {
        allRequests.assignAll(result);
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

  void getReportedPosts() async {
    try {
      isLoadingUser(true);
      var result = await _service.getReportedPosts();
      isLoadingUser(false);
      if (result is List<PostModel>) {
        allReports.assignAll(result);
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

  void approvePostRequest(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      var result = await _service.approvePost(postId: id);
      Get.back();
      if (result is bool) {
        getPostRequests();
        showCustomSnackbar(
          "Success",
          "Approved Successfully",
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

  void removePost(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      var result = await _service.removePost(postId: id);
      Get.back();
      if (result is bool) {
        getPostRequests();
        getReportedPosts();
        showCustomSnackbar(
          "Success",
          "Post removed Successfully",
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

  void blockUser(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      var result = await _userService.blockUser(userId: id);
      Get.back();
      if (result is bool) {
        Get.back();
        showCustomSnackbar(
          "Success",
          "Banned Successfully",
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

  Future<dynamic> uploadCategoryImage(dynamic imageBytes) async {
    try {
      String filePath =
          'applications/${DateTime.now().millisecondsSinceEpoch}_post.png';

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

  void addPost() async {
    if (descCont.text.isEmpty || webImage.value == null) {
      showCustomSnackbar("Error", "Add a content and upload an image");
      return;
    }
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final imageUrl = await uploadCategoryImage(webImage.value);
      if (imageUrl is bool) {
        Get.back();
        showCustomSnackbar("Error", "Failed to upload image");
        return;
      } else {
        var result = await _service.addPost(
          body: {"text": descCont.text, "imageUrl": imageUrl},
        );
        Get.back();
        if (result is bool) {
          Get.back();
          showCustomSnackbar(
            "Success",
            "Post added Successfully",
            backgroundColor: Colors.green,
          );
          return;
        } else {
          showCustomSnackbar("Error", result.toString());
        }
      }
    } catch (e) {
      Get.back();
      showCustomSnackbar("Error", e.toString());
    }
  }
}
