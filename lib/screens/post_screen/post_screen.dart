import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/custom_widgets/custom_error_widget.dart';
import 'package:assist_web/custom_widgets/custom_filter_dialog.dart';
import 'package:assist_web/custom_widgets/custom_reload_widget.dart';
import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/custom_widgets/view_post_dialog.dart';
import 'package:assist_web/models/post_model.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/screens/post_screen/controller/post_controller.dart';
import 'package:assist_web/screens/user_screen/user_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../sidemenu/sidemenu.dart';

class PostScreen extends GetView<PostController> {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
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
                    child: CustomReloadWidget(
                      onRefresh: () async {
                        controller.getAllPosts();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 23.h,
                            right: 59.w,
                            bottom: 32.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PageHeader(pageName: "Post Management"),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            CustomFilterDialog(
                                                              type: "Status",
                                                              isUser: true,
                                                            ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          100,
                                                        ),
                                                    border: Border.all(
                                                      color: kGreyShade5Color
                                                          .withOpacity(0.22),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 21.h,
                                                          horizontal: 35.w,
                                                        ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          kFilterIcon,
                                                          height: 24,
                                                          width: 24,
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          "Status",
                                                          style: AppStyles.greyTextStyle()
                                                              .copyWith(
                                                                color:
                                                                    kGreyShade10Color,
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 13.w),

                                              Obx(() {
                                                if (controller
                                                    .selectedRole
                                                    .value
                                                    .isNotEmpty) {
                                                  return Row(
                                                    children: [
                                                      SizedBox(width: 13.w),
                                                      GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .selectedRole
                                                              .value = '';

                                                          controller
                                                              .filteredUsers
                                                              .assignAll(
                                                                controller
                                                                    .allUsers,
                                                              );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  100,
                                                                ),
                                                            color: kWhiteColor,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  vertical:
                                                                      21.h,
                                                                  horizontal:
                                                                      35.w,
                                                                ),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .replay_rounded,
                                                                ),
                                                                SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "Reset Filters",
                                                                  style: AppStyles.greyTextStyle().copyWith(
                                                                    color:
                                                                        kBlackColor,
                                                                    fontSize:
                                                                        18.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                return SizedBox.shrink();
                                              }),
                                            ],
                                          ),
                                          SizedBox(height: 37.h),
                                          Obx(
                                            () =>
                                                controller.isLoading.value
                                                    ? Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                    : controller.isError.value
                                                    ? CustomErrorWidget(
                                                      title:
                                                          controller
                                                              .errorMsg
                                                              .value,
                                                    )
                                                    : controller
                                                        .filteredUsers
                                                        .isEmpty
                                                    ? CustomErrorWidget(
                                                      title: "No Post Found",
                                                    )
                                                    : Stack(
                                                      children: [
                                                        Container(
                                                          height: 70,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                kGreyShade5Color
                                                                    .withOpacity(
                                                                      0.22,
                                                                    ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width,
                                                          child: DataTable(
                                                            columnSpacing: 0,
                                                            headingRowHeight:
                                                                70,
                                                            dividerThickness: 0,
                                                            columns: [
                                                              DataColumn(
                                                                label: Flexible(
                                                                  child: Text(
                                                                    "User Name",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: AppStyles.blackTextStyle().copyWith(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Flexible(
                                                                  child: Text(
                                                                    "Text",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: AppStyles.blackTextStyle().copyWith(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Center(
                                                                  child: Text(
                                                                    "Post Image",
                                                                    textAlign: TextAlign.center,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: AppStyles.blackTextStyle().copyWith(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                headingRowAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                label: Flexible(
                                                                  child: Text(
                                                                    "Status",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: AppStyles.blackTextStyle().copyWith(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              DataColumn(
                                                                headingRowAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                label: Flexible(
                                                                  child: Text(
                                                                    "Actions",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: AppStyles.blackTextStyle().copyWith(
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                            rows:
                                                                controller
                                                                    .pagedUsers
                                                                    .asMap()
                                                                    .entries
                                                                    .map((
                                                                      entry,
                                                                    ) {
                                                                      final i =
                                                                          entry
                                                                              .key;
                                                                      final user =
                                                                          entry
                                                                              .value;

                                                                      return _buildDataRow(
                                                                        i,
                                                                        user,
                                                                        context,
                                                                      );
                                                                    })
                                                                    .toList(),
                                                            dataRowMaxHeight:
                                                                70,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                          ),
                                          SizedBox(height: 35.h),
                                          Obx(
                                            () =>
                                                controller.filteredUsers.isEmpty
                                                    ? SizedBox.shrink()
                                                    : CustomPagination(
                                                      currentPage:
                                                          controller
                                                              .currentPage
                                                              .value,
                                                      visiblePages:
                                                          controller
                                                              .visiblePageNumbers,
                                                      onPrevious:
                                                          controller
                                                              .goToPreviousPage,
                                                      onNext:
                                                          controller
                                                              .goToNextPage,
                                                      onPageSelected:
                                                          controller.goToPage,
                                                    ),
                                          ),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(int i, final PostModel post, context) {
    return DataRow(
      color: WidgetStateProperty.all(Colors.transparent),
      cells: [
        DataCell(
          Text(
            post.user.name,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          SizedBox(
            width: 250.w,
            child: Text(
              post.text,
              overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
              style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
            ),
          ),
        ),
       DataCell(
  post.imageUrl.isNotEmpty
      ? Row(
          children: [
            ImageNetwork(
              image: post.imageUrl,
              height: 50,
              width: 50,
              duration: 500,
              curve: Curves.easeIn,
              onTap: () {},
              fitWeb: BoxFitWeb.cover,
              fitAndroidIos: BoxFit.cover,
            ),
          ],
        )
      : const Icon(Icons.image_not_supported),
),

        DataCell(
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99.r),
                color:
                    post.approved == true
                        ? kGreen1Color.withOpacity(0.3)
                        : kRed1Color.withOpacity(0.3),
                border: Border.all(
                  width: 1,
                  color: post.approved == true ? kGreen1Color : kRed1Color,
                ),
              ),
              child: Text(
                post.approved == true ? "Approved" : "Rejected",
                textAlign: TextAlign.center,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 14.sp,
                  color: post.approved == true ? kGreen1Color : kRed1Color,
                ),
              ),
            ),
          ),
        ),

        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => viewPostDialog(post),
                    );
                  },
                  child: Icon(Icons.remove_red_eye),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => confirmDeletePostDialog(context, post.postId),
                    );
                  },
                  child: Icon(Icons.delete, color: kRedColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget confirmDeletePostDialog(BuildContext context, String postId) {
    final PostController controller = Get.find();

    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        color: kWhiteColor,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        width: 400, 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Delete Post",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Are you sure you want to delete this post?",
              style: AppStyles.greyTextStyle(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Cancel",
                    height: 50,
                    borderRadius: 12,
                    fontWeight: FontWeight.w600,
                    borderColor: kPrimaryColor,
                    textColor: kPrimaryColor,
                    color: kWhiteColor,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: 16),

                Expanded(
                  child: CustomButton(
                    title: "Delete",
                    height: 50,
                    borderRadius: 12,
                    textSize: 16,
                    fontWeight: FontWeight.w600,
                    textColor: kWhiteColor,
                    color: kPrimaryColor,
                    onTap: () {
                      controller.deletePost(postId: postId, context: context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
