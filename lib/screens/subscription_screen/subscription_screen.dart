import 'package:assist_web/custom_widgets/custom_error_widget.dart';
import 'package:assist_web/custom_widgets/donation_details_dialog.dart';
import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/models/subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/subscription_graph.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/subscription_controller.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {
  const SubscriptionScreen({super.key});

  Widget insightContainer(title, detail, {bool isDonation = false}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 40.h,
          bottom: 40.h,
          left: 18.0.w,
          right: 40.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24.h,
          children: [
            Text(
              title,
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  detail,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isDonation == true)
                  Padding(
                    padding: EdgeInsets.only(left: 8.0.w, bottom: 8.h),
                    child: Text(
                      "per person",
                      style: AppStyles.greyTextStyle().copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: kGreyShade10Color,
                      ),
                    ),
                  ),
              ],
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
                            PageHeader(pageName: "Donations & Subscriptions"),
                            SizedBox(height: 19),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: kGreyShade9Color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(27),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: 450.h,
                                            decoration: BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Subscription summary",
                                                        style:
                                                            AppStyles.blackTextStyle()
                                                                .copyWith(
                                                                  fontSize:
                                                                      26.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                      Obx(() {
                                                        bool monthly =
                                                            controller
                                                                .isMonthly
                                                                .value;
                                                        return Container(
                                                          height: 45.h,
                                                          width: 186,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  100,
                                                                ),
                                                            color: kWhiteColor,
                                                            border: Border.all(
                                                              width: 0.5,
                                                              color:
                                                                  kGreyShade12Color,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: CustomButton(
                                                                  title:
                                                                      "Monthly",
                                                                  onTap: () {
                                                                    controller
                                                                        .selectMonthly();
                                                                    controller
                                                                        .getRevenue(
                                                                          "montly",
                                                                        );
                                                                  },
                                                                  height: 45,
                                                                  textSize: 12,
                                                                  color:
                                                                      monthly
                                                                          ? kPrimaryColor
                                                                          : kWhiteColor,
                                                                  borderColor:
                                                                      monthly
                                                                          ? kPrimaryColor
                                                                          : kWhiteColor,
                                                                  textColor:
                                                                      monthly
                                                                          ? kWhiteColor
                                                                          : kPrimaryColor,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: CustomButton(
                                                                  title:
                                                                      "Yearly",
                                                                  onTap: () {
                                                                    controller
                                                                        .selectYearly();
                                                                    controller
                                                                        .getRevenue(
                                                                          "yearly",
                                                                        );
                                                                  },
                                                                  height: 45,
                                                                  textSize: 12,
                                                                  color:
                                                                      monthly
                                                                          ? kWhiteColor
                                                                          : kPrimaryColor,
                                                                  borderColor:
                                                                      monthly
                                                                          ? kWhiteColor
                                                                          : kPrimaryColor,
                                                                  textColor:
                                                                      monthly
                                                                          ? kPrimaryColor
                                                                          : kWhiteColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                  SizedBox(height: 21.h),
                                                  Obx(
                                                    () => SubscriptionGraph(
                                                      isMonthly:
                                                          controller
                                                              .isMonthly
                                                              .value,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 18.w),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 450.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Obx(
                                                  () => insightContainer(
                                                    "Total Donation",
                                                    "\$${controller.totalDonations.value}",
                                                  ),
                                                ),
                                                Obx(
                                                  () => insightContainer(
                                                    "Individual Subscriber",
                                                    "\$${controller.individualSubscriber.value}",
                                                    isDonation: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 35.h),
                                    Container(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Donation Funded",
                                                  style:
                                                      AppStyles.greyTextStyle()
                                                          .copyWith(
                                                            color: kBlackColor,
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                ),

                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              kGreyShade5Color
                                                                  .withOpacity(
                                                                    0.22,
                                                                  ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              vertical: 18.h,
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
                                                              "by range...",
                                                              style: AppStyles.greyTextStyle()
                                                                  .copyWith(
                                                                    color:
                                                                        kGreyShade5Color,
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
                                                    SizedBox(width: 13.w),
                                                    CustomButton(
                                                      title: "Export Data",
                                                      onTap: () {},
                                                      width: 210.w,
                                                      height: 66.h,
                                                      textSize: 20.sp,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 37.h),
                                            Obx(
                                              () =>
                                                  controller.isLoading1.value
                                                      ? Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                      : controller
                                                          .isError1
                                                          .value
                                                      ? CustomErrorWidget(
                                                        title:
                                                            controller
                                                                .errorMsg1
                                                                .value,
                                                      )
                                                      : controller
                                                          .filteredSubs
                                                          .isEmpty
                                                      ? CustomErrorWidget(
                                                        title:
                                                            "No donations funded",
                                                      )
                                                      : Stack(
                                                        children: [
                                                          Container(
                                                            height: 70,
                                                            decoration: BoxDecoration(
                                                              color: kGreyShade5Color
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
                                                              dividerThickness:
                                                                  0,
                                                              columns: [
                                                                DataColumn(
                                                                  label: Flexible(
                                                                    child: Text(
                                                                      "Name",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: AppStyles.blackTextStyle().copyWith(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Flexible(
                                                                    child: Text(
                                                                      "Email",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: AppStyles.blackTextStyle().copyWith(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Flexible(
                                                                    child: Text(
                                                                      "Donation date",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: AppStyles.blackTextStyle().copyWith(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w600,
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
                                                                      "Donation Amount",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: AppStyles.blackTextStyle().copyWith(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w600,
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
                                                                      "Donation Stats",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: AppStyles.blackTextStyle().copyWith(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w600,
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
                                                                      maxLines:
                                                                          1,
                                                                      style: AppStyles.blackTextStyle().copyWith(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w600,
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
                                                                            entry.key;
                                                                        final sub =
                                                                            entry.value;

                                                                        return _buildDataRow(
                                                                          i,
                                                                          sub,
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
                                                  controller
                                                          .filteredSubs
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
                                  ],
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

  DataRow _buildDataRow(int i, SubscriptionModel subscription, context) {
    String formatDate(String dateString) {
      try {
        final date = DateTime.parse(dateString);
        return DateFormat('d-M-yyyy').format(date);
      } catch (e) {
        return dateString; // fallback in case of invalid date
      }
    }

    return DataRow(
      color: WidgetStateProperty.all(Colors.transparent),
      cells: [
        DataCell(
          Text(
            subscription.user.name,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Text(
            subscription.user.email,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Text(
            formatDate(subscription.startDate),
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "\$${subscription.amount}",
              textAlign: TextAlign.center,
              style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
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
                      (context) => DonationDetailsDialog(subs: subscription),
                );
              },
              child: Container(
                height: 33,
                width: 105.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kGreyShade5Color.withOpacity(0.22),
                ),
                child: Center(
                  child: Text(
                    subscription.type,
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 13,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Container(
              height: 33,
              width: 94.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: kPrimaryColor,
              ),
              child: Center(
                child: Text(
                  "View",
                  style: AppStyles.whiteTextStyle().copyWith(fontSize: 13),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
