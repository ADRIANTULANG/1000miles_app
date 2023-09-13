import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/modules/project_ideas_gallery/items/group_idea_zero_item.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../bottomsheet/project_ideas_gallery_bottomsheet.dart';
import '../controller/project_ideas_gallery_controller.dart';
import '../items/group_idea_more_than_three_item.dart';
import '../items/group_idea_one_item.dart';
import '../items/group_idea_three_item.dart';
import '../items/group_idea_two_item.dart';

class GroupedIdeasView extends GetView<ProjectIdeasGalleryController> {
  const GroupedIdeasView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.grouped_list.length == 0
          ? Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    CustomIcons.projectbigsize,
                    color: AppColor.greyBlue,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Lets add content to your\nproject via tool below",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: FontFamily.maloryLight,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyBlue,
                        fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Obx(
                () => GridView.builder(
                  controller: controller.scrollController_idea_groups,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 3.h,
                      crossAxisSpacing: 2.w),
                  itemCount: controller.grouped_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        if (controller.isEditing_for_homescreen.value ==
                            false) {
                          controller.isEditing_for_bottomsheet.value = false;
                          controller.scrollPosition_groupitems.value = 0.0;
                          controller.selectAll.value = false;
                          await controller.selectItemsOfGroup(
                              groupID: controller
                                  .grouped_list[index].groupIdOrIdeaId);
                          ProjectIdeaGallerBottomsheet.showGroupIdeas(
                            groupID:
                                controller.grouped_list[index].groupIdOrIdeaId,
                            controller: controller,
                            projectName: controller.projectName.value.obs,
                            nameofthegroup: controller
                                .grouped_list[index].ideaNameOrIdeaGroupname,
                          );

                          // for navigation purposes
                          controller.selectedGroupIDBottomSheet.value =
                              controller.grouped_list[index].groupIdOrIdeaId;
                          controller.selectedNameoftheGroupBottomSheet.value =
                              controller
                                  .grouped_list[index].ideaNameOrIdeaGroupname;
                          controller.selectedProjectNameBottomSheet.value =
                              controller.projectName.value;
                          // for navigation purposes
                          controller
                                  .selected_previous_groupid_for_moving.value =
                              controller.grouped_list[index].groupIdOrIdeaId;
                        } else {
                          if (controller.grouped_list[index].isSelected.value ==
                              true) {
                            controller.grouped_list[index].isSelected.value =
                                false;
                          } else {
                            controller.grouped_list[index].isSelected.value =
                                true;
                          }
                        }
                      },
                      onLongPress: () {
                        controller.isEditing_for_homescreen.value = true;
                        for (var element in controller.ungrouped_list) {
                          element.isSelected.value = false;
                        }
                        for (var element in controller.grouped_list) {
                          element.isSelected.value = false;
                        }
                        for (var element in controller.archived_ideas_list) {
                          element.isSelected.value = false;
                        }
                        controller.grouped_list[index].isSelected.value = true;
                      },
                      child: Stack(
                        children: [
                          Container(
                            child: controller
                                    .grouped_list[index].groupIdeaImage.isEmpty
                                ? ZeroItem(
                                    groupname: controller.grouped_list[index]
                                        .ideaNameOrIdeaGroupname,
                                  )
                                : controller.grouped_list[index].groupIdeaImage
                                            .length ==
                                        1
                                    ? OneItem(
                                        groupname: controller
                                            .grouped_list[index]
                                            .ideaNameOrIdeaGroupname,
                                        one_item_image: controller
                                            .grouped_list[index]
                                            .groupIdeaImage[0]
                                            .fileImage,
                                      )
                                    : controller.grouped_list[index]
                                                .groupIdeaImage.length ==
                                            2
                                        ? TwoItem(
                                            groupName: controller
                                                .grouped_list[index]
                                                .ideaNameOrIdeaGroupname,
                                            imageOne: controller
                                                .grouped_list[index]
                                                .groupIdeaImage[0]
                                                .fileImage,
                                            imageTwo: controller
                                                .grouped_list[index]
                                                .groupIdeaImage[1]
                                                .fileImage,
                                          )
                                        : controller.grouped_list[index]
                                                    .groupIdeaImage.length ==
                                                3
                                            ? ThreeItem(
                                                groupName: controller
                                                    .grouped_list[index]
                                                    .ideaNameOrIdeaGroupname,
                                                imageOne: controller
                                                    .grouped_list[index]
                                                    .groupIdeaImage[0]
                                                    .fileImage,
                                                imageTwo: controller
                                                    .grouped_list[index]
                                                    .groupIdeaImage[1]
                                                    .fileImage,
                                                imageThree: controller
                                                    .grouped_list[index]
                                                    .groupIdeaImage[2]
                                                    .fileImage,
                                              )
                                            : MoreThanThreeItem(
                                                groupName: controller
                                                    .grouped_list[index]
                                                    .ideaNameOrIdeaGroupname,
                                                imageOne: controller
                                                    .grouped_list[index]
                                                    .groupIdeaImage[0]
                                                    .fileImage,
                                                imageTwo: controller
                                                    .grouped_list[index]
                                                    .groupIdeaImage[1]
                                                    .fileImage,
                                                remainingCount: (controller
                                                            .grouped_list[index]
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
                              () => controller.isEditing_for_homescreen.value ==
                                      true
                                  ? controller.grouped_list[index].isSelected
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
                    );
                  },
                ),
              ),
            ),
    );
  }
}
