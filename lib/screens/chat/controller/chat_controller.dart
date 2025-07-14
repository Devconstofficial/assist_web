import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../chat_screen.dart';

class ChatController extends GetxController {
  var chats = <Map<String, dynamic>>[].obs;
  var messages = <ChatMessage>[].obs;
  final TextEditingController textController = TextEditingController();
  var searchText = ''.obs;
  var allChats = <Map<String, dynamic>>[];
  RxDouble rating = 5.0.obs;
  final TextEditingController searchController = TextEditingController();

  var selectedImage = Rx<File?>(null);

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  @override
  void onInit() {
    super.onInit();
    searchController.clear();
    searchText.value = '';
  }

  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      messages.add(
        ChatMessage(text: text, isSentByMe: true, timestamp: getCurrentTime()),
      );
      textController.clear();
    }
  }

  String getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }
}
