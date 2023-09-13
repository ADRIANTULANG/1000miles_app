import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:badges/badges.dart' as badges;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/select_photo_for_product_controller.dart';
import '../model/select_photo_for_product_model.dart';
import 'select_photo_for_product_view.dart';

class CameraProductScreenView extends GetView<SelectProductPhotoController> {
  const CameraProductScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SelectProductPhotoController());
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: 100.h,
                width: 100.w,
                child: Stack(
                  children: [
                    Container(
                      height: 100.h,
                      width: 100.w,
                      child: CameraPreview(controller.cameraController!),
                    ),
                    Positioned(
                        child: Container(
                      height: 25.h,
                      width: 100.w,
                      padding:
                          EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 30.w,
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset(
                                CustomIcons.clear,
                                color: AppColor.white,
                                height: 2.h,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (controller.isFlashOn.value == true) {
                                controller.isFlashOn.value = false;
                                controller.cameraController!
                                    .setFlashMode(FlashMode.off);
                              } else {
                                controller.isFlashOn.value = true;
                                controller.cameraController!
                                    .setFlashMode(FlashMode.torch);
                              }
                            },
                            child: Container(
                              width: 15.w,
                              alignment: Alignment.center,
                              child: Obx(
                                () => controller.isFlashOn.value == true
                                    ? SvgPicture.asset(
                                        CustomIcons.flashon,
                                        color: AppColor.white,
                                      )
                                    : SvgPicture.asset(
                                        CustomIcons.flashoff,
                                        color: AppColor.white,
                                        height: 2.5.h,
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.storageImages.clear();
                            },
                            child: Container(
                              width: 30.w,
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                CustomIcons.trash,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Positioned(
                        bottom: 0.h,
                        child: Container(
                          height: 25.h,
                          width: 100.w,
                          padding: EdgeInsets.only(
                            left: 5.w,
                            right: 5.w,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  controller.getPicktureInGallery();
                                },
                                child: SvgPicture.asset(
                                  CustomIcons.imagegallery,
                                  color: AppColor.white,
                                  height: 6.h,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.onTapCamera.value = true;
                                  controller.player
                                      .play(AssetSource("sounds/camera.mp3"));
                                  var image = await controller.cameraController!
                                      .takePicture();
                                  PicturesProductModel map =
                                      PicturesProductModel(
                                          path: image.path,
                                          isFirst: false,
                                          isLast: false,
                                          isSelected: false.obs);
                                  controller.storageImages.add(map);
                                  controller.onTapCamera.value = false;
                                },
                                child: Obx(
                                  () => controller.onTapCamera.value == true
                                      ? SvgPicture.asset(
                                          CustomIcons.cameracaptureblue,
                                          // color: AppColor.white,
                                          height: 9.h,
                                        )
                                      : SvgPicture.asset(
                                          CustomIcons.cameracapture,
                                          color: AppColor.white,
                                          height: 9.h,
                                        ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await controller.newGallery();
                                  Get.to(() => SelectProductPhotoView());
                                },
                                child: Obx(
                                  () => controller.storageImages.length == 0
                                      ? SvgPicture.asset(
                                          CustomIcons.imagebrokenborder,
                                          color: AppColor.white,
                                          height: 6.h,
                                        )
                                      : badges.Badge(
                                          position: badges.BadgePosition(
                                              bottom: 4.5.h, start: 7.w),
                                          badgeColor: Colors.transparent,
                                          badgeContent: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppColor.accentTorquise),
                                            padding: EdgeInsets.only(
                                              left: 1.5.w,
                                              right: 1.5.w,
                                              top: .5.w,
                                              bottom: .5.w,
                                            ),
                                            child: Text(
                                              controller.storageImages.length
                                                          .toString()
                                                          .length ==
                                                      1
                                                  ? "0" +
                                                      controller
                                                          .storageImages.length
                                                          .toString()
                                                  : controller
                                                      .storageImages.length
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.white),
                                            ),
                                          ),
                                          child: Container(
                                            height: 6.5.h,
                                            width: 13.5.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: .3.w,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(File(controller
                                                        .storageImages[controller
                                                                .storageImages
                                                                .length -
                                                            1]
                                                        .path)))),
                                          ),
                                        ),
                                ),
                              )
                              // IconButton(
                              //   onPressed: () async {

                              //   },
                              //   icon: Icon(
                              //     Icons.camera,
                              //     color: Colors.white,
                              //   ),
                              // ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}
