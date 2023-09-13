import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

// import '../../../constant/icons_class.dart';
// import '../bottomsheets/save_product_upload_details_purchaseinfo_bottomsheets.dart';
import '../controller/save_product_upload_details_purchaseinfo_controller.dart';

class PurchaseInfoWidget
    extends GetView<ProductUploadDetailsPurchaseInfoController> {
  const PurchaseInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Entry.all(
              child: Text(
                "Purchase information",
                style: TextStyle(
                  fontFamily: FontFamily.maloryBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 2.w),
            //   child: Text(
            //     "Choose currency",
            //     style: TextStyle(
            //         fontFamily: FontFamily.maloryBold,
            //         fontWeight: FontWeight.w700,
            //         fontSize: 14.sp),
            //   ),
            // ),
            // SizedBox(
            //   height: .5.h,
            // ),
            // InkWell(
            //   onTap: () {
            //     ProductUploadDetailsPurchaseInfoBottomsheet
            //         .showCurrencyBottomsheet(controller: controller);
            //   },
            //   child: Container(
            //     height: 7.h,
            //     width: 100.w,
            //     padding: EdgeInsets.only(left: 3.w, right: 3.w),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: AppColor.greyBlue, width: .5.w),
            //         borderRadius: BorderRadius.circular(6)),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "USD | US Dollar",
            //           style: TextStyle(
            //             fontFamily: FontFamily.maloryLight,
            //             fontWeight: FontWeight.w400,
            //             fontSize: 14.sp,
            //             color: AppColor.greyBlue,
            //           ),
            //         ),
            //         SvgPicture.asset(
            //           CustomIcons.arrowdown,
            //           color: AppColor.black,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                "Purchase price",
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
                controller: controller.product_purchase_price,
                style: TextStyle(
                  fontFamily: FontFamily.maloryLight,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                  fontSize: 14.sp,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[11234567890.]'))
                ],
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
                  hintText: 'Enter a sum',
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
                "Min order quantity",
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
                controller: controller.product_minimum_order_quantiy,
                style: TextStyle(
                  fontFamily: FontFamily.maloryLight,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                  fontSize: 14.sp,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[11234567890]'))
                ],
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
                  hintText: 'Enter a number',
                  hintStyle: TextStyle(
                    fontFamily: FontFamily.maloryLight,
                    fontWeight: FontWeight.w400,
                    color: AppColor.greyBlue,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 2.h,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 2.w),
            //   child: Text(
            //     "Supplier name",
            //     style: TextStyle(
            //         fontFamily: FontFamily.maloryBold,
            //         fontWeight: FontWeight.w700,
            //         fontSize: 14.sp),
            //   ),
            // ),
            // SizedBox(
            //   height: .5.h,
            // ),
            // InkWell(
            //   onTap: () {
            //     ProductUploadDetailsPurchaseInfoBottomsheet
            //         .showSuppliersBottomSheets(controller: controller);
            //   },
            //   child: Container(
            //     height: 7.h,
            //     width: 100.w,
            //     padding: EdgeInsets.only(left: 3.w, right: 3.w),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: AppColor.greyBlue, width: .5.w),
            //         borderRadius: BorderRadius.circular(6)),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           "Select supplier",
            //           style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 14.sp,
            //               color: AppColor.greyBlue,
            //               fontFamily: FontFamily.maloryLight),
            //         ),
            //         SvgPicture.asset(
            //           CustomIcons.arrowdown,
            //           color: AppColor.black,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 22.h,
            // ),
            SizedBox(
              height: 43.h,
            ),
            Obx(() {
              if (controller.isCreatingProducts.value == false) {
                return InkWell(
                  onTap: () {
                    controller.createProduct();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Container(
                      height: 6.5.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.darkBlue),
                      alignment: Alignment.center,
                      child: Text(
                        "Save product",
                        style: TextStyle(
                            fontFamily: FontFamily.maloryBold,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: Container(
                    height: 6.5.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.darkBlue),
                    alignment: Alignment.center,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                );
              }
            }),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
}
