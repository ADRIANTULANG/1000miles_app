import 'dart:io';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../../preview_selected_idea_images_screen/view/preview_selected_idea_images_view.dart';
import '../../save_idea_and_details_screen/view/save_idea_and_details_view.dart';
import '../controller/select_photo_for_idea_controller.dart';

class SelectIdeaPhotoView extends GetView<SelectIdeaPhotoController> {
  const SelectIdeaPhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.white,
        padding: EdgeInsets.only(top: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Container(
                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                height: 7.h,
                width: 100.w,
                decoration: BoxDecoration(
                    border: controller.scrollPosition.value == 0.0
                        ? null
                        : Border(bottom: BorderSide(color: AppColor.greyBlue))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        print("here");
                        // if (controller.selected_images.length != 0) {
                        controller.image
                            .removeWhere((element) => element.isLast == true);
                        Get.to(() => PreviewSelectedIdeaImagesView(),
                            arguments: {
                              "isSavetoMyIdeas":
                                  controller.isSavetoMyIdeas.value,
                              "isFromHomescreen":
                                  controller.isFromHomescreen.value,
                              "projectID":
                                  controller.projectID.value.toString(),
                              "projectName":
                                  controller.projectName.value.toString(),
                              "groupID": controller.groupID.value.toString(),
                            });
                        // }
                      },
                      child: Container(
                        width: 25.w,
                        alignment: Alignment.centerLeft,
                        child: Showcase.withWidget(
                          height: 15.h,
                          width: 80.w,
                          key: controller.previewShowcase,
                          container: Padding(
                            padding: EdgeInsets.only(right: 5.w, top: 2.h),
                            child: Column(
                              children: [
                                Container(
                                  height: 2.h,
                                  width: 80.w,
                                  padding: EdgeInsets.only(right: 63.w),
                                  child: SvgPicture.asset(
                                    CustomIcons.arrowpointerup,
                                    color: AppColor.white,
                                  ),
                                ),
                                Container(
                                  height: 8.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      SvgPicture.asset(
                                        CustomIcons.information,
                                        color: AppColor.accentTorquise,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text("Tap to preview closer look."),
                                      SizedBox(
                                        width: 9.w,
                                      ),
                                      SvgPicture.asset(
                                        CustomIcons.clear,
                                        color: AppColor.darkBlue,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                    Container(
                      width: 25.w,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  CustomIcons.camera,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (controller.selected_images.length != 0) {
                                  Get.to(() => SaveIdeaAndDetailsView(),
                                      arguments: {
                                        "isSavetoMyIdeas":
                                            controller.isSavetoMyIdeas.value,
                                        "isFromHomescreen":
                                            controller.isFromHomescreen.value,
                                        "projectID": controller.projectID.value
                                            .toString(),
                                        "projectName": controller
                                            .projectName.value
                                            .toString(),
                                        "groupID":
                                            controller.groupID.value.toString(),
                                      });
                                } else {}
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Obx(
                                  () => Text(
                                    "Next",
                                    style: TextStyle(
                                      fontFamily: FontFamily.maloryBold,
                                      color:
                                          controller.selected_images.length == 0
                                              ? AppColor.greyBlue
                                              : AppColor.darkBlue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                fontFamily: FontFamily.maloryBold,
                                fontWeight: FontWeight.w700,
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
                child: Obx(
                  () => GridView.builder(
                    controller: controller.autoscroll_controller,
                    padding: EdgeInsets.all(0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: .5.w,
                        crossAxisSpacing: .5.w),
                    itemCount: controller.image.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AutoScrollTag(
                        key: ValueKey(index),
                        index: index,
                        controller: controller.autoscroll_controller,
                        child: controller.image[index].isLast == true
                            ? InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.darkBlue,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            color: Colors.white,
                                            fontFamily: FontFamily.maloryLight,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                          ),
                                        )
                                      ],
                                    )),
                              )
                            : index == 0
                                ? Showcase.withWidget(
                                    height: 15.h,
                                    width: 80.w,
                                    key: controller.selectPhotoShowcase,
                                    container: Padding(
                                      padding:
                                          EdgeInsets.only(right: 5.w, top: 2.h),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 2.h,
                                            width: 80.w,
                                            padding:
                                                EdgeInsets.only(right: 63.w),
                                            child: SvgPicture.asset(
                                              CustomIcons.arrowpointerup,
                                              color: AppColor.white,
                                            ),
                                          ),
                                          Container(
                                            height: 8.h,
                                            width: 80.w,
                                            decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                SvgPicture.asset(
                                                  CustomIcons.information,
                                                  color:
                                                      AppColor.accentTorquise,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                    "Tap to select the best photos."),
                                                SizedBox(
                                                  width: 9.w,
                                                ),
                                                SvgPicture.asset(
                                                  CustomIcons.clear,
                                                  color: AppColor.darkBlue,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: InkWell(
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
                                              child: Container(
                                                height: 15.h,
                                                width: 15.h,
                                                // decoration: BoxDecoration(
                                                //   image: DecorationImage(image: FileImage(File(controller
                                                //         .image[index].path),))
                                                // ),
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
                                                    // cacheHeight: 100,
                                                    // cacheWidth: 100,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      print(error);
                                                      return Container(
                                                        height: 15.h,
                                                        width: 15.h,
                                                        decoration:
                                                            BoxDecoration(
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
                                  )
                                : InkWell(
                                    onTap: () {
                                      if (controller
                                              .image[index].isSelected.value ==
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
                                                border: controller.image[index]
                                                            .isSelected.value ==
                                                        true
                                                    ? Border.all(
                                                        width: .7.w,
                                                        color: AppColor
                                                            .accentTorquise)
                                                    : null),
                                            child: Container(
                                              height: 15.h,
                                              width: 15.h,
                                              // decoration: BoxDecoration(
                                              //   image: DecorationImage(image: FileImage(File(controller
                                              //         .image[index].path),))
                                              // ),
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
                                                  // cacheHeight: 100,
                                                  // cacheWidth: 100,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    print(error);
                                                    return Container(
                                                      height: 15.h,
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
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Obx(
                () => Opacity(
                  opacity: controller.selected_images.length == 0 ? 0.4 : 1,
                  child: InkWell(
                    onTap: () {
                      if (controller.selected_images.length != 0) {
                        Get.to(() => SaveIdeaAndDetailsView(), arguments: {
                          "isSavetoMyIdeas": controller.isSavetoMyIdeas.value,
                          "isFromHomescreen": controller.isFromHomescreen.value,
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
      ),
    );
  }
}
