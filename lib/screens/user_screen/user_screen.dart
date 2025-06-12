import 'package:assist_web/custom_widgets/page_header.dart';
import 'package:assist_web/screens/user_screen/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../sidemenu/sidemenu.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

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
                            PageHeader(pageName: "User Management"),
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
                                            SizedBox(
                                              width: 280.w,
                                              child: CustomTextField(
                                                hintText: "Search by name...",
                                                hintColor: kGreyShade5Color,
                                                prefix: SvgPicture.asset(
                                                  kSearchIcon,
                                                  height: 24,
                                                  width: 24,
                                                ),
                                                borderColor: kGreyShade5Color.withOpacity(0.22),
                                                onChanged: (value) {
                                                  controller.searchQuery.value = value;
                                                  controller.currentPage.value = 1; // Reset to page 1 on new search
                                                },
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: kGreyShade5Color
                                                      .withOpacity(0.22),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 21,
                                                      horizontal: 35,
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
                                                      "by email...",
                                                      style: AppStyles.greyTextStyle()
                                                          .copyWith(
                                                            color:
                                                                kGreyShade5Color,
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 13.w),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: kGreyShade5Color
                                                      .withOpacity(0.22),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 21,
                                                      horizontal: 35,
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
                                                      "by phone number...",
                                                      style: AppStyles.greyTextStyle()
                                                          .copyWith(
                                                            color:
                                                                kGreyShade5Color,
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 13.w),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: kGreyShade5Color
                                                      .withOpacity(0.22),
                                                ),
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
                                                      "by role...",
                                                      style: AppStyles.greyTextStyle()
                                                          .copyWith(
                                                            color:
                                                                kGreyShade5Color,
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 37.h),
                                        Obx(
                                          () => Stack(
                                            children: [
                                              Container(
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: kGreyShade5Color
                                                      .withOpacity(0.22),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
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
                                                          style: AppStyles.blackTextStyle()
                                                              .copyWith(
                                                                fontSize: 16.sp,
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
                                                          "Email",
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          maxLines: 1,
                                                          style: AppStyles.blackTextStyle()
                                                              .copyWith(
                                                                fontSize: 16.sp,
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
                                                          "Birth date",
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          maxLines: 1,
                                                          style: AppStyles.blackTextStyle()
                                                              .copyWith(
                                                                fontSize: 16.sp,
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
                                                          "Phone number",
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          maxLines: 1,
                                                          style: AppStyles.blackTextStyle()
                                                              .copyWith(
                                                                fontSize: 16.sp,
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
                                                          "Role",
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          maxLines: 1,
                                                          style: AppStyles.blackTextStyle()
                                                              .copyWith(
                                                                fontSize: 16.sp,
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
                                                          style: AppStyles.blackTextStyle()
                                                              .copyWith(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  rows:
                                                      controller.pagedUsers
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                            final i = entry.key;
                                                            final user =
                                                                entry.value;

                                                            return _buildDataRow(
                                                              i,
                                                              user['name']!,
                                                              user['email']!,
                                                              user['birthDate']!,
                                                              user['phNumber']!,
                                                              user['role']!,
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
                                              () => controller.filteredUsers.isEmpty
                                              ? SizedBox.shrink()
                                              : CustomPagination(
                                            currentPage: controller.currentPage.value,
                                            visiblePages: controller.visiblePageNumbers,
                                            onPrevious: controller.goToPreviousPage,
                                            onNext: controller.goToNextPage,
                                            onPageSelected: controller.goToPage,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(
    int i,
    String name,
    String email,
    String birthDate,
    String phNumber,
    String role,
    context,
  ) {
    return DataRow(
      color: WidgetStateProperty.all(Colors.transparent),
      cells: [
        DataCell(
          Text(
            name,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Text(
            email,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Text(
            birthDate,
            textAlign: TextAlign.center,
            style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              phNumber,
              textAlign: TextAlign.center,
              style: AppStyles.blackTextStyle().copyWith(fontSize: 14.sp),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Container(
              height: 33,
              width: 105.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: kGreyShade5Color.withOpacity(0.22),
              ),
              child: Center(
                child: Text(
                  role,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 13,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Edit') {
                    controller.editUserAt(i);
                  } else if (value == 'Delete') {
                    controller.deleteUserAt(i);
                  }
                },
                itemBuilder:
                    (context) => [
                      PopupMenuItem(value: 'Edit', child: Text('Edit')),
                      PopupMenuItem(value: 'Delete', child: Text('Delete')),
                      PopupMenuItem(value: 'Restrict', child: Text('Restrict')),
                    ],
                icon: Icon(Icons.more_vert_outlined),
                color: kWhiteColor,
                position: PopupMenuPosition.under,
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
