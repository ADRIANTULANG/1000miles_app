import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/config/endpoints.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../../idea_details_screen/view/idea_detail_view.dart';
import '../../select_photo_for_idea_screen/controller/select_photo_for_idea_controller.dart';
import '../../select_photo_for_idea_screen/model/select_photo_for_idea_model.dart';
import '../../select_photo_for_idea_screen/view/select_photo_for_idea_camera_view.dart';
import '../controller/project_ideas_gallery_controller.dart';
import '../dialog/project_ideas_gallery_dialog.dart';
import '../model/final_project_ideas_gallery_model.dart';
import '../view/project_ideas_move_ideas.dart';

class ProjectIdeaGallerBottomsheet {
  static showBottomSheetButtonAndroid(
      {required ProjectIdeasGalleryController controller,
      required BuildContext context}) {
    Get.bottomSheet(Container(
      height: 25.h,
      width: 100.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
      child: Column(
        children: [
          // InkWell(
          //   onTap: () {
          //     // Get.to(() => MsSignInPage(
          //     //       title: "",
          //     //     ));
          //   },
          //   child: Row(
          //     children: [
          //       SvgPicture.asset(
          //         CustomIcons.qrcode,
          //         color: AppColor.black,
          //       ),
          //       SizedBox(
          //         width: 5.w,
          //       ),
          //       Text(
          //         "Yoooto scanner",
          //         style: TextStyle(
          //           fontFamily: FontFamily.maloryBold,
          //           fontWeight: FontWeight.w400,
          //           fontSize: 14.sp,
          //           color: AppColor.black,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            onTap: () async {
              await controller.getAllIdeass();
              Get.back();
              showCreateGroupBottomSheet(controller: controller);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.folder,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Create Group",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.darkBlue,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final List<XFile>? images = await picker.pickMultiImage();
              if (images == null) {
                Get.back();
              } else if (images.length == 0) {
                Get.back();
              } else {
                Get.back();
                Get.to(() => CameraIdeaScreenView(), arguments: {
                  "isSavetoMyIdeas": false,
                  "isFromHomescreen": false,
                  "projectID": controller.projectID.value.toString(),
                  "projectName": controller.projectName.value.toString(),
                  "groupID": ""
                });
                Future.delayed(Duration(seconds: 1), () async {
                  for (var i = 0; i < images.length; i++) {
                    File file = await File(images[i].path);

                    int quality = 70;
                    int percentage = 70;
                    final bytes = file.readAsBytesSync().lengthInBytes;
                    final kb = bytes / 1024;

                    if (kb > 900) {
                      quality = 30;
                      percentage = 30;
                    } else if (kb < 900 && kb > 300) {
                      quality = 50;
                      percentage = 50;
                    }

                    print(quality.toString() + "  " + percentage.toString());

                    File compressedFile =
                        await FlutterNativeImage.compressImage(file.path,
                            quality: quality, percentage: percentage);

                    final kbnew =
                        compressedFile.readAsBytesSync().lengthInBytes / 1024;
                    print("image size is $kbnew KB");

                    PicturesIdeaModel map = PicturesIdeaModel(
                        path: compressedFile.path,
                        isFirst: false,
                        isLast: false,
                        isSelected: false.obs);

                    Get.find<SelectIdeaPhotoController>()
                        .storageImages
                        .add(map);
                  }
                });
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.addimages,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Choose from Library",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.darkBlue,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: () {
              Get.back();
              Get.to(() => CameraIdeaScreenView(), arguments: {
                "isSavetoMyIdeas": false,
                "isFromHomescreen": false,
                "projectID": controller.projectID.value.toString(),
                "projectName": controller.projectName.value.toString(),
                "groupID": ""
              });
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.camera,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Take a photo",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.darkBlue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  static showCreateGroupBottomSheet(
      {required ProjectIdeasGalleryController controller}) {
    controller.groupName.clear();
    for (var i = 0; i < controller.createGroupIdeaList.length; i++) {
      controller.createGroupIdeaList[i].isSelected.value = false;
    }
    Get.bottomSheet(
        Obx(
          () => Container(
            height: controller.isKeyboardOpen.value == true ? 61.h : 94.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontFamily: FontFamily.maloryLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          ProjectIdeaGalleryDialog.showLoadingScreen();
                          await controller.createGroup();
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontFamily: FontFamily.maloryLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp),
                        ),
                      ),
                      // SvgPicture.asset(
                      //   CustomIcons.threelinesmalltobig,
                      //   color: AppColor.black,
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Create Group",
                      style: TextStyle(
                          fontFamily: FontFamily.maloryBold,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Container(
                    height: 7.h,
                    width: 100.w,
                    child: TextField(
                      obscureText: false,
                      controller: controller.groupName,
                      focusNode: controller.createnameTextFocusNode,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.maloryLight,
                          fontSize: 14.sp,
                          color: AppColor.darkBlue),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.accentTorquise, width: .5.w),
                            borderRadius: BorderRadius.circular(6)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.greyBlue, width: .5.w),
                            borderRadius: BorderRadius.circular(6)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.accentTorquise, width: .5.w),
                            borderRadius: BorderRadius.circular(6)),
                        hintText: 'Enter group name',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.maloryLight,
                            fontSize: 14.sp,
                            color: AppColor.greyBlue),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select ideas",
                      style: TextStyle(
                          fontFamily: FontFamily.maloryBold,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Expanded(
                  child: Obx(
                    () => controller.createGroupIdeaList.length == 0
                        ? Container(
                            padding: EdgeInsets.only(top: 3.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  CustomIcons.addimages,
                                  color: AppColor.greyBlue,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  "No product ideas available ",
                                  style: TextStyle(
                                      fontFamily: FontFamily.maloryBold,
                                      color: AppColor.greyBlue,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                )
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: .7,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 0.h,
                                      crossAxisSpacing: 2.w),
                              itemCount: controller.createGroupIdeaList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (controller.createGroupIdeaList[index]
                                            .isSelected.value ==
                                        true) {
                                      controller.createGroupIdeaList[index]
                                          .isSelected.value = false;
                                    } else {
                                      controller.createGroupIdeaList[index]
                                          .isSelected.value = true;
                                    }
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  AppEndpoint.endPointFile +
                                                      "/" +
                                                      controller
                                                          .createGroupIdeaList[
                                                              index]
                                                          .file
                                                          .toString(),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: controller
                                                            .createGroupIdeaList[
                                                                index]
                                                            .label ==
                                                        ""
                                                    ? 26.h
                                                    : 23.h,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: .5,
                                                        blurRadius: 3,
                                                        color:
                                                            AppColor.boxShadow,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ],
                                                    border: Border.all(
                                                        width: 0.5.sp,
                                                        color:
                                                            AppColor.greyBlue),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: imageProvider)),
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: controller
                                                            .createGroupIdeaList[
                                                                index]
                                                            .label ==
                                                        ""
                                                    ? 26.h
                                                    : 23.h,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: .5,
                                                        blurRadius: 3,
                                                        color:
                                                            AppColor.boxShadow,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ],
                                                    border: Border.all(
                                                        width: 0.5.sp,
                                                        color:
                                                            AppColor.greyBlue),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "assets/images/transparent.jpg"))),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                height: controller
                                                            .createGroupIdeaList[
                                                                index]
                                                            .label ==
                                                        ""
                                                    ? 26.h
                                                    : 23.h,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: .5,
                                                        blurRadius: 3,
                                                        color:
                                                            AppColor.boxShadow,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ],
                                                    border: Border.all(
                                                        width: 0.5.sp,
                                                        color:
                                                            AppColor.greyBlue),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "assets/images/transparent.jpg"))),
                                              ),
                                            ),
                                            Positioned(
                                              right: 2.w,
                                              top: 1.h,
                                              child: InkWell(
                                                onTap: () {
                                                  if (controller
                                                          .createGroupIdeaList[
                                                              index]
                                                          .isSelected
                                                          .value ==
                                                      true) {
                                                    controller
                                                        .createGroupIdeaList[
                                                            index]
                                                        .isSelected
                                                        .value = false;
                                                  } else {
                                                    controller
                                                        .createGroupIdeaList[
                                                            index]
                                                        .isSelected
                                                        .value = true;
                                                  }
                                                },
                                                child: Obx(
                                                  () => controller
                                                              .createGroupIdeaList[
                                                                  index]
                                                              .isSelected
                                                              .value ==
                                                          true
                                                      ? SvgPicture.asset(
                                                          CustomIcons
                                                              .checkboxcheckedwhite,
                                                        )
                                                      : SvgPicture.asset(
                                                          CustomIcons
                                                              .checkboxUnchecked,
                                                          color: AppColor.black,
                                                        ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: .5.h,
                                        ),
                                        controller.createGroupIdeaList[index]
                                                    .label ==
                                                ""
                                            ? SizedBox()
                                            : Padding(
                                                padding:
                                                    EdgeInsets.only(left: 2.w),
                                                child: Text(
                                                  controller
                                                      .createGroupIdeaList[
                                                          index]
                                                      .label
                                                      .capitalizeFirst
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.maloryBold,
                                                      color: AppColor.darkBlue,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.sp),
                                                ),
                                              ),
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
                  child: InkWell(
                    onTap: () async {
                      ProjectIdeaGalleryDialog.showLoadingScreen();
                      await controller.createGroup();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 7.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Save group",
                          style: TextStyle(
                              fontFamily: FontFamily.maloryBold,
                              color: AppColor.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp),
                        )),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          ),
        ),
        isScrollControlled: true);
  }

  static showGroupIdeas(
      {required ProjectIdeasGalleryController controller,
      required RxString projectName,
      required String nameofthegroup,
      required String groupID}) {
    print("groupid: ${groupID}");
    Get.bottomSheet(
        WillPopScope(
          onWillPop: () async {
            if (controller.isEditing_for_bottomsheet.value == false) {
              controller.isEditing_for_bottomsheet.value = true;
              return true;
            } else {
              controller.isEditing_for_bottomsheet.value = false;
              controller.selectAll.value = false;
              controller.selectAllAndDeSelectAll();
              return false;
            }
          },
          child: Container(
            height: 93.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: Column(
              children: [
                Obx(
                  () => Container(
                    height: 7.h,
                    width: 100.w,
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    decoration: BoxDecoration(
                        boxShadow:
                            controller.scrollPosition_groupitems.value == 0.0
                                ? []
                                : [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        color: AppColor.greyBlue)
                                  ],
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => controller.isEditing_for_bottomsheet.value ==
                                  false
                              ? Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        width: 8.w,
                                        alignment: Alignment.centerLeft,
                                        child: Platform.isIOS
                                            ? SvgPicture.asset(
                                                CustomIcons.arrowbackios,
                                                color: AppColor.black,
                                              )
                                            : SvgPicture.asset(
                                                CustomIcons.arrowback,
                                                color: AppColor.black,
                                              ),
                                      ),
                                    ),
                                    Obx(
                                      () => controller.scrollPosition_groupitems
                                                  .value ==
                                              0.0
                                          ? Obx(
                                              () => Text(
                                                projectName
                                                    .value.capitalizeFirst
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.maloryLight,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp),
                                              ),
                                            )
                                          : SizedBox(),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (controller.selectAll.value ==
                                            true) {
                                          controller.selectAll.value = false;
                                        } else {
                                          controller.selectAll.value = true;
                                        }
                                        controller.selectAllAndDeSelectAll();
                                      },
                                      child: Obx(
                                        () => Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            controller.selectAll.value == true
                                                ? "Deselect All"
                                                : "Select All",
                                            style: TextStyle(
                                                color: AppColor.darkBlue,
                                                fontFamily:
                                                    FontFamily.maloryBold,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                        Obx(
                          () =>
                              controller.scrollPosition_groupitems.value == 0.0
                                  ? SizedBox()
                                  : Obx(
                                      () => Text(
                                        controller
                                            .selectedNameoftheGroupBottomSheet
                                            .value
                                            .capitalizeFirst
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: FontFamily.maloryBold,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                        ),
                        InkWell(
                          onTap: () {
                            //please uncomment later to edit the group.
                            if (controller.isEditing_for_bottomsheet.value ==
                                false) {
                              controller.isEditing_for_bottomsheet.value = true;
                            } else {
                              controller.isEditing_for_bottomsheet.value =
                                  false;
                              controller.selectAll.value = false;
                              controller.selectAllAndDeSelectAll();
                            }
                          },
                          child: Obx(
                            () => controller.isEditing_for_bottomsheet.value ==
                                    false
                                ? Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontFamily: FontFamily.maloryLight,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp),
                                    ),
                                  )
                                : Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryLight,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => controller.scrollPosition_groupitems.value == 0.0
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.w, left: 5.w),
                              child: Container(
                                width: 100.w,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      CustomIcons.folder,
                                      color: AppColor.black,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller
                                            .selectedNameoftheGroupBottomSheet
                                            .value
                                            .capitalizeFirst
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: FontFamily.maloryBold,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.darkBlue,
                                            fontSize: 20.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: Obx(
                      () => GridView.builder(
                        controller: controller.scrollController_groupitems,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .8,
                            crossAxisCount: 2,
                            mainAxisSpacing: 2.h,
                            crossAxisSpacing: 2.w),
                        itemCount: controller.displayGroupItemsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              if (controller.isEditing_for_bottomsheet.value ==
                                  true) {
                                if (controller.displayGroupItemsList[index]
                                        .isSelected.value ==
                                    false) {
                                  controller.displayGroupItemsList[index]
                                      .isSelected.value = true;
                                } else {
                                  controller.displayGroupItemsList[index]
                                      .isSelected.value = false;
                                }
                              } else {
                                print("age dre");
                                Get.to(() => IdeaDetailView(),
                                    arguments: {
                                      "ideaID": controller
                                          .displayGroupItemsList[index].ideaId,
                                      "projectID": controller.projectID.value,
                                      "groupID": groupID,
                                    },
                                    preventDuplicates: false);
                              }
                            },
                            onLongPress: () {
                              controller.isEditing_for_bottomsheet.value = true;
                              controller.displayGroupItemsList[index].isSelected
                                  .value = true;
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: AppEndpoint.endPointFile +
                                            "/" +
                                            controller
                                                .displayGroupItemsList[index]
                                                .file
                                                .toString(),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: controller
                                                      .displayGroupItemsList[
                                                          index]
                                                      .label ==
                                                  ""
                                              ? 26.h
                                              : 23.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: .5,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                    color: AppColor.boxShadow)
                                              ],
                                              border: Border.all(
                                                  color: AppColor.greyBlue),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: imageProvider)),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          height: controller
                                                      .displayGroupItemsList[
                                                          index]
                                                      .label ==
                                                  ""
                                              ? 26.h
                                              : 23.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      "assets/images/transparent.jpg"))),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          height: controller
                                                      .displayGroupItemsList[
                                                          index]
                                                      .label ==
                                                  ""
                                              ? 26.h
                                              : 23.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      "assets/images/transparent.jpg"))),
                                        ),
                                      ),
                                      Positioned(
                                        right: 2.w,
                                        top: .7.h,
                                        child: Obx(
                                          () => controller
                                                      .isEditing_for_bottomsheet
                                                      .value ==
                                                  true
                                              ? InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .displayGroupItemsList[
                                                                index]
                                                            .isSelected
                                                            .value ==
                                                        false) {
                                                      controller
                                                          .displayGroupItemsList[
                                                              index]
                                                          .isSelected
                                                          .value = true;
                                                    } else {
                                                      controller
                                                          .displayGroupItemsList[
                                                              index]
                                                          .isSelected
                                                          .value = false;
                                                    }
                                                  },
                                                  child: Obx(
                                                    () => controller
                                                                .displayGroupItemsList[
                                                                    index]
                                                                .isSelected
                                                                .value ==
                                                            false
                                                        ? SvgPicture.asset(
                                                            CustomIcons
                                                                .checkboxUnchecked,
                                                            color:
                                                                AppColor.black,
                                                          )
                                                        : SvgPicture.asset(
                                                            CustomIcons
                                                                .checkboxcheckedwhite,
                                                          ),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ),
                                      )
                                    ],
                                  ),
                                  controller.displayGroupItemsList[index]
                                              .label ==
                                          ""
                                      ? SizedBox()
                                      : Column(
                                          children: [
                                            SizedBox(
                                              height: .2.h,
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 3.w),
                                              width: 100.w,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                controller
                                                    .displayGroupItemsList[
                                                        index]
                                                    .label
                                                    .capitalizeFirst
                                                    .toString(),
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      FontFamily.maloryBold,
                                                  fontSize: 12.sp,
                                                  color: AppColor.darkBlue,
                                                ),
                                              ),
                                            ),
                                          ],
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
                Obx(
                  () => controller.isEditing_for_bottomsheet.value == false
                      ? Container(
                          padding: EdgeInsets.only(right: 5.w, left: 5.w),
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border(
                                top: BorderSide(color: AppColor.greyBlue)),
                            // boxShadow: [
                            //   BoxShadow(
                            //     spreadRadius: .1,
                            //     blurRadius: 5,
                            //     color: Color.fromARGB(255, 218, 214, 214),
                            //     offset: Offset(0, -3),
                            //   )
                            // ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  ProjectIdeaGalleryDialog.showEditGroupName(
                                      groupID: groupID,
                                      controller: controller,
                                      groupname: controller
                                          .selectedNameoftheGroupBottomSheet
                                          .value
                                          .capitalizeFirst
                                          .toString());
                                },
                                child: Container(
                                  width: 30.w,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Rename",
                                    style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontFamily: FontFamily.maloryLight,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showBottomSheetAddIdeaFromGroup(
                                      controller: controller, groupID: groupID);
                                  // Get.to(() => CameraIdeaScreenView(),
                                  //     arguments: {
                                  //       "isFromHomescreen": false,
                                  //       "projectID": controller.projectID.value,
                                  //       "projectName":
                                  //           controller.projectName.value,
                                  //       "groupID": groupID
                                  //     });
                                },
                                child: Container(
                                  width: 30.w,
                                  alignment: Alignment.centerRight,
                                  child: SvgPicture.asset(
                                    CustomIcons.addnew,
                                    color: AppColor.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(right: 5.w, left: 5.w),
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border(
                                top: BorderSide(color: AppColor.greyBlue)),
                            // boxShadow: [
                            //   BoxShadow(
                            //     spreadRadius: .1,
                            //     blurRadius: 5,
                            //     color: Color.fromARGB(255, 218, 214, 214),
                            //     offset: Offset(0, -3),
                            //   )
                            // ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(),
                              // InkWell(
                              //   onTap: () {
                              //     if (controller
                              //             .check_if_there_is_true_group_items()
                              //             .value ==
                              //         true) {
                              //       ProjectIdeaGalleryDialog
                              //           .showArchivedIdeaFromGroup(
                              //               controller: controller,
                              //               data: controller
                              //                   .displayGroupItemsList,
                              //               groupID: groupID);
                              //     }
                              //   },
                              //   child: Obx(
                              //     () => Text(
                              //       "Archive",
                              //       style: TextStyle(
                              //           fontFamily: FontFamily.maloryLight,
                              //           color: controller
                              //                       .check_if_there_is_true_group_items()
                              //                       .value ==
                              //                   true
                              //               ? AppColor.darkBlue
                              //               : AppColor.grey,
                              //           fontWeight: FontWeight.w500,
                              //           fontSize: 14.sp),
                              //     ),
                              //   ),
                              // ),

                              InkWell(
                                onTap: () {
                                  // if (controller
                                  //         .check_if_there_is_true_group_items()
                                  //         .value ==
                                  //     true) {
                                  //   ProjectIdeaGalleryDialog
                                  //       .showArchivedIdeaFromGroup(
                                  //           controller: controller,
                                  //           data: controller
                                  //               .displayGroupItemsList,
                                  //           groupID: groupID);
                                  // }
                                  controller.getProjectsAndIdeaGroups();
                                  List<FinalProjectGalleryModel> listtopass =
                                      [];
                                  for (var element
                                      in controller.displayGroupItemsList) {
                                    if (element.isSelected.value == true) {
                                      listtopass.add(FinalProjectGalleryModel(
                                          ideaNameOrIdeaGroupname:
                                              element.label,
                                          isGroup: false,
                                          groupIdOrIdeaId: element.ideaId,
                                          ideaFileImage: element.file,
                                          groupIdeaImage: [],
                                          numberorideas: controller
                                              .displayGroupItemsList.length
                                              .toString(),
                                          dateCreated: element.dateCreated,
                                          isSelected: true.obs));
                                    }
                                  }
                                  Get.to(() => ProjectIdeasMoveIdea(
                                        from: "Group",
                                        imageList: listtopass,
                                        moveOrCopy: "copy",
                                      ));
                                },
                                child: Obx(
                                  () => Text(
                                    "Copy",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryLight,
                                        color: controller
                                                    .check_if_there_is_true_group_items()
                                                    .value ==
                                                true
                                            ? AppColor.darkBlue
                                            : AppColor.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller
                                          .check_if_there_is_true_group_items()
                                          .value ==
                                      true) {
                                    List listOfIdeaID = [];
                                    for (var element
                                        in controller.displayGroupItemsList) {
                                      if (element.isSelected.value == true) {
                                        listOfIdeaID.add(element.ideaId);
                                      }
                                    }
                                    ProjectIdeaGalleryDialog.showDeleteDialog(
                                        controller: controller,
                                        listOfBoardId: [],
                                        listOfIdeaID: listOfIdeaID,
                                        groupID: groupID);
                                  }
                                },
                                child: Obx(
                                  () => Text(
                                    "Delete",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryLight,
                                        color: controller
                                                    .check_if_there_is_true_group_items()
                                                    .value ==
                                                true
                                            ? AppColor.darkBlue
                                            : AppColor.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.getProjectsAndIdeaGroups();
                                  // moveBottomSheet_for_group_ideas(
                                  //     controller: controller);
                                  List<FinalProjectGalleryModel> listtopass =
                                      [];
                                  for (var element
                                      in controller.displayGroupItemsList) {
                                    if (element.isSelected.value == true) {
                                      listtopass.add(FinalProjectGalleryModel(
                                          ideaNameOrIdeaGroupname:
                                              element.label,
                                          isGroup: false,
                                          groupIdOrIdeaId: element.ideaId,
                                          ideaFileImage: element.file,
                                          groupIdeaImage: [],
                                          numberorideas: controller
                                              .displayGroupItemsList.length
                                              .toString(),
                                          dateCreated: element.dateCreated,
                                          isSelected: true.obs));
                                    }
                                  }
                                  Get.to(() => ProjectIdeasMoveIdea(
                                        from: "Group",
                                        imageList: listtopass,
                                        moveOrCopy: "move",
                                      ));
                                },
                                child: Obx(
                                  () => Text(
                                    "Move",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryLight,
                                        color: controller
                                                    .check_if_there_is_true_group_items()
                                                    .value ==
                                                true
                                            ? AppColor.darkBlue
                                            : AppColor.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
        isScrollControlled: true);
  }

  static moveBottomSheet({required ProjectIdeasGalleryController controller}) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 20.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  List<FinalProjectGalleryModel> listtopass = [];
                  for (var element in controller.ungrouped_list) {
                    if (element.isSelected.value == true) {
                      listtopass.add(element);
                    }
                  }
                  Get.back();
                  Get.to(() => ProjectIdeasMoveIdea(
                        from: "Ungroup",
                        imageList: listtopass,
                        moveOrCopy: "copy",
                      ));
                  controller.scrollPosition_ungrouped.value = 0.0;
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Save a copy to..",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selected_previous_groupid_for_moving.value = "";
                  List<FinalProjectGalleryModel> listtopass = [];
                  for (var element in controller.ungrouped_list) {
                    if (element.isSelected.value == true) {
                      listtopass.add(element);
                    }
                  }
                  Get.back();
                  Get.to(() => ProjectIdeasMoveIdea(
                        from: "Ungroup",
                        imageList: listtopass,
                        moveOrCopy: "move",
                      ));
                  controller.scrollPosition_ungrouped.value = 0.0;
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Move to..",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showBottomSheetAddIdeaFromGroup(
      {required ProjectIdeasGalleryController controller,
      required String groupID}) {
    Get.bottomSheet(Container(
      height: 15.h,
      width: 100.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final List<XFile>? images = await picker.pickMultiImage();
              if (images == null) {
                Get.back();
              } else if (images.length == 0) {
                Get.back();
              } else {
                Get.back();
                Get.to(() => CameraIdeaScreenView(), arguments: {
                  "isSavetoMyIdeas": false,
                  "isFromHomescreen": false,
                  "projectID": controller.projectID.value,
                  "projectName": controller.projectName.value,
                  "groupID": groupID
                });
                Future.delayed(Duration(seconds: 1), () async {
                  for (var i = 0; i < images.length; i++) {
                    File file = await File(images[i].path);

                    int quality = 70;
                    int percentage = 70;
                    final bytes = file.readAsBytesSync().lengthInBytes;
                    final kb = bytes / 1024;

                    if (kb > 900) {
                      quality = 30;
                      percentage = 30;
                    } else if (kb < 900 && kb > 300) {
                      quality = 50;
                      percentage = 50;
                    }

                    print(quality.toString() + "  " + percentage.toString());

                    File compressedFile =
                        await FlutterNativeImage.compressImage(file.path,
                            quality: quality, percentage: percentage);

                    final kbnew =
                        compressedFile.readAsBytesSync().lengthInBytes / 1024;
                    print("image size is $kbnew KB");

                    PicturesIdeaModel map = PicturesIdeaModel(
                        path: compressedFile.path,
                        isFirst: false,
                        isLast: false,
                        isSelected: false.obs);

                    Get.find<SelectIdeaPhotoController>()
                        .storageImages
                        .add(map);
                  }
                });
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.addimages,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Choose from Library",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.darkBlue,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          InkWell(
            onTap: () {
              Get.back();
              Get.to(() => CameraIdeaScreenView(), arguments: {
                "isSavetoMyIdeas": false,
                "isFromHomescreen": false,
                "projectID": controller.projectID.value,
                "projectName": controller.projectName.value,
                "groupID": groupID
              });
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.camera,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Take a photo",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.darkBlue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  static moveBottomSheet_for_group_ideas({
    required ProjectIdeasGalleryController controller,
  }) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 20.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  List<FinalProjectGalleryModel> listtopass = [];
                  for (var element in controller.displayGroupItemsList) {
                    if (element.isSelected.value == true) {
                      listtopass.add(FinalProjectGalleryModel(
                          ideaNameOrIdeaGroupname: element.label,
                          isGroup: false,
                          groupIdOrIdeaId: element.ideaId,
                          ideaFileImage: element.file,
                          groupIdeaImage: [],
                          numberorideas: controller.displayGroupItemsList.length
                              .toString(),
                          dateCreated: element.dateCreated,
                          isSelected: true.obs));
                    }
                  }
                  Get.to(() => ProjectIdeasMoveIdea(
                        from: "Group",
                        imageList: listtopass,
                        moveOrCopy: "copy",
                      ));
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Save a copy to..",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  List<FinalProjectGalleryModel> listtopass = [];
                  for (var element in controller.displayGroupItemsList) {
                    if (element.isSelected.value == true) {
                      listtopass.add(FinalProjectGalleryModel(
                          ideaNameOrIdeaGroupname: element.label,
                          isGroup: false,
                          groupIdOrIdeaId: element.ideaId,
                          ideaFileImage: element.file,
                          groupIdeaImage: [],
                          numberorideas: controller.displayGroupItemsList.length
                              .toString(),
                          dateCreated: element.dateCreated,
                          isSelected: true.obs));
                    }
                  }
                  Get.to(() => ProjectIdeasMoveIdea(
                        from: "Group",
                        imageList: listtopass,
                        moveOrCopy: "move",
                      ));
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Move to..",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
