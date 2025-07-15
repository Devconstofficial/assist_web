import 'package:assist_web/custom_widgets/custom_shimmer_widget.dart';
import 'package:assist_web/models/chat_model.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final UserModel data;
  const ChatScreen({super.key, required this.data});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());
  final DashboardController dashboardController = Get.find();
  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller.loadMessages(
      widget.data.userId,
      dashboardController.userData.value.userId,
    );
    controller.fetchNotificationIds(widget.data.userId);
    controller.messages.listen((_) {
      scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: (50)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: (8)),
                    height: (45),
                    width: (45),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      border: Border.all(color: kGreyShade4Color, width: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: (8)),
                        child: Icon(
                          Icons.arrow_back,
                          color: kGreyShade4Color,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: (16)),
                Text(
                  'Message',
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 20.sp,
                    color: kBlackColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: (10.h)),
          Expanded(
            child: Obx(() {
              var allMessages = [
                ...controller.tempMessages,
                ...controller.messages,
              ];
              return controller.isLoading.value
                  ? ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: (21),
                      vertical: (10),
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: (15)),
                        child: Align(
                          alignment:
                              index % 2 == 0
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                          child: CustomShimmerWidget(
                            height: 70.h,
                            width: 300.w,
                            borderRadius: 10,
                          ),
                        ),
                      );
                    },
                  )
                  : controller.isError.value
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.errorMsg.value,
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        IconButton(
                          onPressed: () {
                            controller.loadMessages(
                              widget.data.userId,
                              dashboardController.userData.value.userId,
                            );
                          },
                          icon: Icon(Icons.replay),
                        ),
                      ],
                    ),
                  )
                  : allMessages.isEmpty
                  ? Center(
                    child: Text(
                      'No messages',
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                  : ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: (21),
                      vertical: (10),
                    ),
                    itemCount: allMessages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: (15)),
                        child: ChatBubble(
                          message: allMessages[index],
                          userId: dashboardController.userData.value.userId,
                        ),
                      );
                    },
                  );
            }),
          ),
          Container(
            padding: EdgeInsets.only(
              left: (18),
              top: (0),
              right: (20),
              bottom: (18),
            ),
            decoration: BoxDecoration(color: kGreyShade3Color.withOpacity(0.1)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () =>
                      controller.selectedImages.isNotEmpty
                          ? Container(
                            height: (100.h),
                            margin: EdgeInsets.symmetric(vertical: (8.w)),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.selectedImages.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: (6.w),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.memory(
                                          controller.selectedImages[index],
                                          width: (90.w),
                                          height: (90.h),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: (2.h),
                                      right: (9.w),
                                      child: GestureDetector(
                                        onTap:
                                            () => controller.removeImage(index),
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: 15.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        decoration: InputDecoration(
                          hintText: "Type your message",
                          border: InputBorder.none,
                          hintStyle: AppStyles.blackTextStyle().copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: kGreyColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (!controller.isSending.value) {
                            controller.sendMessage(
                              receiverId: widget.data.userId,
                              receiverName: widget.data.name,
                              receiverImageUrl: widget.data.userImage,
                              senderId:
                                  dashboardController.userData.value.userId,
                              senderName:
                                  dashboardController.userData.value.name,
                              senderImageUrl:
                                  dashboardController.userData.value.userImage,
                            );
                          }
                        },
                        child: Obx(
                          () => Text(
                            'Send',
                            style: AppStyles.blackTextStyle().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color:
                                  controller.isSending.value
                                      ? kGreyColor
                                      : kBlackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: (10)),
                GestureDetector(
                  onTap: () {
                    controller.pickImagesFromGallery();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: kBlackColor,
                        size: 20,
                      ),
                      SizedBox(width: (10)),
                      Text(
                        'Attach  media',
                        style: AppStyles.blackTextStyle().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: kGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;
  final String userId;

  const ChatBubble({super.key, required this.message, required this.userId});

  String formatDateTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final messageDate = DateTime(
      timestamp.year,
      timestamp.month,
      timestamp.day,
    );

    String dayLabel;
    if (messageDate == today) {
      dayLabel = 'Today';
    } else if (messageDate == yesterday) {
      dayLabel = 'Yesterday';
    } else {
      dayLabel = DateFormat('MMM d, yyyy').format(timestamp);
    }

    String time = DateFormat('h:mm a').format(timestamp);
    return '$dayLabel $time';
  }

  @override
  Widget build(BuildContext context) {
    bool isSentByMe = message.senderId == userId;
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (message.text.isNotEmpty)
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(
                horizontal: (16.w),
                vertical: (8.h),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isSentByMe ? kBlackColor : kWhiteColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow:
                    isSentByMe
                        ? []
                        : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
              ),
              child: Text(
                message.text,
                style: AppStyles.blackTextStyle().copyWith(
                  color: isSentByMe ? kWhiteColor : kBlackColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          if (message.imageUrls.isNotEmpty)
            SizedBox(
              height: (120.h),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: message.imageUrls.length,
                itemBuilder: (context, index) {
                  return message.isUploading
                      ? Stack(
                        children: [
                          Image.memory(
                            message.imageUrls[index],
                            height: (120.h),
                            width: (100.w),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : Padding(
                        padding: EdgeInsets.only(bottom: (8.h), right: 10.w),
                        child: ImageNetwork(
                          image: message.imageUrls[index],
                          height: (120.h),
                          width: (100.w),
                          onLoading: Center(
                            child: CircularProgressIndicator(
                              color: isSentByMe ? kBlackColor : kWhiteColor,
                            ),
                          ),

                          onError: Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => Dialog(
                                    backgroundColor: Colors.black,
                                    insetPadding: EdgeInsets.zero,
                                    child: Stack(
                                      children: [
                                        InteractiveViewer(
                                          child: ImageNetwork(
                                            image: message.imageUrls[index],
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width,
                                            fitWeb: BoxFitWeb.contain,
                                            onError: const Center(
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                            onLoading: const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          right: 20,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            onPressed:
                                                () =>
                                                    Navigator.of(context).pop(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                        ),
                      );
                },
              ),
            ),
          Text(
            formatDateTime(message.timestamp),
            style: AppStyles.blackTextStyle().copyWith(
              color: kGreyColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
