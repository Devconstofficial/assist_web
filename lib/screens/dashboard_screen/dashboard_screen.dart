import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/custom_widgets/custom_dialog.dart';
import 'package:assist_web/custom_widgets/custom_error_widget.dart';
import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/custom_widgets/subscription_graph.dart';
import 'package:assist_web/screens/application_screen/full_image_view_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/donor_chart.dart';
import '../../custom_widgets/field_container.dart';
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  Widget _buildStatusButton(String title, double width) {
    final isSelected = controller.selectedStatus.value == title;
    return CustomButton(
      title: title,
      onTap: () => controller.updateStatus(title),
      textSize: 14,
      width: width,
      height: 46,
      color: isSelected ? kBlackColor : kGreyShade5Color.withOpacity(0.22),
      textColor: isSelected ? kWhiteColor : kBlackColor,
      borderColor: isSelected ? kBlackColor : kGreyShade13Color,
    );
  }

  Widget insightContainer(title, detail, {bool isDonation = false}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 35.h,
          bottom: 35.h,
          left: 18.0.w,
          right: 65.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 18.h,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
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
                    padding: EdgeInsets.only(left: 8.0.w),
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

  approvalDialog() {
    bool isPdfUrl(String url) {
      try {
        Uri uri = Uri.parse(url);
        String path = Uri.decodeFull(uri.path);
        String filename = path.split('/').last;
        return filename.toLowerCase().endsWith('.pdf');
      } catch (e) {
        return false;
      }
    }

    Future<void> openInNewTab(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $url');
      }
    }

    return CustomDialog(
      content: Obx(
        () =>
            controller.isLoading3.value
                ? Center(child: CircularProgressIndicator())
                : controller.isError3.value
                ? CustomErrorWidget(title: controller.errorMsg3.value)
                : controller.randomApplication.value.applicationId.isEmpty
                ? CustomErrorWidget(title: "No application data")
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 69,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: kPrimaryColor,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 16,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 13.w),
                            Text(
                              "Application Details",
                              style: AppStyles.blackTextStyle().copyWith(
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 34.h),
                        Text(
                          "Contact Information",
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Column(
                          spacing: 16.h,
                          children: [
                            fieldContainer(
                              controller.randomApplication.value.user.name,
                            ),
                            fieldContainer(
                              controller.randomApplication.value.user.email,
                            ),
                            fieldContainer(
                              controller
                                  .randomApplication
                                  .value
                                  .user
                                  .phoneNumber,
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          "Application Bill",
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: kGreyShade13Color),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 30,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: SvgPicture.asset(
                                    kPdfIcon,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                SizedBox(width: 13.w),
                                Text(
                                  "bill slip",
                                  style: AppStyles.blackTextStyle().copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                CustomButton(
                                  title: "Open",
                                  onTap: () {
                                    if (isPdfUrl(
                                      controller
                                          .randomApplication
                                          .value
                                          .billFile,
                                    )) {
                                      openInNewTab(
                                        controller
                                            .randomApplication
                                            .value
                                            .billFile,
                                      );
                                    } else {
                                      Get.to(
                                        () => FullImageViewScreen(
                                          imageUrl:
                                              controller
                                                  .randomApplication
                                                  .value
                                                  .billFile,
                                        ),
                                      );
                                    }
                                  },
                                  height: 41,
                                  width: 100,
                                  textColor: kPrimaryColor,
                                  color: kWhiteColor,
                                  textSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "Application Stats",
                          style: AppStyles.blackTextStyle().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Obx(
                        //   () => Wrap(
                        //     spacing: 8,
                        //     runSpacing: 21,
                        //     children: [
                        //       _buildStatusButton("Submitted", 119),
                        //       _buildStatusButton("In Pool", 94),
                        //       _buildStatusButton("Selected", 94),
                        //       _buildStatusButton("Paid", 94),
                        //       _buildStatusButton("Denied", 94),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 24.h),
                        // Text(
                        //   "Add Notes",
                        //   style: AppStyles.blackTextStyle().copyWith(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        // SizedBox(height: 24.h),
                        // CustomTextField(
                        //   hintText: "Type here...",
                        //   maxLines: 5,
                        //   borderRadius: 24,
                        // ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          title: "Approve",
                          onTap: () {
                            controller.updateApplicationStatus(
                              controller.randomApplication.value.applicationId,
                              "Selected",
                            );
                          },
                          height: 61,
                          textSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          title: "Reject",
                          color: kGreyShade13Color,
                          borderColor: kGreyShade13Color,
                          textColor: kBlackColor,
                          onTap: () {
                            controller.updateApplicationStatus(
                              controller.randomApplication.value.applicationId,
                              "Denied",
                            );
                          },
                          height: 61,
                          textSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 14.h),
                        // CustomButton(
                        //   title: "Reject",
                        //   onTap: () {},
                        //   height: 61,
                        //   color: kGreyShade13Color,
                        //   borderColor: kGreyShade13Color,
                        //   textColor: kPrimaryColor,
                        //   textSize: 16,
                        //   fontWeight: FontWeight.w700,
                        // ),
                      ],
                    ),
                  ),
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
                            PageHeader(pageName: kDashboard),
                            SizedBox(height: 19),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: kGreyShade9Color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 32.h,
                                  horizontal: 29.w,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Matrices",
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Spacer(),
                                        CustomButton(
                                          title: "Application Approval",
                                          onTap: () {
                                            controller.getRandomApplication();
                                            Get.dialog(approvalDialog());
                                          },
                                          textSize: 20.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 68.h,
                                          width: 240.w,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 28.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(
                                          () => insightContainer(
                                            "Total funds raised",
                                            "\$${controller.totalFunds.value}",
                                          ),
                                        ),
                                        Obx(
                                          () => insightContainer(
                                            "Number of applicants helped",
                                            "${controller.helpedApplicants.value}",
                                          ),
                                        ),
                                        Obx(
                                          () => insightContainer(
                                            "Avg donation per user",
                                            "\$${controller.averageDonationPerUser.value}",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 32.h),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "User growth over time",
                                                  style:
                                                      AppStyles.blackTextStyle()
                                                          .copyWith(
                                                            fontSize: 24.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                            title: "Monthly",
                                                            onTap: () {
                                                              controller
                                                                  .selectMonthly();
                                                              controller
                                                                  .getUserGrowth();
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
                                                            title: "Yearly",
                                                            onTap: () {
                                                              controller
                                                                  .selectYearly();
                                                              controller
                                                                  .getUserGrowth();
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
                                            SizedBox(height: 46.h),
                                            Obx(
                                              () => SizedBox(
                                                height: 250,
                                                child:
                                                    controller.isLoading1.value
                                                        ? Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                        : controller
                                                            .isError1
                                                            .value
                                                        ? Center(
                                                          child:
                                                              CustomErrorWidget(
                                                                title:
                                                                    controller
                                                                        .errorMsg1
                                                                        .value,
                                                              ),
                                                        )
                                                        : controller
                                                            .userGraphData
                                                            .isEmpty
                                                        ? Center(
                                                          child:
                                                              CustomErrorWidget(
                                                                title:
                                                                    "No data",
                                                              ),
                                                        )
                                                        : LineChart(
                                                          LineChartData(
                                                            gridData: FlGridData(
                                                              show: true,
                                                              drawVerticalLine:
                                                                  false,
                                                              getDrawingHorizontalLine:
                                                                  (
                                                                    value,
                                                                  ) => FlLine(
                                                                    color:
                                                                        Colors
                                                                            .grey
                                                                            .shade300,
                                                                    strokeWidth:
                                                                        1,
                                                                  ),
                                                            ),
                                                            titlesData: FlTitlesData(
                                                              bottomTitles: AxisTitles(
                                                                sideTitles: SideTitles(
                                                                  showTitles:
                                                                      true,
                                                                  interval: 1,
                                                                  getTitlesWidget: (
                                                                    value,
                                                                    meta,
                                                                  ) {
                                                                    final isMonthly =
                                                                        controller
                                                                            .isMonthly
                                                                            .value;
                                                                    final labels =
                                                                        isMonthly
                                                                            ? controller.currentMonthDates
                                                                            : controller.months;
                                                                    if (value
                                                                            .toInt() <
                                                                        labels
                                                                            .length) {
                                                                      return Text(
                                                                        labels[value
                                                                            .toInt()],
                                                                        style: AppStyles.blackTextStyle().copyWith(
                                                                          fontSize:
                                                                              14.sp,
                                                                          color:
                                                                              kGreyShade11Color,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      );
                                                                    }
                                                                    return const SizedBox.shrink();
                                                                  },
                                                                ),
                                                              ),
                                                              leftTitles: AxisTitles(
                                                                sideTitles: SideTitles(
                                                                  showTitles:
                                                                      true,
                                                                  interval: 100,
                                                                  reservedSize:
                                                                      40,
                                                                  getTitlesWidget:
                                                                      (
                                                                        value,
                                                                        meta,
                                                                      ) => Text(
                                                                        value
                                                                            .toInt()
                                                                            .toString(),
                                                                        style: AppStyles.blackTextStyle().copyWith(
                                                                          fontSize:
                                                                              13.sp,
                                                                          color:
                                                                              kGreyShade11Color,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                ),
                                                              ),
                                                              topTitles: AxisTitles(
                                                                sideTitles:
                                                                    SideTitles(
                                                                      showTitles:
                                                                          false,
                                                                    ),
                                                              ),
                                                              rightTitles: AxisTitles(
                                                                sideTitles:
                                                                    SideTitles(
                                                                      showTitles:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ),
                                                            borderData:
                                                                FlBorderData(
                                                                  show: false,
                                                                ),
                                                            minX: 0,
                                                            maxX:
                                                                (controller
                                                                            .isMonthly
                                                                            .value
                                                                        ? controller
                                                                            .currentMonthDates
                                                                            .length
                                                                        : controller
                                                                            .months
                                                                            .length)
                                                                    .toDouble() -
                                                                1,
                                                            minY: 0,
                                                            maxY: 500,
                                                            lineBarsData: [
                                                              LineChartBarData(
                                                                spots:
                                                                    controller
                                                                        .completedSpots,
                                                                isCurved: true,
                                                                color:
                                                                    kBlackColor,
                                                                barWidth: 2,
                                                                dotData:
                                                                    FlDotData(
                                                                      show:
                                                                          false,
                                                                    ),
                                                                belowBarData:
                                                                    BarAreaData(
                                                                      show:
                                                                          false,
                                                                    ),
                                                              ),
                                                            ],
                                                            lineTouchData: LineTouchData(
                                                              handleBuiltInTouches:
                                                                  true,
                                                              touchCallback:
                                                                  (
                                                                    FlTouchEvent
                                                                    event,
                                                                    LineTouchResponse?
                                                                    response,
                                                                  ) {},
                                                              touchTooltipData: LineTouchTooltipData(
                                                                tooltipRoundedRadius:
                                                                    8,
                                                                fitInsideHorizontally:
                                                                    true,
                                                                fitInsideVertically:
                                                                    true,
                                                                getTooltipColor:
                                                                    (
                                                                      touchedSpots,
                                                                    ) =>
                                                                        kWhiteColor,
                                                                getTooltipItems: (
                                                                  touchedSpots,
                                                                ) {
                                                                  return touchedSpots.map((
                                                                    spot,
                                                                  ) {
                                                                    if (spot.barIndex ==
                                                                        0) {
                                                                      final isMonthly =
                                                                          controller
                                                                              .isMonthly
                                                                              .value;
                                                                      final labelList =
                                                                          isMonthly
                                                                              ? controller.currentMonthDates
                                                                              : controller.months;
                                                                      final label =
                                                                          labelList[spot
                                                                              .x
                                                                              .toInt()];
                                                                      final value = spot
                                                                          .y
                                                                          .toStringAsFixed(
                                                                            2,
                                                                          );
                                                                      return LineTooltipItem(
                                                                        '$label\n$value',
                                                                        const TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                      );
                                                                    }
                                                                    return null;
                                                                  }).toList();
                                                                },
                                                              ),
                                                              getTouchedSpotIndicator: (
                                                                barData,
                                                                spotIndexes,
                                                              ) {
                                                                return spotIndexes.map((
                                                                  index,
                                                                ) {
                                                                  return TouchedSpotIndicatorData(
                                                                    FlLine(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      strokeWidth:
                                                                          2,
                                                                    ),
                                                                    FlDotData(
                                                                      show:
                                                                          true,
                                                                      getDotPainter:
                                                                          (
                                                                            spot,
                                                                            percent,
                                                                            barData,
                                                                            index,
                                                                          ) => FlDotCirclePainter(
                                                                            radius:
                                                                                6,
                                                                            color:
                                                                                kPrimaryColor,
                                                                            strokeWidth:
                                                                                2,
                                                                            strokeColor:
                                                                                Colors.white,
                                                                          ),
                                                                    ),
                                                                  );
                                                                }).toList();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 28.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: 435.h,
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
                                                                .isMonthly1
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
                                                                        .selectMonthly1();
                                                                    controller
                                                                        .controller
                                                                        .getRevenue(
                                                                          "monthly",
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
                                                                        .selectYearly1();
                                                                    controller
                                                                        .controller
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
                                                              .isMonthly1
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
                                            height: 432.h,
                                            decoration: BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Obx(
                                                () => DonorMetricsChart(
                                                  selectedPercentage:
                                                      controller.isDenied.value
                                                          ? controller
                                                              .deniedPercentage
                                                              .value
                                                          : controller
                                                              .selectedPercentage
                                                              .value,
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
                            SizedBox(height: 41),
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
