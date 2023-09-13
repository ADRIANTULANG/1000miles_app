import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
// import '../../product_upload_details_purchaseinfo_screen/view/product_upload_details_purchaseinfo_view.dart';

import '../../save_idea_and_details_screen/view/save_idea_and_details_view.dart';
import '../../select_photo_for_idea_screen/controller/select_photo_for_idea_controller.dart';
import '../../select_photo_for_idea_screen/model/select_photo_for_idea_model.dart';
import '../controller/preview_selected_idea_images_controller.dart';

class PreviewSelectedIdeaImagesView extends GetView<PreviewSelectedIdeaImage> {
  const PreviewSelectedIdeaImagesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PreviewSelectedIdeaImage());
    return WillPopScope(
      onWillPop: () async {
        PicturesIdeaModel map = PicturesIdeaModel(
            path: "", isFirst: false, isLast: true, isSelected: false.obs);
        Get.find<SelectIdeaPhotoController>().image.add(map);
        return true;
      },
      child: Scaffold(
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
                        alignment: Alignment.centerLeft,
                        width: 30.w,
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios_new_rounded),
                            SizedBox(
                              width: .5.w,
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
                        if (Get.find<SelectIdeaPhotoController>()
                                .selected_images
                                .length ==
                            0) {
                        } else {
                          Get.to(() => SaveIdeaAndDetailsView(), arguments: {
                            "isSavetoMyIdeas": controller.isSavetoMyIdeas.value,
                            "isFromHomescreen":
                                controller.isFromHomescreen.value,
                            "projectID": controller.projectID.value.toString(),
                            "projectName":
                                controller.projectName.value.toString(),
                            "groupID": controller.groupID.value.toString()
                          });
                        }
                      },
                      child: Container(
                        width: 30.w,
                        alignment: Alignment.centerRight,
                        child: Obx(
                          () => Text(
                            "Next",
                            style: TextStyle(
                                color: Get.find<SelectIdeaPhotoController>()
                                            .selected_images
                                            .length ==
                                        0
                                    ? AppColor.darkBlue.withOpacity(0.5)
                                    : AppColor.darkBlue,
                                fontFamily: FontFamily.maloryBold,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp),
                          ),
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
                                  Get.find<SelectIdeaPhotoController>()
                                      .image[index]
                                      .isSelected
                                      .value;
                            },
                            height: 55.h,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: false),
                        items: List.generate(
                          Get.find<SelectIdeaPhotoController>().image.length,
                          (index) {
                            return Container(
                              height: 55.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 70, 69, 69)),
                              child: Image.file(
                                File(Get.find<SelectIdeaPhotoController>()
                                    .image[index]
                                    .path),
                                fit: BoxFit.cover,
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
                    right: 6.w,
                    top: 2.h,
                    child: InkWell(
                      onTap: () {
                        if (controller.isSelectedImage.value == true) {
                          controller.isSelectedImage.value = false;
                          Get.find<SelectIdeaPhotoController>()
                              .image[controller.selectedImageIndex.value - 1]
                              .isSelected
                              .value = false;
                          Get.find<SelectIdeaPhotoController>().removeImage(
                              imageToRemove:
                                  Get.find<SelectIdeaPhotoController>().image[
                                      controller.selectedImageIndex.value - 1]);
                        } else {
                          controller.isSelectedImage.value = true;
                          Get.find<SelectIdeaPhotoController>()
                              .image[controller.selectedImageIndex.value - 1]
                              .isSelected
                              .value = true;
                          Get.find<SelectIdeaPhotoController>().addImage(
                              imageSelected:
                                  Get.find<SelectIdeaPhotoController>().image[
                                      controller.selectedImageIndex.value - 1]);
                        }
                      },
                      child: Obx(
                        () => controller.isSelectedImage.value == true
                            ? SvgPicture.asset(
                                CustomIcons.checkboxcheckedwhite,
                              )
                            : SvgPicture.asset(
                                CustomIcons.checkboxUnchecked,
                                color: AppColor.black,
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
                          "${controller.selectedImageIndex.value}/${Get.find<SelectIdeaPhotoController>().image.length}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Obx(
                  () => Opacity(
                    opacity: Get.find<SelectIdeaPhotoController>()
                                .selected_images
                                .length ==
                            0
                        ? 0.4
                        : 1,
                    child: InkWell(
                      onTap: () {
                        if (Get.find<SelectIdeaPhotoController>()
                                .selected_images
                                .length !=
                            0) {
                          Get.to(() => SaveIdeaAndDetailsView(), arguments: {
                            "isSavetoMyIdeas": controller.isSavetoMyIdeas.value,
                            "isFromHomescreen":
                                controller.isFromHomescreen.value,
                            "projectID": controller.projectID.value.toString(),
                            "projectName":
                                controller.projectName.value.toString(),
                            "groupID": controller.groupID.value.toString(),
                          });
                        } else {}
                      },
                      child: Container(
                          height: 6.5.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.darkBlue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.maloryBold,
                                    fontSize: 16.sp,
                                    color: AppColor.white),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              SvgPicture.asset(
                                CustomIcons.arrowright,
                                color: AppColor.white,
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
