import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:assist_web/custom_widgets/custom_snackbar.dart';
import 'package:assist_web/models/chat_model.dart';
import 'package:assist_web/screens/chat/chat_utils.dart';
import 'package:assist_web/services/firebase_services.dart';
import 'package:assist_web/services/image_picker_service.dart';
import 'package:assist_web/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  final FirebaseServices _firebaseService = FirebaseServices();
  final ImagePickerService _imagePickerService = ImagePickerService();
  final UserService _service = UserService();
  final messageController = TextEditingController();
  var messages = <Message>[].obs;
  var tempMessages = <Message>[].obs;
  final RxList<Uint8List> selectedImages = <Uint8List>[].obs;
  final picker = ImagePicker();
  var isSending = false.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMsg = "".obs;
  StreamSubscription<List<Message>>? _messageSubscription;
  Stream<List<Message>>? messageStream;
  final RxList<String> notificationIds = <String>[].obs;

  Future<String?> getAccessToken() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/assist-app-6c044.json',
      );
      final Map<String, dynamic> serviceAccount = json.decode(jsonString);

      final String privateKey = serviceAccount['private_key'];
      final String clientEmail = serviceAccount['client_email'];

      final jwt = JWT({
        'iss': clientEmail,
        'scope': 'https://www.googleapis.com/auth/firebase.messaging',
        'aud': 'https://oauth2.googleapis.com/token',
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'exp': (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600,
      });

      final signedJwt = jwt.sign(
        RSAPrivateKey(privateKey),
        algorithm: JWTAlgorithm.RS256,
      );

      final response = await http.post(
        Uri.parse('https://oauth2.googleapis.com/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          'assertion': signedJwt,
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body['access_token'];
      } else {
        print("Failed to get access token: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error generating access token: $e");
      return null;
    }
  }

  Future<void> sendNotification({
    required List<String> fcmTokens,
    required String senderName,
    required String messageText,
    Map<String, dynamic>? dataPayload,
  }) async {
    final Uri url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/assist-app-6c044/messages:send',
    );
    String? accessToken = await getAccessToken();

    for (String token in fcmTokens) {
      try {
        final Map<String, dynamic> payload = {
          'message': {
            'token': token,
            'notification': {
              'title': 'New Message',
              'body':
                  messageText.isNotEmpty
                      ? '$senderName sent you a message: $messageText'
                      : '$senderName sent you a message: Attachment',
            },
            'data': dataPayload ?? {'sender': senderName},
          },
        };

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(payload),
        );

        if (response.statusCode == 200) {
          debugPrint(' Notification sent to $token');
        } else {
          debugPrint(' Failed to send notification to $token');

          debugPrint('Body: ${response.body}');
        }
      } catch (e) {
        debugPrint(' Exception sending notification to $token: $e');
      }
    }
  }

  Future<void> fetchNotificationIds(String id) async {
    try {
      final result = await _service.getNotificationIds(id);
      if (result is List<String>) {
        notificationIds.assignAll(result);
      } else {
        notificationIds.clear();
        showCustomSnackbar("Error", "$result");
      }
    } catch (e) {
      showCustomSnackbar("Error", "Failed to fetch notification IDs  $e");
    }
  }

  Future<void> pickImagesFromGallery() async {
    final pickedFiles = await ImagePicker().pickMultiImage();

    final imageBytesList = await Future.wait(
      pickedFiles.map((e) => e.readAsBytes()),
    );

    selectedImages.addAll(imageBytesList);
  }

  void loadMessages(String userId1, String userId2) async {
    String chatId = ChatUtils.generateChatId(userId1, userId2);

    try {
      isLoading.value = true;

      messageStream = _firebaseService.getChatMessages(chatId);
      _messageSubscription?.cancel();
      _messageSubscription = messageStream!.listen((newMessages) {
        messages.assignAll(newMessages);
        isLoading.value = false;
        isError(false);
        errorMsg.value = "";
      });
    } catch (e) {
      isError(true);
      errorMsg.value = e.toString();
      showCustomSnackbar('Error', 'Failed to load messages. $e');
    }
  }

  Future<void> sendMessage({
    required String receiverId,
    required String receiverName,
    required String receiverImageUrl,
    required String senderId,
    required String senderName,
    required String senderImageUrl,
  }) async {
    if (messageController.text.isEmpty && selectedImages.isEmpty) {
      return;
    }

    final String messageText = messageController.text.trim();
    final List<Uint8List> imagesToSend = List.from(selectedImages);

    messageController.clear();
    selectedImages.clear();

    var tempMessage = Message(
      id: '',
      senderId: senderId,
      text: messageText,
      imageUrls: imagesToSend.map((file) => file).toList(),
      timestamp: DateTime.now(),
      isUploading: true,
    );
    tempMessages.add(tempMessage);

    try {
      isSending.value = true;
      List<String> imageUrls = [];

      for (Uint8List image in imagesToSend) {
        String imageUrl = await _imagePickerService.uploadImageToFirebase(
          image,
        );
        imageUrls.add(imageUrl);
      }

      String chatId = ChatUtils.generateChatId(senderId, receiverId);

      var message = Message(
        id: '',
        senderId: senderId,
        text: messageText,
        imageUrls: imageUrls,
        timestamp: DateTime.now(),
        isUploading: false,
      );

      var chatInfo = ChatModel(
        chatId: chatId,
        participants: [
          Participant(
            userId: senderId,
            name: senderName,
            imageUrl: senderImageUrl,
          ),
          Participant(
            userId: receiverId,
            name: receiverName,
            imageUrl: receiverImageUrl,
          ),
        ],
        lastMessage:
            message.text.isNotEmpty ? message.text : 'Sent an attachment',
        lastMessageTime: message.timestamp,
        lastMessageSenderId: message.senderId,
        participantIds: [senderId, receiverId],
      );

      tempMessages.remove(tempMessage);
      await _firebaseService.sendMessage(chatId, message, chatInfo, receiverId);
      isSending.value = false;
      await sendNotification(
        fcmTokens: notificationIds,
        senderName: senderName,
        messageText: messageText,
      );
    } catch (e) {
      isSending.value = false;
      print('Failed to send message: $e');
      tempMessages.remove(tempMessage);
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _messageSubscription?.cancel();
    super.onClose();
  }
}
