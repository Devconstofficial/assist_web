
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_styles.dart';
import 'custom_button.dart';
import 'custom_dialog.dart';
import 'field_container.dart';

Widget viewProfileDialog({bool isSubscriber = false}){
  return CustomDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 69),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: kPrimaryColor,
                                width: 0.5
                            )
                        ),
                        child: Center(child: Icon(Icons.arrow_back,size: 16,color: kPrimaryColor,)),
                      ),
                    ),
                  ),
                  SizedBox(width: 13.w,),
                  Text("Profile Details",style: AppStyles.blackTextStyle().copyWith(fontSize: 24),)
                ],
              ),
              SizedBox(height: 41.h,),
              Center(
                child: Container(
                  height: 105,
                  width: 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26)
                  ),
                  child: Image.asset(kProfilePictureImage,fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 24.h,),
              Column(
                spacing: 16.h,
                children: [
                  fieldContainer("Tayyaba"),
                  fieldContainer("tayyaba@gmail.com"),
                  fieldContainer("+92123456789"),
                ],
              ),
              SizedBox(height: 34.h,),
              isSubscriber == true ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: kGreyShade13Color
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 34,bottom: 16,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 20.h,
                        children: [
                          Text("Total Amount Donated",style: AppStyles.blackTextStyle().copyWith(fontSize: 18),),
                          Row(
                            children: [
                              Text("\$14,000",style: AppStyles.blackTextStyle().copyWith(fontSize: 34,fontWeight: FontWeight.w600),),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: kGreyShade5Color.withOpacity(0.22)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                                  child: Row(
                                    children: [
                                      Text("last year",style: AppStyles.blackTextStyle().copyWith(fontSize: 10,fontWeight: FontWeight.w600,color: kGreyShade10Color),),
                                      SizedBox(width: 4,),
                                      Icon(Icons.keyboard_arrow_down,size: 18,color: kGreyShade10Color,)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 21.h,),
                  Container(
                    decoration: BoxDecoration(
                      color: kGreyShade5Color.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(17),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(kDotsIcon,height: 30,width: 30,),
                                    SizedBox(width: 4,),
                                    Text("Standard Support",style: AppStyles.blackTextStyle().copyWith(fontSize: 12),)
                                  ],
                                ),
                                Divider(color: kBlackColor.withOpacity(0.12),),
                                Text("Help more people with a little extra support.",style: AppStyles.blackTextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.w400),)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: 19.h,
                            children: [
                              Container(
                                height: 42.h,
                                width: 102.w,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                  )
                                ),
                                child: Center(child: Text("\$5/month",style: AppStyles.whiteTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w700),)),
                              ),
                              Text("Start on 1 june",style: AppStyles.blackTextStyle().copyWith(fontSize: 10,fontWeight: FontWeight.w600,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ) :
              Row(
                children: [
                  Expanded(
                    child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(24),
                       border: Border.all(
                         color: kGreyShade13Color
                       ),
                     ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,top: 34,bottom: 16,right: 10),
                        child: Column(
                          spacing: 20.h,
                          children: [
                            Text("Total Applications",style: AppStyles.blackTextStyle().copyWith(fontSize: 18),),
                            Row(
                              children: [
                                Text("12",style: AppStyles.blackTextStyle().copyWith(fontSize: 34,fontWeight: FontWeight.w600),),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: kGreyShade5Color.withOpacity(0.22)
                                    )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                                    child: Row(
                                      children: [
                                        Text("last year",style: AppStyles.blackTextStyle().copyWith(fontSize: 10,fontWeight: FontWeight.w600,color: kGreyShade10Color),),
                                        SizedBox(width: 4,),
                                        Icon(Icons.keyboard_arrow_down,size: 18,color: kGreyShade10Color,)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 19.w,),
                  Expanded(
                    child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(24),
                       border: Border.all(
                         color: kGreyShade13Color
                       ),
                     ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,top: 34,bottom: 16,right: 10),
                        child: Column(
                          spacing: 20.h,
                          children: [
                            Text("Denied  Applications",style: AppStyles.blackTextStyle().copyWith(fontSize: 18),),
                            Row(
                              children: [
                                Text("3",style: AppStyles.blackTextStyle().copyWith(fontSize: 34,fontWeight: FontWeight.w600),),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: kGreyShade5Color.withOpacity(0.22)
                                    )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12),
                                    child: Row(
                                      children: [
                                        Text("last year",style: AppStyles.blackTextStyle().copyWith(fontSize: 10,fontWeight: FontWeight.w600,color: kGreyShade10Color),),
                                        SizedBox(width: 4,),
                                        Icon(Icons.keyboard_arrow_down,size: 18,color: kGreyShade10Color,)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isSubscriber == true ? 99.h : 65.h,),
              CustomButton(title: "Message", onTap: (){},height: 61,color: kGreyShade13Color,borderColor: kPrimaryColor,textColor: kPrimaryColor,textSize: 16,fontWeight: FontWeight.w700,),
              SizedBox(height: 14.h,),
              CustomButton(title: "Approve", onTap: (){},height: 61,textSize: 16,fontWeight: FontWeight.w700,),
              SizedBox(height: 14.h,),
              CustomButton(title: "Reject", onTap: (){},height: 61,color: kGreyShade13Color,borderColor: kGreyShade13Color,textColor: kPrimaryColor,textSize: 16,fontWeight: FontWeight.w700,),

            ],
          ),
        ),
      ));
}