import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../bottomsheet/my_ideas_bottomsheet.dart';
import '../controller/my_ideas_controller.dart';
import '../dialogs/my_ideas_alert_dialogs.dart';
import '../model/my_ideas_model.dart';
import '../model/my_ideas_move_copy_images_model.dart';
import 'my_ideas_share_ideas.dart';

class MyIdeasDisplayInsIdeasOfGroup extends GetView<MyIdeasController> {
  const MyIdeasDisplayInsIdeasOfGroup(
      {required this.groupName,
      required this.from,
      required this.groupID,
      super.key});
  final String groupName;
  final String groupID;
  final String from;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          for (var element in controller.ideas_List) {
            element.isSelected.value = false;
          }
          if (controller.isEditing.value == true) {
            controller.isEditing.value = false;
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Container(
            color: AppColor.white,
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  height: 7.5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: AppColor.grey, width: 0.5))),
                  alignment: Alignment.center,
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
                            CustomIcons.arrowbackios,
                            color: AppColor.darkBlue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Obx(
                            () => Text(
                              controller.selected_board_name_to_rename.value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  fontFamily: FontFamily.maloryBold),
                            ),
                          ),
                        ),
                      ),
                      from == "Shared"
                          ? SizedBox(
                              width: 20.w,
                            )
                          : InkWell(
                              onTap: () {
                                if (controller.isEditing.value == true) {
                                  controller.isEditing.value = false;
                                } else {
                                  for (var element in controller.ideas_List) {
                                    element.isSelected.value = false;
                                  }
                                  controller.isEditing.value = true;
                                }
                              },
                              child: Container(
                                width: 20.w,
                                alignment: Alignment.centerRight,
                                child: Obx(
                                  () => Text(
                                    controller.isEditing.value == true
                                        ? "Cancel"
                                        : "Select",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        fontFamily: FontFamily.maloryLight),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                  ),
                  child: Obx(
                    () => GridView.builder(
                      padding: EdgeInsets.only(top: 2.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .8,
                          crossAxisCount: 2,
                          mainAxisSpacing: 3.h,
                          crossAxisSpacing: 2.w),
                      itemCount: controller.ideas_List.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (controller.isEditing.value == true) {
                              if (controller
                                      .ideas_List[index].isSelected.value ==
                                  false) {
                                controller.ideas_List[index].isSelected.value =
                                    true;
                              } else {
                                controller.ideas_List[index].isSelected.value =
                                    false;
                              }
                            }
                          },
                          onLongPress: () {
                            controller.isEditing.value = true;
                            controller.ideas_List[index].isSelected.value =
                                true;
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: AppEndpoint.endPointFile +
                                          "" +
                                          controller
                                              .ideas_List[index].ideaFilename
                                              .toString(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: controller.ideas_List[index]
                                                    .ideaName ==
                                                ""
                                            ? 26.h
                                            : 23.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5.sp,
                                              color: AppColor.greyBlue),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: .5,
                                              blurRadius: 3,
                                              color: AppColor.boxShadow,
                                              offset: Offset(0, 3),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        height: controller.ideas_List[index]
                                                    .ideaName ==
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
                                        height: controller.ideas_List[index]
                                                    .ideaName ==
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
                                    Obx(
                                      () => controller.isEditing.value == true
                                          ? Positioned(
                                              right: 2.w,
                                              top: 1.h,
                                              child: InkWell(
                                                onTap: () {
                                                  if (controller
                                                          .ideas_List[index]
                                                          .isSelected
                                                          .value ==
                                                      false) {
                                                    controller
                                                        .ideas_List[index]
                                                        .isSelected
                                                        .value = true;
                                                  } else {
                                                    controller
                                                        .ideas_List[index]
                                                        .isSelected
                                                        .value = false;
                                                  }
                                                },
                                                child: Obx(
                                                  () => controller
                                                              .ideas_List[index]
                                                              .isSelected
                                                              .value ==
                                                          false
                                                      ? SvgPicture.asset(
                                                          CustomIcons
                                                              .checkboxUnchecked,
                                                          color: AppColor.black,
                                                        )
                                                      : SvgPicture.asset(
                                                          CustomIcons
                                                              .checkboxcheckedwhite,
                                                        ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    )
                                  ],
                                ),
                                controller.ideas_List[index].ideaName == ""
                                    ? SizedBox()
                                    : Container(
                                        height: 3.h,
                                        width: 100.w,
                                        padding: EdgeInsets.only(left: 2.5.w),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          controller.ideas_List[index].ideaName
                                              .capitalizeFirst
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: FontFamily.maloryBold,
                                              fontSize: 12.sp),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ))
              ],
            ),
          ),
          bottomNavigationBar: from == "Shared"
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  height: 6.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border(
                          top: BorderSide(color: AppColor.grey, width: 0.5))),
                  child: Obx(
                    () => controller.isEditing.value == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (controller
                                          .check_if_there_is_true_in_Ungrouped_list()
                                          .value ==
                                      true) {
                                    List ideasImagesToDelete = [];
                                    for (var i = 0;
                                        i < controller.ideas_List.length;
                                        i++) {
                                      if (controller
                                              .ideas_List[i].isSelected.value ==
                                          true) {
                                        ideasImagesToDelete.add(
                                            controller.ideas_List[i].ideaId);
                                      }
                                    }
                                    MyIdeasAlertDialog.showDeleteDialog(
                                        controller: controller,
                                        listOfBoardId: [],
                                        listOfIdeaID: ideasImagesToDelete,
                                        groupID: groupID);
                                  }
                                },
                                child: Container(
                                  width: 20.w,
                                  alignment: Alignment.centerLeft,
                                  child: Obx(
                                    () => Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: controller
                                                      .check_if_there_is_true_in_Ungrouped_list()
                                                      .value ==
                                                  false
                                              ? AppColor.grey
                                              : AppColor.darkBlue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          fontFamily: FontFamily.maloryLight),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller
                                          .check_if_there_is_true_in_Ungrouped_list()
                                          .value ==
                                      true) {
                                    List<MyIdeasModel> images = [];

                                    for (var element
                                        in controller.myIdeas_grouped_list) {
                                      if (element.groupIdOrIdeaId == groupID) {
                                        for (var ideas
                                            in element.groupIdeaImage) {
                                          images.add(MyIdeasModel(
                                              ideaNameOrIdeaGroupname: "",
                                              isGroup: false,
                                              groupIdOrIdeaId:
                                                  ideas.ideaImageId,
                                              ideaFileImage: ideas.fileImage,
                                              groupIdeaImage: [],
                                              numberorideas: "0",
                                              dateCreated: DateTime.now(),
                                              isSelected: true.obs));
                                        }
                                      }
                                    }
                                    for (var element in controller.ideas_List) {
                                      if (element.isSelected.value == false) {
                                        images.removeWhere((idea) =>
                                            idea.groupIdOrIdeaId ==
                                            element.ideaId);
                                      }
                                    }
                                    controller.emailAddress.clear();
                                    Get.to(() => MyIdeasShareIdeas(
                                          ideasGroupOrUngroup: images,
                                          groupID: groupID,
                                        ));
                                  }
                                },
                                child: Container(
                                  width: 20.w,
                                  alignment: Alignment.center,
                                  child: Obx(
                                    () => Text(
                                      "Share",
                                      style: TextStyle(
                                          color: controller
                                                      .check_if_there_is_true_in_Ungrouped_list()
                                                      .value ==
                                                  false
                                              ? AppColor.grey
                                              : AppColor.darkBlue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          fontFamily: FontFamily.maloryLight),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller
                                          .check_if_there_is_true_in_Ungrouped_list()
                                          .value ==
                                      true) {
                                    List<ImagesModel> images = [];
                                    for (var i = 0;
                                        i < controller.ideas_List.length;
                                        i++) {
                                      if (controller
                                              .ideas_List[i].isSelected.value ==
                                          true) {
                                        images.add(ImagesModel(
                                            ideaId:
                                                controller.ideas_List[i].ideaId,
                                            ideaFileImage: controller
                                                .ideas_List[i].ideaFilename));
                                      }
                                    }
                                    MyIdeasBottomSheet.moveBottomSheet(
                                        previousBoardID: groupID,
                                        controller: controller,
                                        imageList: images);
                                  }
                                },
                                child: Container(
                                  width: 20.w,
                                  alignment: Alignment.centerRight,
                                  child: Obx(
                                    () => Text(
                                      "Move",
                                      style: TextStyle(
                                          color: controller
                                                      .check_if_there_is_true_in_Ungrouped_list()
                                                      .value ==
                                                  false
                                              ? AppColor.grey
                                              : AppColor.darkBlue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          fontFamily: FontFamily.maloryLight),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  MyIdeasAlertDialog.showEditGroupName(
                                      groupname: controller
                                          .selected_board_name_to_rename.value,
                                      groupID: groupID,
                                      controller: controller);
                                },
                                child: Container(
                                  width: 20.w,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Rename",
                                    style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        fontFamily: FontFamily.maloryLight),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  MyIdeasBottomSheet
                                      .showBottomSheetButtonAndroid(
                                          groupID: groupID,
                                          controller: controller);
                                },
                                child: Container(
                                  width: 20.w,
                                  alignment: Alignment.centerRight,
                                  child: SvgPicture.asset(
                                    CustomIcons.addnew,
                                    color: AppColor.darkBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
        ),
      ),
    );
  }
}
