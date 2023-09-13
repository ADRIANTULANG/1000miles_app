import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/my_ideas_controller.dart';
import '../items/group_idea_more_than_three_item.dart';
import '../items/group_idea_one_item.dart';
import '../items/group_idea_three_item.dart';
import '../items/group_idea_two_item.dart';
import '../items/group_idea_zero_item.dart';
import '../items/ungroup_item.dart';

class MyIdeasDisplayArchived extends GetView<MyIdeasController> {
  const MyIdeasDisplayArchived({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          for (var element in controller.archived_ideas) {
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
                      Text(
                        "Archived",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            fontFamily: FontFamily.maloryBold),
                      ),
                      InkWell(
                        onTap: () {
                          for (var element in controller.archived_ideas) {
                            element.isSelected.value = false;
                          }
                          if (controller.isEditing.value == true) {
                            controller.isEditing.value = false;
                          } else {
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
                      itemCount: controller.archived_ideas.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (controller.archived_ideas[index].isGroup == true) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (controller.archived_ideas[index]
                                          .isSelected.value ==
                                      true) {
                                    controller.archived_ideas[index].isSelected
                                        .value = false;
                                  } else {
                                    controller.archived_ideas[index].isSelected
                                        .value = true;
                                  }
                                },
                                onLongPress: () {
                                  controller.archived_ideas[index].isSelected
                                      .value = true;
                                  controller.isEditing.value = true;
                                },
                                child: Container(
                                  child: controller.archived_ideas[index]
                                          .groupIdeaImage.isEmpty
                                      ? MyIdeasZeroItem(
                                          groupname: controller
                                              .archived_ideas[index]
                                              .ideaNameOrIdeaGroupname,
                                        )
                                      : controller.archived_ideas[index]
                                                  .groupIdeaImage.length ==
                                              1
                                          ? MyIdeasOneItem(
                                              groupname: controller
                                                  .archived_ideas[index]
                                                  .ideaNameOrIdeaGroupname,
                                              one_item_image: controller
                                                  .archived_ideas[index]
                                                  .groupIdeaImage[0]
                                                  .fileImage,
                                            )
                                          : controller.archived_ideas[index]
                                                      .groupIdeaImage.length ==
                                                  2
                                              ? MyIdeasTwoItem(
                                                  groupName: controller
                                                      .archived_ideas[index]
                                                      .ideaNameOrIdeaGroupname,
                                                  imageOne: controller
                                                      .archived_ideas[index]
                                                      .groupIdeaImage[0]
                                                      .fileImage,
                                                  imageTwo: controller
                                                      .archived_ideas[index]
                                                      .groupIdeaImage[1]
                                                      .fileImage,
                                                )
                                              : controller
                                                          .archived_ideas[index]
                                                          .groupIdeaImage
                                                          .length ==
                                                      3
                                                  ? MyIdeasThreeItem(
                                                      groupName: controller
                                                          .archived_ideas[index]
                                                          .ideaNameOrIdeaGroupname,
                                                      imageOne: controller
                                                          .archived_ideas[index]
                                                          .groupIdeaImage[0]
                                                          .fileImage,
                                                      imageTwo: controller
                                                          .archived_ideas[index]
                                                          .groupIdeaImage[1]
                                                          .fileImage,
                                                      imageThree: controller
                                                          .archived_ideas[index]
                                                          .groupIdeaImage[2]
                                                          .fileImage,
                                                    )
                                                  : MyIdeasMoreThanThreeItem(
                                                      groupName: controller
                                                          .archived_ideas[index]
                                                          .ideaNameOrIdeaGroupname,
                                                      imageOne: controller
                                                          .archived_ideas[index]
                                                          .groupIdeaImage[0]
                                                          .fileImage,
                                                      imageTwo: controller
                                                          .archived_ideas[index]
                                                          .groupIdeaImage[1]
                                                          .fileImage,
                                                      remainingCount: (controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .groupIdeaImage
                                                                  .length -
                                                              2)
                                                          .toString(),
                                                    ),
                                ),
                              ),
                              Positioned(
                                top: 1.h,
                                right: 1.5.w,
                                child: InkWell(
                                  onTap: () {
                                    if (controller.archived_ideas[index]
                                            .isSelected.value ==
                                        true) {
                                      controller.archived_ideas[index]
                                          .isSelected.value = false;
                                    } else {
                                      controller.archived_ideas[index]
                                          .isSelected.value = true;
                                    }
                                  },
                                  child: Obx(
                                    () => controller.isEditing.value == true
                                        ? controller.archived_ideas[index]
                                                    .isSelected.value ==
                                                false
                                            ? SvgPicture.asset(
                                                CustomIcons.checkboxUnchecked,
                                                color: AppColor.darkBlue,
                                              )
                                            : SvgPicture.asset(
                                                CustomIcons.checkboxchecked,
                                                color: AppColor.darkBlue,
                                              )
                                        : SizedBox(),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (controller.archived_ideas[index]
                                          .isSelected.value ==
                                      true) {
                                    controller.archived_ideas[index].isSelected
                                        .value = false;
                                  } else {
                                    controller.archived_ideas[index].isSelected
                                        .value = true;
                                  }
                                },
                                onLongPress: () {
                                  controller.archived_ideas[index].isSelected
                                      .value = true;
                                  controller.isEditing.value = true;
                                },
                                child: MyIdeasUngroupedItem(
                                  groupID: "",
                                  ideaID: controller
                                      .archived_ideas[index].groupIdOrIdeaId,
                                  index: index,
                                  image: controller
                                      .archived_ideas[index].ideaFileImage,
                                  name: controller.archived_ideas[index]
                                      .ideaNameOrIdeaGroupname,
                                ),
                              ),
                              Positioned(
                                top: 1.h,
                                right: 1.5.w,
                                child: InkWell(
                                  onTap: () {
                                    if (controller.archived_ideas[index]
                                            .isSelected.value ==
                                        true) {
                                      controller.archived_ideas[index]
                                          .isSelected.value = false;
                                    } else {
                                      controller.archived_ideas[index]
                                          .isSelected.value = true;
                                    }
                                  },
                                  child: Obx(
                                    () => controller.isEditing.value == true
                                        ? controller.archived_ideas[index]
                                                    .isSelected.value ==
                                                false
                                            ? SvgPicture.asset(
                                                CustomIcons.checkboxUnchecked,
                                                color: AppColor.darkBlue,
                                              )
                                            : SvgPicture.asset(
                                                CustomIcons.checkboxchecked,
                                                color: AppColor.darkBlue,
                                              )
                                        : SizedBox(),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ))
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            height: 6.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: AppColor.white,
                border:
                    Border(top: BorderSide(color: AppColor.grey, width: 0.5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => controller
                              .check_if_there_is_true_in_archived_list()
                              .value ==
                          true
                      ? InkWell(
                          onTap: () {
                            List ideasimagestoRecover = [];
                            List groupsToRecover = [];
                            for (var i = 0;
                                i < controller.archived_ideas.length;
                                i++) {
                              if (controller
                                      .archived_ideas[i].isSelected.value ==
                                  true) {
                                if (controller.archived_ideas[i].isGroup ==
                                    false) {
                                  ideasimagestoRecover.add(controller
                                      .archived_ideas[i].groupIdOrIdeaId);
                                } else {
                                  groupsToRecover.add(controller
                                      .archived_ideas[i].groupIdOrIdeaId);
                                }
                              }
                            }
                            controller.recoverMyideas(
                                groupsToRecover: groupsToRecover,
                                imageIdList: ideasimagestoRecover);
                          },
                          child: Container(
                            width: 20.w,
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              CustomIcons.refresh,
                              color: AppColor.darkBlue,
                            ),
                          ),
                        )
                      : Container(
                          width: 20.w,
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            CustomIcons.refresh,
                            color: AppColor.greyBlue,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
