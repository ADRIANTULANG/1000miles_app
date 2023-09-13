import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/icons_class.dart';
import '../controller/my_ideas_controller.dart';
import '../items/group_idea_more_than_three_item.dart';
import '../items/group_idea_one_item.dart';
import '../items/group_idea_three_item.dart';
import '../items/group_idea_two_item.dart';
import '../items/group_idea_zero_item.dart';
import '../items/ungroup_item.dart';
import '../view/my_ideas_display_all_ungrouped.dart';
import '../view/my_ideas_display_all_grouped.dart';
import '../view/my_ideas_display_inside_ideas_of_grouped.dart';

class MyIdeasRecentlyViewed extends GetView<MyIdeasController> {
  const MyIdeasRecentlyViewed({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.myIdeas_ungrouped_list.length == 0 &&
              controller.myIdeas_grouped_list.length == 0
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  SvgPicture.asset(
                    CustomIcons.projectbigsize,
                    height: 7.5.h,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Discover project tools",
                    style: TextStyle(
                        fontFamily: FontFamily.maloryLight,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyBlue,
                        fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Text(
                    "by pressing + bellow",
                    style: TextStyle(
                        fontFamily: FontFamily.maloryLight,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyBlue,
                        fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
            )
          : Container(
              child: SingleChildScrollView(
                controller: controller.scrollController_recently_viewed,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(
                      () => controller.myIdeas_grouped_list.length == 0
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(
                                left: 7.w,
                                right: 5.w,
                              ),
                              width: 100.w,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Boards",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryBold,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.darkBlue),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.isEditing.value = false;
                                      Get.to(() => MyIdeasDisplayGroup());
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.maloryLight,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.darkBlue),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SvgPicture.asset(
                                          CustomIcons.arrowforwardios,
                                          color: AppColor.darkBlue,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
                    Obx(
                      () => controller.myIdeas_grouped_list.length == 0
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(
                                  left: 5.w, right: 5.w, top: 1.h),
                              child: Obx(
                                () => GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: .8,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 3.h,
                                          crossAxisSpacing: 2.w),
                                  itemCount:
                                      controller.myIdeas_grouped_list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () async {
                                        // for navigation purposes
                                        controller.isEditing.value = false;
                                        controller
                                            .getAllgroupedMyIdeasToDisplay(
                                          groupId: controller
                                              .myIdeas_grouped_list[index]
                                              .groupIdOrIdeaId,
                                        );
                                        controller.selected_board_name_to_rename
                                                .value =
                                            controller
                                                .myIdeas_grouped_list[index]
                                                .ideaNameOrIdeaGroupname;
                                        Get.to(() =>
                                            MyIdeasDisplayInsIdeasOfGroup(
                                              from: "My ideas",
                                              groupID: controller
                                                  .myIdeas_grouped_list[index]
                                                  .groupIdOrIdeaId,
                                              groupName: controller
                                                  .myIdeas_grouped_list[index]
                                                  .ideaNameOrIdeaGroupname,
                                            ));
                                      },
                                      onLongPress: () {
                                        controller.isEditing.value = true;
                                        Get.to(() => MyIdeasDisplayGroup());
                                        int indextoscroll = 0;
                                        for (var i = 0;
                                            i <
                                                controller.myIdeas_grouped_list
                                                    .length;
                                            i++) {
                                          if (controller.myIdeas_grouped_list[i]
                                                  .groupIdOrIdeaId ==
                                              controller
                                                  .myIdeas_grouped_list[index]
                                                  .groupIdOrIdeaId) {
                                            controller.myIdeas_grouped_list[i]
                                                .isSelected.value = true;
                                            indextoscroll = i;
                                          }
                                        }
                                        controller.autoscroll_controller_boards
                                            .scrollToIndex(indextoscroll,
                                                preferPosition:
                                                    AutoScrollPosition.middle);
                                      },
                                      child: Container(
                                        child: controller
                                                .myIdeas_grouped_list[index]
                                                .groupIdeaImage
                                                .isEmpty
                                            ? MyIdeasZeroItem(
                                                groupname: controller
                                                    .myIdeas_grouped_list[index]
                                                    .ideaNameOrIdeaGroupname,
                                              )
                                            : controller
                                                        .myIdeas_grouped_list[
                                                            index]
                                                        .groupIdeaImage
                                                        .length ==
                                                    1
                                                ? MyIdeasOneItem(
                                                    groupname: controller
                                                        .myIdeas_grouped_list[
                                                            index]
                                                        .ideaNameOrIdeaGroupname,
                                                    one_item_image: controller
                                                        .myIdeas_grouped_list[
                                                            index]
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
                                                                .groupIdeaImage[
                                                                    0]
                                                                .fileImage,
                                                            imageTwo: controller
                                                                .myIdeas_grouped_list[
                                                                    index]
                                                                .groupIdeaImage[
                                                                    1]
                                                                .fileImage,
                                                            imageThree: controller
                                                                .myIdeas_grouped_list[
                                                                    index]
                                                                .groupIdeaImage[
                                                                    2]
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
                                                                .groupIdeaImage[
                                                                    0]
                                                                .fileImage,
                                                            imageTwo: controller
                                                                .myIdeas_grouped_list[
                                                                    index]
                                                                .groupIdeaImage[
                                                                    1]
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
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(
                      () => controller.myIdeas_grouped_list.length == 0
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Divider(
                                color: AppColor.grey,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(
                      () => controller.myIdeas_ungrouped_list.length == 0
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(
                                left: 7.w,
                                right: 5.w,
                              ),
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ideas",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryBold,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.darkBlue),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.isEditing.value = false;
                                      controller
                                          .getAllUngroupedMyIdeasToDisplay();
                                      Get.to(() => MyIdeasDisplayUnGroup(
                                            from: "My ideas",
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.maloryLight,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.darkBlue),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SvgPicture.asset(
                                          CustomIcons.arrowforwardios,
                                          color: AppColor.darkBlue,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
                    Obx(
                      () => controller.myIdeas_ungrouped_list.length == 0
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(
                                  left: 5.w, right: 5.w, top: 1.h, bottom: 2.h),
                              child: Obx(
                                () => GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: .8,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 4.h,
                                          crossAxisSpacing: 2.w),
                                  itemCount:
                                      controller.myIdeas_ungrouped_list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onLongPress: () {
                                        controller.isEditing.value = true;
                                        controller
                                            .getAllUngroupedMyIdeasToDisplay();
                                        Get.to(() => MyIdeasDisplayUnGroup(
                                              from: "My ideas",
                                            ));
                                        int indextoscroll = 0;
                                        for (var i = 0;
                                            i < controller.ideas_List.length;
                                            i++) {
                                          if (controller
                                                  .myIdeas_ungrouped_list[index]
                                                  .groupIdOrIdeaId ==
                                              controller.ideas_List[i].ideaId) {
                                            controller.ideas_List[i].isSelected
                                                .value = true;
                                            indextoscroll = i;
                                          }
                                          controller.autoscroll_controller_ideas
                                              .scrollToIndex(indextoscroll,
                                                  preferPosition:
                                                      AutoScrollPosition
                                                          .middle);
                                        }
                                      },
                                      child: MyIdeasUngroupedItem(
                                        groupID: "",
                                        ideaID: controller
                                            .myIdeas_ungrouped_list[index]
                                            .groupIdOrIdeaId,
                                        index: index,
                                        image: controller
                                            .myIdeas_ungrouped_list[index]
                                            .ideaFileImage,
                                        name: controller
                                            .myIdeas_ungrouped_list[index]
                                            .ideaNameOrIdeaGroupname,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
