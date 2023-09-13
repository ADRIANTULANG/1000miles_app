import 'dart:io';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../controller/save_product_upload_details_purchaseinfo_controller.dart';

class ProductDetailsWidget
    extends GetView<ProductUploadDetailsPurchaseInfoController> {
  const ProductDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      width: 100.w,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Entry.all(
              child: Text(
                "Product details",
                style: TextStyle(
                  fontFamily: FontFamily.maloryBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 12.h,
              width: 100.w,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.final_selected_images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 1.w, left: 1.w),
                      child: Container(
                        height: 12.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.greyBlue, width: .3.w),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(controller
                                    .final_selected_images[index].path)))),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                "Product name",
                style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Container(
              height: 7.h,
              width: 100.w,
              child: TextField(
                obscureText: false,
                controller: controller.product_name,
                style: TextStyle(
                  fontFamily: FontFamily.maloryLight,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.accentTorquise, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.greyBlue, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.accentTorquise, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  hintText: 'Product name',
                  hintStyle: TextStyle(
                    fontFamily: FontFamily.maloryLight,
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyBlue,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                "Category",
                style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Container(
              height: 7.h,
              width: 100.w,
              child: TextField(
                obscureText: false,
                controller: controller.product_category,
                style: TextStyle(
                  fontFamily: FontFamily.maloryLight,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.accentTorquise, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.greyBlue, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.accentTorquise, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  hintText: 'Product category',
                  hintStyle: TextStyle(
                    fontFamily: FontFamily.maloryLight,
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyBlue,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                "Product description",
                style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Container(
              height: 14.h,
              width: 100.w,
              child: TextField(
                obscureText: false,
                controller: controller.product_description,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                style: TextStyle(
                  fontFamily: FontFamily.maloryLight,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.accentTorquise, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.greyBlue, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.accentTorquise, width: .5.w),
                      borderRadius: BorderRadius.circular(6)),
                  hintText: 'Product description',
                  hintStyle: TextStyle(
                    fontFamily: FontFamily.maloryLight,
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyBlue,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 14.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    controller.carouselController.nextPage();
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: 6.5.h,
                    width: 43.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyBlue, width: .5.w),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Skip and save",
                      style: TextStyle(
                          fontFamily: FontFamily.maloryBold,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: AppColor.darkBlue),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.carouselController.nextPage();
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: 6.5.h,
                    width: 43.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.darkBlue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                              fontFamily: FontFamily.maloryBold,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: AppColor.white),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
}
