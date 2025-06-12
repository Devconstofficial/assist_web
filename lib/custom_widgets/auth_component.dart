import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../screens/auth/controller/auth_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_styles.dart';

class AuthComponent extends StatelessWidget {
  Widget content;
  bool withBackButton;
  AuthComponent({super.key,required this.content,this.withBackButton = false});

  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Stack(
                    children: [
                      Image.asset(
                        kAuthImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),


                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 55.w,),
            Expanded(
              child: SizedBox(
                height: height,
                child: Stack(
                  children: [
                    Positioned(
                        right: 0,
                        top: 0,
                        child: SvgPicture.asset(kDotsVerImage,height: 101.h,width: 62.w,)),
                    Positioned(
                        left: 20,
                        bottom: 0,
                        child: SvgPicture.asset(kDotsHorImage,height: 49.h,width: 130.w,)),
                    Positioned(
                        right: 30,
                        bottom: 0,
                        child: SvgPicture.asset(kPlayImage,height: 88.h,width: 108.w,)),
                    Padding(
                      padding: EdgeInsets.only(right: 50.w),
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                width: 1,
                                color: kBlackColor.withOpacity(0.25),
                              ),
                            ),
                            child: Padding(
                              padding: withBackButton == true ? const EdgeInsets.only(top: 42,right: 26,left: 74,bottom: 60) : EdgeInsets.symmetric(horizontal: 74,vertical: 70),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if(withBackButton == true)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: (){
                                                Get.back();
                                              },
                                              child: Container(
                                                height: 65,
                                                width: 65,
                                                decoration: BoxDecoration(
                                                    color: kWhiteColor,
                                                    borderRadius: BorderRadius.circular(100),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: kGreyShade7Color.withOpacity(0.11),
                                                          blurRadius: 22,
                                                          offset: Offset(0, 4)
                                                      )
                                                    ]
                                                ),
                                                child: Center(child: Icon(Icons.close,size: 24,color: kPrimaryColor,)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    Padding(
                                      padding: EdgeInsets.only(right: withBackButton == true ? 60.0 : 0),
                                      child: content,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
