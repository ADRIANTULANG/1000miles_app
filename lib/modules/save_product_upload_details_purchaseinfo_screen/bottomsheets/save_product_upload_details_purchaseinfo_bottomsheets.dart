import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/icons_class.dart';
import '../controller/save_product_upload_details_purchaseinfo_controller.dart';

class ProductUploadDetailsPurchaseInfoBottomsheet {
  static showCurrencyBottomsheet(
      {required ProductUploadDetailsPurchaseInfoController controller}) {
    Get.bottomSheet(
        Container(
          height: 92.5.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 6.h,
                width: 100.w,
                padding: EdgeInsets.only(left: 5.w, top: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      CustomIcons.clear,
                      color: AppColor.black,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "Currency",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: AppColor.greyBlue,
                thickness: .2.w,
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  child: TextField(
                    obscureText: false,
                    style: TextStyle(
                        fontFamily: FontFamily.maloryLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColor.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.accentTorquise, width: .5.w),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.greyBlue, width: .5.w),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.accentTorquise, width: .5.w),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Search here',
                      hintStyle: TextStyle(
                          fontFamily: FontFamily.maloryLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColor.greyBlue),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Suggested for you",
                  style: TextStyle(
                      fontFamily: FontFamily.maloryBold,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.w, right: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "USD (USD Dollar)",
                      style: TextStyle(
                          fontFamily: FontFamily.maloryLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                    SvgPicture.asset(
                      CustomIcons.radiobutton,
                      color: AppColor.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Divider(),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 7.w, right: 7.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "CHY (Chinese renminbi)",
                      style: TextStyle(
                          fontFamily: FontFamily.maloryLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                    SvgPicture.asset(
                      CustomIcons.radiobutton,
                      color: AppColor.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Divider(),
              )
            ],
          ),
        ),
        isScrollControlled: true);
  }

  static showSuppliersBottomSheets(
      {required ProductUploadDetailsPurchaseInfoController controller}) async {
    Get.bottomSheet(
        Container(
          height: 92.5.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 6.h,
                width: 100.w,
                padding: EdgeInsets.only(left: 5.w, top: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      CustomIcons.clear,
                      color: AppColor.black,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "Supplier",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: AppColor.greyBlue,
                thickness: .2.w,
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 5.w),
                child: Text(
                  "Create new supplier",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  child: TextField(
                    obscureText: false,
                    style: TextStyle(
                      fontFamily: FontFamily.maloryLight,
                      fontWeight: FontWeight.w400,
                      color: AppColor.greyBlue,
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.accentTorquise, width: .5.w),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.greyBlue, width: .5.w),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.accentTorquise, width: .5.w),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'New supplier name',
                      hintStyle: TextStyle(
                        fontFamily: FontFamily.maloryLight,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyBlue,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, right: 5.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      CustomIcons.truck,
                      color: AppColor.black,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      "Or choose existing",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Supplier name ${index + 1}",
                                    style: TextStyle(
                                      fontFamily: FontFamily.maloryLight,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    CustomIcons.radiobutton,
                                    color: AppColor.black,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Divider(
                              color: AppColor.greyBlue,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        ),
        isScrollControlled: true);
  }
}
