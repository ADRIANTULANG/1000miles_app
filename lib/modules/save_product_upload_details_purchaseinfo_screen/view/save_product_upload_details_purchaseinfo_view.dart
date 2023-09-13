import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/save_product_upload_details_purchaseinfo_controller.dart';

class ProductUploadDetailsPurchaseInfoView
    extends GetView<ProductUploadDetailsPurchaseInfoController> {
  const ProductUploadDetailsPurchaseInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductUploadDetailsPurchaseInfoController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (controller.isFromHomescreen.value == true) {
            if (controller.carouselIndex.value == 0) {
              return true;
            } else if (controller.carouselIndex.value == 1) {
              FocusScope.of(context).unfocus();
              controller.carouselController.previousPage();
              return false;
            } else if (controller.carouselIndex.value == 2) {
              FocusScope.of(context).unfocus();
              controller.carouselController.previousPage();
              return false;
            } else {
              return true;
            }
          } else {
            if (controller.carouselIndex.value == 1) {
              FocusScope.of(context).unfocus();
              return true;
            } else if (controller.carouselIndex.value == 2) {
              FocusScope.of(context).unfocus();
              controller.carouselController.previousPage();
              return false;
            } else {
              return true;
            }
          }
        },
        child: SafeArea(
            child: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Container(
                height: 7.h,
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (controller.isFromHomescreen.value == true) {
                            if (controller.carouselIndex.value == 0) {
                              Get.back();
                            } else if (controller.carouselIndex.value == 1) {
                              FocusScope.of(context).unfocus();
                              controller.carouselController.previousPage();
                            } else if (controller.carouselIndex.value == 2) {
                              FocusScope.of(context).unfocus();
                              controller.carouselController.previousPage();
                            } else {}
                          } else {
                            if (controller.carouselIndex.value == 1) {
                              FocusScope.of(context).unfocus();
                              Get.back();
                            } else if (controller.carouselIndex.value == 2) {
                              FocusScope.of(context).unfocus();
                              controller.carouselController.previousPage();
                            } else {
                              Get.back();
                            }
                          }
                        },
                        child: Container(
                          width: 30.w,
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            CustomIcons.arrowbackios,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Obx(
                            () => controller.isFromHomescreen.value == false
                                ? SizedBox()
                                : Obx(
                                    () => SvgPicture.asset(
                                      controller.carouselIndex.value == 0
                                          ? CustomIcons.dotblue
                                          : CustomIcons.dotblack,
                                      color: controller.carouselIndex.value == 0
                                          ? AppColor.accentTorquise
                                          : AppColor.black,
                                    ),
                                  ),
                          ),
                          Obx(
                            () => controller.isFromHomescreen.value == false
                                ? SizedBox()
                                : SizedBox(
                                    width: 1.5.w,
                                  ),
                          ),
                          Obx(
                            () => SvgPicture.asset(
                              controller.carouselIndex.value == 1
                                  ? CustomIcons.dotblue
                                  : CustomIcons.dotblack,
                              color: controller.carouselIndex.value == 1
                                  ? AppColor.accentTorquise
                                  : AppColor.black,
                            ),
                          ),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          Obx(
                            () => SvgPicture.asset(
                              controller.carouselIndex.value == 2
                                  ? CustomIcons.dotblue
                                  : CustomIcons.dotblack,
                              color: controller.carouselIndex.value == 2
                                  ? AppColor.accentTorquise
                                  : AppColor.black,
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => controller.carouselIndex.value == 2
                            ? Obx(
                                () => controller.isCreatingProducts.value ==
                                        false
                                    ? InkWell(
                                        onTap: () {
                                          controller.createProduct();
                                        },
                                        child: Container(
                                          width: 30.w,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                              fontFamily: FontFamily.maloryBold,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 30.w,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                            fontFamily: FontFamily.maloryBold,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                              )
                            : InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  controller.carouselController.nextPage();
                                },
                                child: Container(
                                  width: 30.w,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                      fontFamily: FontFamily.maloryBold,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                child: Obx(
                  () => CarouselSlider(
                    carouselController: controller.carouselController,
                    options: CarouselOptions(
                        initialPage: controller.initialIndex.value,
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        onPageChanged: ((index, reason) {
                          controller.carouselIndex.value = index;
                        }),
                        height: 100.h,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false
                        // autoPlay: false,
                        ),
                    items: controller.views.map((view) {
                      return view;
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
