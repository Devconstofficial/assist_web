import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/custom_widgets/custom_dialog.dart';
import 'package:assist_web/custom_widgets/custom_error_widget.dart';
import 'package:assist_web/custom_widgets/custom_shimmer_widget.dart';
import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/models/post_model.dart';
import 'package:assist_web/screens/feed_screen/controller/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../sidemenu/sidemenu.dart';

class FeedScreen extends GetView<FeedController> {
  const FeedScreen({super.key});

  Widget requestContainer({required PostModel post}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kGreyShade13Color),
      ),
      child: Padding(
        padding: EdgeInsets.all(26.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageNetwork(
              image: post.imageUrl,
              height: 230.h,
              width: Get.width,
              fitWeb: BoxFitWeb.cover,
              fitAndroidIos: BoxFit.cover,
              borderRadius: BorderRadius.circular(20),
              onLoading: const CircularProgressIndicator(strokeWidth: 2),
              onError: Center(child: Icon(Icons.error, size: 35)),
            ),

            SizedBox(height: 14.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 9,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user.name,
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateFormat('d-M-yyyy').format(post.createdAt),
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CustomButton(
                  title: "Donor",
                  onTap: () {},
                  color: kGreyShade5Color.withOpacity(0.22),
                  borderColor: kGreyShade5Color.withOpacity(0.22),
                  textColor: kPrimaryColor,
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  width: 60.w,
                  height: 33,
                ),
              ],
            ),
            SizedBox(height: 9.h),
            Text(
              post.text,
              maxLines: 2,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 27.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Reject",
                    onTap: () {
                      controller.approvePostRequest(post.postId, false);
                    },
                    color: kGreyShade5Color.withOpacity(0.22),
                    borderColor: kGreyShade5Color.withOpacity(0.22),
                    textColor: kPrimaryColor,
                    textSize: 16,
                    fontWeight: FontWeight.w900,
                    height: 48.h,
                  ),
                ),
                SizedBox(width: 17.w),
                Expanded(
                  child: CustomButton(
                    title: "Approve",
                    onTap: () {
                      controller.approvePostRequest(post.postId, true);
                    },
                    textSize: 16,
                    fontWeight: FontWeight.w900,
                    height: 48.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget feedbackContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kGreyShade13Color),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.h,
          left: 27.w,
          right: 13.w,
          bottom: 37.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 29,
                  width: 66.w,
                  decoration: BoxDecoration(
                    color: kGreyShade13Color,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      "Applicant",
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: kGreyShade13Color),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(kAvatar1, fit: BoxFit.contain),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Zoya Channa",
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.h),
            Text(
              "Your support means the world to us. Every dollar you give brings someone closer to hope and opportunity. We’re truly grateful!",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "12-2-2025",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  createPostDialog() {
    controller.webImage.value = null;
    controller.descCont.clear();
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
                    "Create new Post",
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
                controller: controller.descCont,
                hintText: "Type here...",
                maxLines: 8,
                borderRadius: 20,
                borderColor: kGreyShade13Color,
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (controller.webImage.value != null) {
                  return Image.memory(
                    controller.webImage.value!,
                    fit: BoxFit.cover,
                  );
                }
                return SizedBox.shrink();
              }),
              SizedBox(height: 87.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kPrimaryColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          kUploadIcon,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: CustomButton(
                      title: "Upload post",
                      onTap: () {
                        controller.addPost();
                      },
                      height: 85,
                      textSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  reportDialog() {
    return CustomDialog(
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 38),
              child: Text(
                "Reports",
                style: AppStyles.blackTextStyle().copyWith(fontSize: 22),
              ),
            ),
            SizedBox(height: 15.h),
            Obx(
              () =>
                  controller.isLoadingUser.value
                      ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 38),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: CustomShimmerWidget(
                              height: 400,
                              borderRadius: 24,
                            ),
                          );
                        },
                      )
                      : controller.isErrorUser.value
                      ? SizedBox(
                        height: 600.h,
                        child: CustomErrorWidget(
                          title: controller.errorMsgUser.value,
                        ),
                      )
                      : controller.allReports.isEmpty
                      ? SizedBox(
                        height: 600.h,
                        child: CustomErrorWidget(title: "No reported posts"),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.allReports.length,
                        padding: EdgeInsets.symmetric(horizontal: 38),
                        itemBuilder: (context, index) {
                          final post = controller.allReports[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reason: ${post.reports.first['reason']}",
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kRedColor,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "This content might be offensive",
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kRedColor,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: kRedColor),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(26.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ImageNetwork(
                                          image: post.imageUrl,
                                          height: 230.h,
                                          width: Get.width,
                                          fitWeb: BoxFitWeb.cover,
                                          fitAndroidIos: BoxFit.cover,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          onLoading:
                                              const CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                          onError: Center(
                                            child: Icon(Icons.error, size: 35),
                                          ),
                                        ),

                                        SizedBox(height: 14.h),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              spacing: 9,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  post.user.name,
                                                  style:
                                                      AppStyles.blackTextStyle()
                                                          .copyWith(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                ),
                                                Text(
                                                  DateFormat(
                                                    'd-M-yyyy',
                                                  ).format(post.createdAt),
                                                  style:
                                                      AppStyles.blackTextStyle()
                                                          .copyWith(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            CustomButton(
                                              title: "Donor",
                                              onTap: () {},
                                              color: kGreyShade5Color
                                                  .withOpacity(0.22),
                                              borderColor: kGreyShade5Color
                                                  .withOpacity(0.22),
                                              textColor: kPrimaryColor,
                                              textSize: 14,
                                              fontWeight: FontWeight.w600,
                                              width: 60.w,
                                              height: 33,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 9.h),
                                        Text(
                                          post.text,
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        SizedBox(height: 27.h),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomButton(
                                                title: "Ban User",
                                                onTap: () {
                                                  controller.blockUser(
                                                    post.user.userId,
                                                  );
                                                },
                                                color: kGreyShade5Color
                                                    .withOpacity(0.22),
                                                borderColor: kGreyShade5Color
                                                    .withOpacity(0.22),
                                                textColor: kPrimaryColor,
                                                textSize: 16,
                                                fontWeight: FontWeight.w900,
                                                height: 48.h,
                                              ),
                                            ),
                                            SizedBox(width: 17.w),
                                            Expanded(
                                              child: CustomButton(
                                                title: "Remove Post",
                                                onTap: () {
                                                  controller.removePost(
                                                    post.postId,
                                                  );
                                                },
                                                textSize: 16,
                                                fontWeight: FontWeight.w900,
                                                height: 48.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // CommonCode.unFocus(context);
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SideMenu(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 23.h,
                          right: 59.w,
                          bottom: 32.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PageHeader(pageName: "Community Feed"),
                            SizedBox(height: 19),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: kGreyShade9Color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(27),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 32.h,
                                      horizontal: 29.w,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Recent Added Posts",
                                              style: AppStyles.blackTextStyle()
                                                  .copyWith(
                                                    fontSize: 26,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Spacer(),
                                            CustomButton(
                                              title: "+ Create new post",
                                              onTap: () {
                                                Get.dialog(createPostDialog());
                                              },
                                              height: 66.h,
                                              width: 180.w,
                                              color: kWhiteColor,
                                              borderColor: kGreyShade13Color,
                                              textColor: kPrimaryColor,
                                              textSize: 16,
                                            ),
                                            SizedBox(width: 7),
                                            CustomButton(
                                              title: "Report Posts",
                                              onTap: () {
                                                controller.getReportedPosts();
                                                Get.dialog(reportDialog());
                                              },
                                              textSize: 18,
                                              fontWeight: FontWeight.w600,
                                              width: 235.w,
                                              height: 66.h,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.h),
                                        Obx(
                                          () =>
                                              controller.isLoading.value
                                                  ? GridView.builder(
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          crossAxisSpacing:
                                                              24.w,
                                                          mainAxisSpacing: 24.h,
                                                          mainAxisExtent: 520.h,
                                                        ),
                                                    itemCount: 3,

                                                    itemBuilder: (
                                                      context,
                                                      index,
                                                    ) {
                                                      return CustomShimmerWidget();
                                                    },
                                                  )
                                                  : controller.isError.value
                                                  ? SizedBox(
                                                    height: 400.h,
                                                    child: CustomErrorWidget(
                                                      title:
                                                          controller
                                                              .errorMsg
                                                              .value,
                                                    ),
                                                  )
                                                  : controller
                                                      .allRequests
                                                      .isEmpty
                                                  ? SizedBox(
                                                    height: 400.h,
                                                    child: CustomErrorWidget(
                                                      title: "No post requests",
                                                    ),
                                                  )
                                                  : GridView.builder(
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          crossAxisSpacing:
                                                              24.w,
                                                          mainAxisSpacing: 24.h,
                                                          mainAxisExtent: 520.h,
                                                        ),
                                                    itemCount:
                                                        controller
                                                            .allRequests
                                                            .length,
                                                    itemBuilder: (
                                                      context,
                                                      index,
                                                    ) {
                                                      return requestContainer(
                                                        post:
                                                            controller
                                                                .allRequests[index],
                                                      );
                                                    },
                                                  ),
                                        ),
                                        SizedBox(height: 25.h),
                                        //             Row(
                                        //               children: [
                                        //                 Text(
                                        //                   "Recent Feedback’s",
                                        //                   style: AppStyles.blackTextStyle()
                                        //                       .copyWith(
                                        //                         fontSize: 26,
                                        //                         fontWeight: FontWeight.w600,
                                        //                       ),
                                        //                 ),
                                        //                 Spacer(),
                                        //                 Container(
                                        //                   decoration: BoxDecoration(
                                        //                     borderRadius:
                                        //                         BorderRadius.circular(100),
                                        //                     border: Border.all(
                                        //                       color: kGreyShade5Color,
                                        //                     ),
                                        //                   ),
                                        //                   child: Padding(
                                        //                     padding: const EdgeInsets.all(
                                        //                       15,
                                        //                     ),
                                        //                     child: Row(
                                        //                       children: [
                                        //                         SvgPicture.asset(
                                        //                           kCalendarIcon1,
                                        //                           height: 16,
                                        //                           width: 16,
                                        //                         ),
                                        //                         SizedBox(width: 4),
                                        //                         Text(
                                        //                           "12 December",
                                        //                           style: AppStyles.greyTextStyle()
                                        //                               .copyWith(
                                        //                                 color:
                                        //                                     kGreyShade5Color,
                                        //                                 fontSize: 12.sp,
                                        //                                 fontWeight:
                                        //                                     FontWeight.w500,
                                        //                               ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             SizedBox(height: 25.h),
                                        //             Row(
                                        //               children: [
                                        //                 Expanded(
                                        //                   child: feedbackContainer(),
                                        //                 ),
                                        //                 SizedBox(width: 24.w),
                                        //                 Expanded(
                                        //                   child: feedbackContainer(),
                                        //                 ),
                                        //                 SizedBox(width: 24.w),
                                        //                 Expanded(
                                        //                   child: feedbackContainer(),
                                        //                 ),
                                        //               ],
                                        //             ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
