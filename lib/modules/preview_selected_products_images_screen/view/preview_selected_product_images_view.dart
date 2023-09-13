import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../../save_product_upload_details_purchaseinfo_screen/view/save_product_upload_details_purchaseinfo_view.dart';
import '../../select_photo_for_product_screen/controller/select_photo_for_product_controller.dart';
import '../controller/preview_selected_product_images_controller.dart';

class PreviewSelectedProductImagesView
    extends GetView<PreviewSelectedProductImage> {
  const PreviewSelectedProductImagesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PreviewSelectedProductImage());
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              height: 8.h,
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 30.w,
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            CustomIcons.arrowbackios,
                            color: AppColor.black,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "All photos",
                            style: TextStyle(
                                fontFamily: FontFamily.maloryLight,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Preview",
                    style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ProductUploadDetailsPurchaseInfoView(),
                          arguments: {
                            "isFromHomescreen":
                                controller.isFromHomescreen.value,
                            "projectID": controller.projectID.value,
                            "projectName": controller.projectName.value,
                            "groupID": controller.groupID.value
                          });
                    },
                    child: Container(
                      width: 30.w,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontFamily: FontFamily.maloryBold,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Stack(
              children: [
                Container(
                  height: 55.h,
                  width: 100.w,
                  child: Obx(
                    () => CarouselSlider(
                      carouselController: controller.carouselController,
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            controller.selectedImageIndex.value = index + 1;
                            controller.isSelectedImage.value =
                                Get.find<SelectProductPhotoController>()
                                    .selected_images[index]
                                    .isSelected
                                    .value;
                          },
                          height: 55.h,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: false),
                      items: List.generate(
                        Get.find<SelectProductPhotoController>()
                            .selected_images
                            .length,
                        (index) {
                          return Container(
                            height: 55.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 70, 69, 69)),
                            child: Image.file(
                              File(Get.find<SelectProductPhotoController>()
                                  .selected_images[index]
                                  .path),
                              // fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print(error);
                                return Container(
                                  height: 10.h,
                                  width: 15.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  child: Center(
                                    child: Icon(Icons.error),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 3.w,
                    top: 24.h,
                    child: InkWell(
                      onTap: () {
                        controller.carouselController.previousPage();
                      },
                      child: CircleAvatar(
                          radius: 6.w,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.black,
                            size: 13.sp,
                          )),
                    )),
                Positioned(
                    right: 3.w,
                    top: 24.h,
                    child: InkWell(
                      onTap: () {
                        controller.carouselController.nextPage();
                      },
                      child: CircleAvatar(
                          radius: 6.w,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 13.sp,
                          )),
                    )),
                Positioned(
                  right: 3.w,
                  top: 48.h,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Obx(
                      () => Text(
                        "${controller.selectedImageIndex.value}/${Get.find<SelectProductPhotoController>().selected_images.length}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${Get.find<SelectProductPhotoController>().selected_images.length}/${Get.find<SelectProductPhotoController>().image.length - 1} selected",
                      style: TextStyle(
                          fontFamily: FontFamily.maloryLight,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        if (Get.find<SelectProductPhotoController>()
                                .selected_images[
                                    controller.selectedImageIndex.value - 1]
                                .isSelected
                                .value ==
                            false) {
                          Get.find<SelectProductPhotoController>()
                              .selected_images[
                                  controller.selectedImageIndex.value - 1]
                              .isSelected
                              .value = true;
                          controller.isSelectedImage.value =
                              Get.find<SelectProductPhotoController>()
                                  .selected_images[
                                      controller.selectedImageIndex.value - 1]
                                  .isSelected
                                  .value;
                          controller.setImageSelectedtoTrue(
                              imageModel:
                                  Get.find<SelectProductPhotoController>()
                                          .selected_images[
                                      controller.selectedImageIndex.value - 1]);
                          print(true);
                        } else {
                          Get.find<SelectProductPhotoController>()
                              .selected_images[
                                  controller.selectedImageIndex.value - 1]
                              .isSelected
                              .value = false;
                          controller.isSelectedImage.value =
                              Get.find<SelectProductPhotoController>()
                                  .selected_images[
                                      controller.selectedImageIndex.value - 1]
                                  .isSelected
                                  .value;
                          controller.setImageSelectedtoFalse(
                              imageModel:
                                  Get.find<SelectProductPhotoController>()
                                          .selected_images[
                                      controller.selectedImageIndex.value - 1]);
                          print(false);
                        }
                      },
                      child: Obx(
                        () => controller.isSelectedImage.value == true
                            ? SvgPicture.asset(
                                CustomIcons.checkboxchecked,
                                color: AppColor.black,
                              )
                            : SvgPicture.asset(
                                CustomIcons.checkboxUnchecked,
                                color: AppColor.black,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
