import 'package:assist_web/screens/application_screen/applications_screen.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import 'controller/sidemenu_controller.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final menuController = Get.put(SideMenuController());

  logoutDialog() {
    return CustomDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 61),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 105,
              width: 105,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset(
                  kLogoutIcon,
                  height: 65,
                  width: 65,
                  color: kWhiteColor,
                ),
              ),
            ),
            SizedBox(height: 26.h),
            Text(
              "Are you sure to logout this app?",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 35.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Cancel",
                    onTap: () {
                      Get.back();
                    },
                    color: kGreyShade5Color.withOpacity(0.22),
                    borderColor: kGreyShade5Color.withOpacity(0.22),
                    textColor: kPrimaryColor,
                    textSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 56.h,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomButton(
                    title: "Yes Logout",
                    onTap: () {
                      SessionManagement sessionManagement = SessionManagement();
                      sessionManagement.removeSession(
                        token: SessionTokenKeys.kUserModelKey,
                      );
                      sessionManagement.removeSession(
                        token: SessionTokenKeys.kUserRoleKey,
                      );
                      sessionManagement.removeSession(
                        token: SessionTokenKeys.kUserTokenKey,
                      );
                      Get.offAllNamed(kAuthScreenRoute);
                    },
                    textSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 56.h,
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
    // bool isTablet = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(23),
      child: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: kBlackColor,
        width: 280.w,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 128,
                child: DrawerHeader(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 142.h,
                        child: Center(
                          child: Image.asset(
                            kLogo,
                            fit: BoxFit.cover,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                menuController.onItemTapped(0);
                                Get.toNamed(kDashboardScreenRoute);
                              },
                              child: SizedBox(
                                width: width,
                                height: 58,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 24,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              kDashboardIcon,
                                              height: 26,
                                              width: 26,
                                              colorFilter: ColorFilter.mode(
                                                menuController
                                                            .selectedIndex
                                                            .value ==
                                                        0
                                                    ? kWhiteColor
                                                    : kGreyShade8Color,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.01,
                                            ),
                                            Text(
                                              kDashboard,
                                              style: AppStyles.blackTextStyle()
                                                  .copyWith(
                                                    color:
                                                        menuController
                                                                    .selectedIndex
                                                                    .value ==
                                                                0
                                                            ? kWhiteColor
                                                            : kGreyShade8Color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                menuController.onItemTapped(1);
                                Get.toNamed(kUserScreenRoute);
                              },
                              child: SizedBox(
                                width: width,
                                height: 58,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 24,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              kUserIcon,
                                              height: 26,
                                              width: 26,
                                              colorFilter: ColorFilter.mode(
                                                menuController
                                                            .selectedIndex
                                                            .value ==
                                                        1
                                                    ? kWhiteColor
                                                    : kGreyShade8Color,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.01,
                                            ),
                                            Text(
                                              "User Management",
                                              style: AppStyles.blackTextStyle()
                                                  .copyWith(
                                                    color:
                                                        menuController
                                                                    .selectedIndex
                                                                    .value ==
                                                                1
                                                            ? kWhiteColor
                                                            : kGreyShade8Color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                menuController.onItemTapped(2);
                                Get.to(() => ApplicationsScreen());
                              },
                              child: SizedBox(
                                width: width,
                                height: 58,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 24,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              kApplicationIcon,
                                              height: 26,
                                              width: 26,
                                              colorFilter: ColorFilter.mode(
                                                menuController
                                                            .selectedIndex
                                                            .value ==
                                                        1
                                                    ? kWhiteColor
                                                    : kGreyShade8Color,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.01,
                                            ),
                                            Text(
                                              "Applications Management",
                                              style: AppStyles.blackTextStyle()
                                                  .copyWith(
                                                    color:
                                                        menuController
                                                                    .selectedIndex
                                                                    .value ==
                                                                2
                                                            ? kWhiteColor
                                                            : kGreyShade8Color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                menuController.onItemTapped(3);
                                Get.toNamed(kFeedScreenRoute);
                              },
                              child: SizedBox(
                                width: width,
                                height: 58,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 24,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              kClipboardIcon,
                                              height: 26,
                                              width: 26,
                                              colorFilter: ColorFilter.mode(
                                                menuController
                                                            .selectedIndex
                                                            .value ==
                                                        2
                                                    ? kWhiteColor
                                                    : kGreyShade8Color,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.01,
                                            ),
                                            Text(
                                              "Feed Control",
                                              style: AppStyles.blackTextStyle()
                                                  .copyWith(
                                                    color:
                                                        menuController
                                                                    .selectedIndex
                                                                    .value ==
                                                                3
                                                            ? kWhiteColor
                                                            : kGreyShade8Color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                menuController.onItemTapped(4);
                                Get.toNamed(kSubscriptionScreenRoute);
                              },
                              child: SizedBox(
                                width: width,
                                height: 58,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 24,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              kSubscriptionIcon,
                                              height: 26,
                                              width: 26,
                                              colorFilter: ColorFilter.mode(
                                                menuController
                                                            .selectedIndex
                                                            .value ==
                                                        3
                                                    ? kWhiteColor
                                                    : kGreyShade8Color,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.01,
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Subscriptions & Donations",
                                                style: AppStyles.blackTextStyle()
                                                    .copyWith(
                                                      color:
                                                          menuController
                                                                      .selectedIndex
                                                                      .value ==
                                                                  4
                                                              ? kWhiteColor
                                                              : kGreyShade8Color,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                menuController.onItemTapped(5);
                                Get.toNamed(kCalenderScreenRoute);
                              },
                              child: SizedBox(
                                width: width,
                                height: 58,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 24,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              kCalendarIcon,
                                              height: 26,
                                              width: 26,
                                              colorFilter: ColorFilter.mode(
                                                menuController
                                                            .selectedIndex
                                                            .value ==
                                                        5
                                                    ? kWhiteColor
                                                    : kGreyShade8Color,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.01,
                                            ),
                                            Text(
                                              "Calendar",
                                              style: AppStyles.blackTextStyle()
                                                  .copyWith(
                                                    color:
                                                        menuController
                                                                    .selectedIndex
                                                                    .value ==
                                                                4
                                                            ? kWhiteColor
                                                            : kGreyShade8Color,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
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
                          );
                        }),
                        // const SizedBox(height: 20,),
                        // Obx(() {
                        //   return MouseRegion(
                        //     cursor: SystemMouseCursors.click,
                        //     child: GestureDetector(
                        //       onTap: () {
                        //         menuController.onItemTapped(5);
                        //         Get.toNamed(kSettingScreenRoute);
                        //       },
                        //       child: SizedBox(
                        //         width: width,
                        //         height: 58,
                        //         child: Row(
                        //           children: [
                        //             Expanded(
                        //               child: Padding(
                        //                 padding: const EdgeInsets.only( left: 24),
                        //                 child: Row(
                        //                   crossAxisAlignment: CrossAxisAlignment.center,
                        //                   children: [
                        //                     SvgPicture.asset(
                        //                       kCalendarIcon,
                        //                       height: 26,
                        //                       width: 26,
                        //                       colorFilter: ColorFilter.mode(
                        //                         menuController.selectedIndex.value == 5 ? kWhiteColor : kGreyShade8Color,
                        //                         BlendMode.srcIn,
                        //                       ),
                        //                     ),
                        //                     SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        //                     Text(
                        //                       "Settings",
                        //                       style: AppStyles.blackTextStyle().copyWith(
                        //                           color: menuController.selectedIndex.value == 5
                        //                               ? kWhiteColor : kGreyShade8Color,
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.w600
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   );
                        // }),
                      ],
                    ),
                  ),
                ),
              ),
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0, right: 15),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.dialog(logoutDialog());
                    },
                    child: SizedBox(
                      width: width,
                      height: 58,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 58,
                              decoration: BoxDecoration(
                                color: kBlackColor,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(24),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      kLogoutIcon,
                                      height: 26,
                                      width: 26,
                                      colorFilter: ColorFilter.mode(
                                        kGreyShade8Color,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Text(
                                      "Logout",
                                      style: AppStyles.blackTextStyle()
                                          .copyWith(
                                            color: kGreyShade8Color,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}
