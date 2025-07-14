import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

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
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: (21), vertical: (10)),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: (15)),
                    child: ChatBubble(
                      text: message.text,
                      isSentByMe: message.isSentByMe,
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
            decoration: BoxDecoration(
              color: kGreyShade3Color.withOpacity(0.22),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.textController,
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
                        onTap:
                            () => controller.sendMessage(
                              controller.textController.text,
                            ),
                        child: Text(
                          'Send',
                          style: AppStyles.blackTextStyle().copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: kBlackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: (10)),
                GestureDetector(
                  onTap: () {
                    controller.pickImageFromGallery();
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

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String timestamp;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
  });
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;

  const ChatBubble({super.key, required this.text, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width *
              0.7, // Max 70% of screen width
        ),
        child: Column(
          crossAxisAlignment:
              isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: (16), vertical: (8)),
              constraints: BoxConstraints(
                maxWidth:
                    MediaQuery.of(context).size.width *
                    0.7, // Max 70% of screen width
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
                text,
                style: AppStyles.blackTextStyle().copyWith(
                  color: isSentByMe ? kWhiteColor : kBlackColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              "Yesterday 11:44 AM",
              style: AppStyles.blackTextStyle().copyWith(
                color: kGreyColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
