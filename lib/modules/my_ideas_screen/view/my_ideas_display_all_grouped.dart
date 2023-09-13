import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/my_ideas_controller.dart';
import '../dialogs/my_ideas_alert_dialogs.dart';
import '../items/group_idea_more_than_three_item.dart';
import '../items/group_idea_one_item.dart';
import '../items/group_idea_three_item.dart';
import '../items/group_idea_two_item.dart';
import '../items/group_idea_zero_item.dart';
import '../model/my_ideas_model.dart';
import 'my_ideas_display_inside_ideas_of_grouped.dart';
import 'my_ideas_share_ideas.dart';

class MyIdeasDisplayGroup extends GetView<MyIdeasController> {
  const MyIdeasDisplayGroup({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          for (var element in controller.myIdeas_grouped_list) {
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
                        "Boards",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            fontFamily: FontFamily.maloryBold),
                      ),
                      InkWell(
                        onTap: () {
                          for (var element in controller.ideas_List) {
                            element.isSelected.value = false;
                          }
                          if (controller.isEditing.value == true) {
                            controller.isEditing.value = false;
                          } else {
                            controller.isEditing.value = true;
                          }
                          for (var element in controller.myIdeas_grouped_list) {
                            element.isSelected.value = false;
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
                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                    child: Obx(
                      () => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .8,
                            crossAxisCount: 2,
                            mainAxisSpacing: 3.h,
                            crossAxisSpacing: 2.w),
                        controller: controller.autoscroll_controller_boards,
                        itemCount: controller.myIdeas_grouped_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AutoScrollTag(
                            key: ValueKey(index),
                            index: index,
                            controller: controller.autoscroll_controller_boards,
                            child: InkWell(
                              onTap: () async {
                                // for navigation purposes
                                if (controller.isEditing.value == false) {
                                  controller.isEditing.value = false;
                                  controller.getAllgroupedMyIdeasToDisplay(
                                    groupId: controller
                                        .myIdeas_grouped_list[index]
                                        .groupIdOrIdeaId,
                                  );
                                  controller
                                          .selected_board_name_to_rename.value =
                                      controller.myIdeas_grouped_list[index]
                                          .ideaNameOrIdeaGroupname;
                                  Get.to(() => MyIdeasDisplayInsIdeasOfGroup(
                                        from: "My ideas",
                                        groupID: controller
                                            .myIdeas_grouped_list[index]
                                            .groupIdOrIdeaId,
                                        groupName: controller
                                            .myIdeas_grouped_list[index]
                                            .ideaNameOrIdeaGroupname,
                                      ));
                                } else {
                                  if (controller.myIdeas_grouped_list[index]
                                          .isSelected.value ==
                                      true) {
                                    controller.myIdeas_grouped_list[index]
                                        .isSelected.value = false;
                                  } else {
                                    controller.myIdeas_grouped_list[index]
                                        .isSelected.value = true;
                                  }
                                }
                              },
                              onLongPress: () {
                                controller.isEditing.value = true;
                                controller.myIdeas_grouped_list[index]
                                    .isSelected.value = true;
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    child: controller
                                            .myIdeas_grouped_list[index]
                                            .groupIdeaImage
                                            .isEmpty
                                        ? MyIdeasZeroItem(
                                            groupname: controller
                                                .myIdeas_grouped_list[index]
                                                .ideaNameOrIdeaGroupname,
                                          )
                                        : controller.myIdeas_grouped_list[index]
                                                    .groupIdeaImage.length ==
                                                1
                                            ? MyIdeasOneItem(
                                                groupname: controller
                                                    .myIdeas_grouped_list[index]
                                                    .ideaNameOrIdeaGroupname,
                                                one_item_image: controller
                                                    .myIdeas_grouped_list[index]
                                                    .groupIdeaImage[0]
                                                    .fileImage,
                                              )
                                            : controller
                                                        .myIdeas_grouped_list[
                                                            index]
                                                        .groupIdeaImage
                                                        .length ==
                                                    2
                                                ? MyIdeasTwoItem(
                                                    groupName: controller
                                                        .myIdeas_grouped_list[
                                                            index]
                                                        .ideaNameOrIdeaGroupname,
                                                    imageOne: controller
                                                        .myIdeas_grouped_list[
                                                            index]
                                                        .groupIdeaImage[0]
                                                        .fileImage,
                                                    imageTwo: controller
                                                        .myIdeas_grouped_list[
                                                            index]
                                                        .groupIdeaImage[1]
                                                        .fileImage,
                                                  )
                                                : controller
                                                            .myIdeas_grouped_list[
                                                                index]
                                                            .groupIdeaImage
                                                            .length ==
                                                        3
                                                    ? MyIdeasThreeItem(
                                                        groupName: controller
                                                            .myIdeas_grouped_list[
                                                                index]
                                                            .ideaNameOrIdeaGroupname,
                                                        imageOne: controller
                                                            .myIdeas_grouped_list[
                                                                index]
                                                            .groupIdeaImage[0]
                                                            .fileImage,
                                                        imageTwo: controller
                                                            .myIdeas_grouped_list[
                                                                index]
                                                            .groupIdeaImage[1]
                                                            .fileImage,
                                                        imageThree: controller
                                                            .myIdeas_grouped_list[
                                                                index]
                                                            .groupIdeaImage[2]
                                                            .fileImage,
                                                      )
                                                    : MyIdeasMoreThanThreeItem(
                                                        groupName: controller
                                                            .myIdeas_grouped_list[
                                                                index]
                                                            .ideaNameOrIdeaGroupname,
                                                        imageOne: controller
                                                            .myIdeas_grouped_list[
                                                                index]
                                                            .groupIdeaImage[0]
                                                            .fileImage,
                                                        imageTwo: controller
                                                            .myIdeas_grouped_list[
                                                                index]
                                                            .groupIdeaImage[1]
                                                            .fileImage,
                                                        remainingCount: (controller
                                                                    .myIdeas_grouped_list[
                                                                        index]
                                                                    .groupIdeaImage
                                                                    .length -
                                                                2)
                                                            .toString(),
                                                      ),
                                  ),
                                  Positioned(
                                    top: 1.h,
                                    right: 1.5.w,
                                    child: Obx(
                                      () => controller.isEditing.value == true
                                          ? controller
                                                      .myIdeas_grouped_list[
                                                          index]
                                                      .isSelected
                                                      .value ==
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
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
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
              children: [
                InkWell(
                  onTap: () {
                    if (controller
                            .check_if_there_is_true_in_grouped_list()
                            .value ==
                        true) {
                      List groupIDs = [];
                      for (var i = 0;
                          i < controller.myIdeas_grouped_list.length;
                          i++) {
                        if (controller
                                .myIdeas_grouped_list[i].isSelected.value ==
                            true) {
                          groupIDs.add(controller
                              .myIdeas_grouped_list[i].groupIdOrIdeaId);
                        }
                      }

                      MyIdeasAlertDialog.showDeleteDialog(
                          controller: controller,
                          listOfBoardId: groupIDs,
                          listOfIdeaID: [],
                          groupID: "");
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
                                        .check_if_there_is_true_in_grouped_list()
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
                            .check_if_there_is_true_in_grouped_list()
                            .value ==
                        true) {
                      List groupIDs = [];
                      for (var i = 0;
                          i < controller.myIdeas_grouped_list.length;
                          i++) {
                        if (controller
                                .myIdeas_grouped_list[i].isSelected.value ==
                            true) {
                          groupIDs.add(controller
                              .myIdeas_grouped_list[i].groupIdOrIdeaId);
                        }
                      }

                      MyIdeasAlertDialog.showArchivedIdeaAlertDialog(
                          groupID: "",
                          controller: controller,
                          grouptoarchive: groupIDs,
                          ideastoarchive: []);
                    }
                  },
                  child: Container(
                    width: 20.w,
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        "Archived",
                        style: TextStyle(
                            color: controller
                                        .check_if_there_is_true_in_grouped_list()
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
                            .check_if_there_is_true_in_grouped_list()
                            .value ==
                        true) {
                      List<MyIdeasModel> images = [];
                      for (var element in controller.myIdeas_grouped_list) {
                        if (element.isSelected.value == true) {
                          images.add(element);
                        }
                      }
                      controller.emailAddress.clear();
                      Get.to(() => MyIdeasShareIdeas(
                            ideasGroupOrUngroup: images,
                            groupID: "",
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
                                        .check_if_there_is_true_in_grouped_list()
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
            ),
          ),
        ),
      ),
    );
  }
}
