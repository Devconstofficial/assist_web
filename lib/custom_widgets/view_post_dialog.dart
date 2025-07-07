import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/models/post_model.dart';
import 'package:assist_web/custom_widgets/custom_textfield.dart';
import 'package:assist_web/custom_widgets/custom_dialog.dart';
import 'package:image_network/image_network.dart';

Widget viewPostDialog(PostModel post) {
  return CustomDialog(
    width: 675.w,
    content: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "View Post",
                  style: AppStyles.blackTextStyle().copyWith(fontSize: 20),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 62,
                      width: 62,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: kGreyShade7Color.withOpacity(0.11),
                            blurRadius: 22,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 70.h),

            CustomTextField(
              controller: TextEditingController(text: post.text),
              hintText: "Type here...",
              maxLines: 8,
              borderRadius: 20,
              borderColor: kGreyShade13Color,
              readOnly: true,
            ),

            SizedBox(height: 20.h),

            if (post.imageUrl != "")
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ImageNetwork(
                  image: post.imageUrl,
                  height: 300.h,
                  width:Get.width,
                  duration: 500,
                  curve: Curves.easeIn,
                  onTap: () {}, 
                  fitWeb: BoxFitWeb.cover,
                  fitAndroidIos: BoxFit.cover,
                )
              ),
          ],
        ),
      ),
    ),
  );
}
