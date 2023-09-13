import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:badges/badges.dart' as badges;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/select_photo_for_idea_controller.dart';
import '../model/select_photo_for_idea_model.dart';
import 'select_photo_for_idea_view.dart';

class CameraIdeaScreenView extends GetView<SelectIdeaPhotoController> {
  const CameraIdeaScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SelectIdeaPhotoController());
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
                              width: 20.w,
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
                              if (controller.isCameraFlashON.value == false) {
                                controller.isCameraFlashON.value = true;
                                controller.cameraController!
                                    .setFlashMode(FlashMode.torch);
                              } else {
                                controller.isCameraFlashON.value = false;

                                controller.cameraController!
                                    .setFlashMode(FlashMode.off);
                              }
                            },
                            child: Container(
                              width: 20.w,
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                CustomIcons.flashoff,
                                color: AppColor.white,
                                height: 2.5.h,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              controller.getPicktureInGallery();
                            },
                            child: Container(
                              width: 20.w,
                              alignment: Alignment.centerRight,
                              child: Showcase.withWidget(
                                height: 15.h,
                                width: 90.w,
                                key: controller.photoLibraryShowcase,
                                disposeOnTap: true,
                                container: Padding(
                                  padding:
                                      EdgeInsets.only(right: 2.w, top: 2.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 2.h,
                                        width: 90.w,
                                        alignment: Alignment.bottomRight,
                                        padding: EdgeInsets.only(right: 3.w),
                                        child: SvgPicture.asset(
                                          CustomIcons.arrowpointerup,
                                          color: AppColor.white,
                                        ),
                                      ),
                                      Container(
                                        height: 18.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Container(
                                              width: 90.w,
                                              padding:
                                                  EdgeInsets.only(right: 4.w),
                                              alignment: Alignment.centerRight,
                                              child: SvgPicture.asset(
                                                CustomIcons.clear,
                                                color: AppColor.darkBlue,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                              width: 90.w,
                                              padding:
                                                  EdgeInsets.only(left: 4.w),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Photo library",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18.sp,
                                                    color: AppColor.darkBlue,
                                                    fontFamily:
                                                        FontFamily.maloryBold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Container(
                                              width: 90.w,
                                              padding:
                                                  EdgeInsets.only(left: 4.w),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "You can also choose photos from your photo library.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: AppColor.darkBlue,
                                                    fontFamily:
                                                        FontFamily.maloryLight),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  CustomIcons.addimages,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     controller.storageImages.clear();
                          //     controller.image.clear();
                          //     controller.selected_images.clear();
                          //   },
                          //   child: SvgPicture.asset(
                          //     CustomIcons.trash,
                          //     color: AppColor.white,
                          //   ),
                          // ),
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
                                  // await controller.newGallery();
                                  // Get.to(() => SelectIdeaPhotoView());
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
                                              bottom: 4.h, start: 7.w),
                                          badgeColor: Colors.transparent,
                                          badgeContent: CircleAvatar(
                                            backgroundColor:
                                                AppColor.accentTorquise,
                                            radius: 3.w,
                                            child: Text(
                                              controller.storageImages.length
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.white),
                                            ),
                                          ),
                                          child: Container(
                                            height: 6.h,
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
                              ),
                              // InkWell(
                              //   onTap: () async {
                              //     controller.getPicktureInGallery();
                              //   },
                              //   child: SvgPicture.asset(
                              //     CustomIcons.imagegallery,
                              //     color: AppColor.white,
                              //     height: 6.h,
                              //   ),
                              // ),
                              Showcase.withWidget(
                                height: 15.h,
                                width: 80.w,
                                key: controller.capturePhotoShowcase,
                                disposeOnTap: true,
                                container: Padding(
                                  padding:
                                      EdgeInsets.only(right: 2.w, top: 2.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 15.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Container(
                                              width: 90.w,
                                              padding:
                                                  EdgeInsets.only(right: 4.w),
                                              alignment: Alignment.centerRight,
                                              child: SvgPicture.asset(
                                                CustomIcons.clear,
                                                color: AppColor.darkBlue,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                              width: 90.w,
                                              padding:
                                                  EdgeInsets.only(left: 4.w),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Take pictures",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18.sp,
                                                    color: AppColor.darkBlue,
                                                    fontFamily:
                                                        FontFamily.maloryBold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Container(
                                              width: 90.w,
                                              padding:
                                                  EdgeInsets.only(left: 4.w),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Take more pictures for your ideas.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: AppColor.darkBlue,
                                                    fontFamily:
                                                        FontFamily.maloryLight),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 2.h,
                                        width: 90.w,
                                        child: SvgPicture.asset(
                                          CustomIcons.arrowpointer,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    controller.onTapCamera.value = true;
                                    var image = await controller
                                        .cameraController!
                                        .takePicture();
                                    File file = await File(image.path);

                                    int quality = 70;
                                    int percentage = 70;
                                    final bytes =
                                        file.readAsBytesSync().lengthInBytes;
                                    final kb = bytes / 1024;

                                    if (kb > 900) {
                                      quality = 25;
                                      percentage = 25;
                                    } else if (kb < 900 && kb > 300) {
                                      quality = 50;
                                      percentage = 50;
                                    }

                                    print(quality.toString() +
                                        "  " +
                                        percentage.toString());

                                    File compressedFile =
                                        await FlutterNativeImage.compressImage(
                                            file.path,
                                            quality: quality,
                                            percentage: percentage);

                                    final kbnew = compressedFile
                                            .readAsBytesSync()
                                            .lengthInBytes /
                                        1024;
                                    print("image size is $kbnew KB");

                                    controller.player
                                        .play(AssetSource("sounds/camera.mp3"));
                                    PicturesIdeaModel map = PicturesIdeaModel(
                                        path: compressedFile.path,
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
                              ),
                              InkWell(
                                onTap: () async {
                                  if (controller.storageImages.length != 0) {
                                    controller.setShowcaseSelectPhotos();
                                    controller.isForwardCameraPress.value =
                                        true;
                                    await controller.newGallery();
                                    Future.delayed(Duration(milliseconds: 300),
                                        () {
                                      controller.isForwardCameraPress.value =
                                          false;
                                      Get.to(() => SelectIdeaPhotoView());
                                    });
                                  } else {}
                                },
                                child: Obx(
                                  () => controller.isForwardCameraPress.value ==
                                          false
                                      ? SvgPicture.asset(
                                          CustomIcons.nextcamerawhite,
                                          color: AppColor.white,
                                          height: 6.h,
                                        )
                                      : SvgPicture.asset(
                                          CustomIcons.nextcamerablue,
                                          height: 6.h,
                                        ),
                                ),
                              )
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
