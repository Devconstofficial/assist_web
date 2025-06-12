import 'package:assist_web/custom_widgets/custom_button.dart';
import 'package:assist_web/screens/calender_screen/controller/location_controller.dart';
import 'package:assist_web/utils/app_colors.dart';
import 'package:assist_web/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationScreen extends StatelessWidget {
  final LocationController controller = Get.put(LocationController());

  SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final location = controller.currentLocation.value;
        if (location == null) {
          return Center(child: CircularProgressIndicator(color: kPrimaryColor));
        }
        return Stack(
          children: [
            Obx(
              () => GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.currentLocation.value!,
                  zoom: 15,
                ),
                onMapCreated: controller.setMapController,
                onTap: (LatLng position) {
                  controller.updateLocationAndMarker(position);
                },
                markers: {
                  Marker(
                    markerId: MarkerId("selected"),
                    position: controller.currentLocation.value!,
                  ),
                },
              ),
            ),
            Positioned(
              top: 50.h,
              left: 10.w,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 8.w),
                  height: 45.h,
                  width: 45.w,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    border: Border.all(color: kGreyShade4Color, width: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Icon(
                        Icons.arrow_back,
                        color: kGreyShade4Color,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200.h,
              left: 25.w,
              right: 25.w,
              child: Column(
                children: [
                  Material(
                    color: kWhiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: BorderSide(color: kPrimaryColor),
                    ),
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: controller.updateSearch,
                      cursorColor: kBlackColor,
                      style: AppStyles.blackTextStyle().copyWith(
                        fontSize: 17.sp,
                        color: kBlackColor,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search location",
                        hintStyle: AppStyles.blackTextStyle().copyWith(
                          fontSize: 15.sp,
                          color: kGreyColor,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear, size: 18.sp),
                          onPressed: controller.stopSearch,
                        ),
                        prefixIcon: Icon(Icons.search, size: 18.sp),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.predictions.isEmpty)
                      return const SizedBox.shrink();
                    return Container(
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.predictions.length,
                        itemBuilder: (context, index) {
                          final item = controller.predictions[index];
                          return ListTile(
                            title: Text(
                              item['description'],
                              style: AppStyles.blackTextStyle().copyWith(
                                color: kBlackColor,
                              ),
                            ),
                            onTap:
                                () => controller.selectPrediction(
                                  item['place_id'],
                                  item['description'],
                                ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            Positioned(
              top: 130.h,
              left: 20.w,
              right: 20.w,
              child: Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 13.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    controller.currentAddress.value,
                    maxLines: 2,
                    style: AppStyles.blackTextStyle().copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: kBlackColor,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 97.h,
              left: 27.w,
              right: 27.w,
              child: CustomButton(
                title: "Select",
                onTap: () {
                  Get.back(result: controller.currentAddress.value);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
