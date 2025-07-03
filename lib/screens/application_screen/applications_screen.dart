import 'package:assist_web/custom_widgets/custom_error_widget.dart';
import 'package:assist_web/custom_widgets/custom_filter_dialog.dart';
import 'package:assist_web/custom_widgets/custom_pagination.dart';
import 'package:assist_web/custom_widgets/custom_reload_widget.dart';
import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/models/application_model.dart';
import 'package:assist_web/screens/application_screen/application_detail_dialog.dart';
import 'package:assist_web/screens/application_screen/controller/application_controller.dart';
import 'package:assist_web/screens/sidemenu/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_styles.dart';

class ApplicationsScreen extends GetView<ApplicationController> {
  const ApplicationsScreen({super.key});

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
                    child: CustomReloadWidget(
                      onRefresh: () async {
                        controller.getApplications();
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
                              PageHeader(pageName: "Applications Management"),
                              SizedBox(height: 19),
                              Container(
                                width: width,
                                decoration: BoxDecoration(
                                  color: kGreyShade9Color,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(27),
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
                                                            type: "Name",
                                                          ),
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
                                                  padding: EdgeInsets.symmetric(
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
                                                        "Name",
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
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) =>
                                                          CustomFilterDialog(
                                                            type: "Bill Type",
                                                          ),
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
                                                  padding: EdgeInsets.symmetric(
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
                                                        "Bill Type",
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
                                            Obx(() {
                                              if (controller
                                                      .selectedBillType
                                                      .value
                                                      .isNotEmpty ||
                                                  controller
                                                      .searchNameQuery
                                                      .value
                                                      .isNotEmpty ||
                                                  controller
                                                      .selectedFilter
                                                      .value
                                                      .isNotEmpty) {
                                                return Row(
                                                  children: [
                                                    SizedBox(width: 13.w),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .selectedBillType
                                                            .value = '';
                                                        controller
                                                            .searchNameQuery
                                                            .value = "";
                                                        controller
                                                            .selectedFilter
                                                            .value = "";
                                                        controller
                                                            .searchController
                                                            .clear();
                                                        controller
                                                            .filteredApplications
                                                            .assignAll(
                                                              controller
                                                                  .allApplications,
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
                                                                vertical: 21.h,
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
                                                      .filteredApplications
                                                      .isEmpty
                                                  ? CustomErrorWidget(
                                                    title: "No applications",
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
                                                          headingRowHeight: 70,
                                                          dividerThickness: 0,
                                                          columns: [
                                                            DataColumn(
                                                              label: Flexible(
                                                                child: Text(
                                                                  "Name",
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
                                                                  "Bill type",
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
                                                                  "Reason/Description",
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
                                                                  "Action",
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
                                                                  .map((entry) {
                                                                    final i =
                                                                        entry
                                                                            .key;
                                                                    final application =
                                                                        entry
                                                                            .value;

                                                                    return _buildDataRow(
                                                                      i,
                                                                      application,
                                                                      context,
                                                                    );
                                                                  })
                                                                  .toList(),
                                                          dataRowMaxHeight: 70,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                        ),
                                        SizedBox(height: 35.h),
                                        Obx(
                                          () =>
                                              controller
                                                      .filteredApplications
                                                      .isEmpty
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
                                                        controller.goToNextPage,
                                                    onPageSelected:
                                                        controller.goToPage,
                                                  ),
                                        ),
                                      ],
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

  DataRow _buildDataRow(int i, final ApplicationModel application, context) {
    return DataRow(
      color: WidgetStateProperty.all(Colors.transparent),
      cells: [
        DataCell(
          Text(
            application.user.name,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Text(
            application.billCategory,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Text(
            application.reason,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Container(
            height: 33,
            width: 105.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color:
                  application.status == "Denied"
                      ? kRed1Color
                      : application.status == "Submitted"
                      ? kGreyShade17Color
                      : kGreen1Color,
            ),
            child: Center(
              child: Text(
                application.status,
                textAlign: TextAlign.center,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 14.sp,
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
        ),

        DataCell(
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) =>
                          ApplicationDetailDialog(application: application),
                );
              },
              child: Container(
                height: 34.h,
                width: 34.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
                child: Center(
                  child: Icon(Icons.visibility, color: kWhiteColor, size: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
