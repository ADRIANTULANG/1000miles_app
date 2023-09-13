import 'dart:io';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';
import '../../preview_selected_products_images_screen/view/preview_selected_product_images_view.dart';
import '../../save_product_upload_details_purchaseinfo_screen/view/save_product_upload_details_purchaseinfo_view.dart';
import '../controller/select_photo_for_product_controller.dart';

class SelectProductPhotoView extends GetView<SelectProductPhotoController> {
  const SelectProductPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Container(
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      border: controller.scrollPosition.value == 0.0
                          ? null
                          : Border(
                              bottom: BorderSide(color: AppColor.greyBlue))),
                  padding: EdgeInsets.only(right: 5.w, left: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (controller.selected_images.length != 0) {
                            Get.to(() => PreviewSelectedProductImagesView(),
                                arguments: {
                                  "isFromHomescreen":
                                      controller.isFromHomescreen.value,
                                  "projectID": controller.projectID.value,
                                  "projectName": controller.projectName.value,
                                  "groupID": controller.groupID.value
                                });
                          }
                        },
                        child: Container(
                          width: 25.w,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Preview",
                            style: TextStyle(
                              fontFamily: FontFamily.maloryLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => controller.scrollPosition.value == 0
                            ? SizedBox()
                            : Entry.all(
                                child: Text(
                                  "Select photos",
                                  style: TextStyle(
                                    fontFamily: FontFamily.maloryBold,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(
                                  () => ProductUploadDetailsPurchaseInfoView(),
                                  arguments: {
                                    "isFromHomescreen":
                                        controller.isFromHomescreen.value,
                                    "projectID": controller.projectID.value,
                                    "projectName": controller.projectName.value,
                                    "groupID": controller.groupID.value
                                  });
                            },
                            child: Container(
                              width: 25.w,
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
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Obx(
                () => controller.scrollPosition.value != 0.0
                    ? SizedBox()
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5.w, left: 5.w),
                            child: Entry.all(
                              // duration: Duration(milliseconds: 600),
                              child: Text(
                                "Select photos",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 5.w, left: 5.w),
                  child: Obx(
                    () => GridView.builder(
                      controller: controller.autoscroll_controller,
                      padding: EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: .5.h,
                          crossAxisSpacing: .5.w),
                      itemCount: controller.image.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AutoScrollTag(
                          key: ValueKey(index),
                          index: index,
                          controller: controller.autoscroll_controller,
                          child: controller.image[index].isLast == true
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 197, 194, 194),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: .5.h,
                                      ),
                                      Text(
                                        "Take more photo",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FontFamily.maloryLight,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                      )
                                    ],
                                  ))
                              : controller.image[index].isFirst == true
                                  ? InkWell(
                                      onTap: () {
                                        // controller.getPictureInGallery();
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 197, 194, 194),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.image_rounded,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: .5.h,
                                              ),
                                              Text(
                                                "Open gallery",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.maloryLight,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp,
                                                ),
                                              )
                                            ],
                                          )),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        if (controller.image[index].isSelected
                                                .value ==
                                            true) {
                                          controller.image[index].isSelected
                                              .value = false;
                                          controller.removeImage(
                                              imageToRemove:
                                                  controller.image[index]);
                                        } else {
                                          controller.image[index].isSelected
                                              .value = true;
                                          controller.addImage(
                                              imageSelected:
                                                  controller.image[index]);
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Obx(
                                            () => Container(
                                              decoration: BoxDecoration(
                                                  border: controller
                                                              .image[index]
                                                              .isSelected
                                                              .value ==
                                                          true
                                                      ? Border.all(
                                                          width: .7.w,
                                                          color: AppColor
                                                              .accentTorquise)
                                                      : null),
                                              child: Obx(
                                                () => Image.file(
                                                  File(controller
                                                      .image[index].path),
                                                  color: controller
                                                              .image[index]
                                                              .isSelected
                                                              .value ==
                                                          true
                                                      ? Colors.white
                                                          .withOpacity(0.5)
                                                      : null,
                                                  colorBlendMode: controller
                                                              .image[index]
                                                              .isSelected
                                                              .value ==
                                                          true
                                                      ? BlendMode.modulate
                                                      : null,
                                                  cacheHeight: 100,
                                                  cacheWidth: 100,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    print(error);
                                                    return Container(
                                                      height: 10.h,
                                                      width: 15.h,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                      ),
                                                      child: Center(
                                                        child:
                                                            Icon(Icons.error),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => controller.image[index]
                                                        .isSelected.value ==
                                                    true
                                                ? Positioned(
                                                    top: .5.h,
                                                    right: 1.5.w,
                                                    child: Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                      size: 15.sp,
                                                    ),
                                                  )
                                                : SizedBox(),
                                          )
                                        ],
                                      ),
                                    ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          controller.scrollToItem();
                        },
                        child: Icon(Icons.error_outline_rounded)),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "Please select up to 5 photos",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
