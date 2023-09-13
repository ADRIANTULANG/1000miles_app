import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/modules/project_ideas_gallery/items/archived_ungrouped_idea.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/project_ideas_gallery_controller.dart';
import '../items/group_idea_more_than_three_item.dart';
import '../items/group_idea_one_item.dart';
import '../items/group_idea_three_item.dart';
import '../items/group_idea_two_item.dart';
import '../items/group_idea_zero_item.dart';

class ArchivedIdeas extends GetView<ProjectIdeasGalleryController> {
  const ArchivedIdeas({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.archived_ideas_list.length == 0
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
                    "No archived ideas.",
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
                  controller: controller.scrollController_archived,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 3.h,
                      crossAxisSpacing: 2.w),
                  itemCount: controller.archived_ideas_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (controller.archived_ideas_list[index].isGroup == true) {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.archived_ideas_list[index]
                                      .isSelected.value ==
                                  true) {
                                controller.archived_ideas_list[index].isSelected
                                    .value = false;
                              } else {
                                controller.archived_ideas_list[index].isSelected
                                    .value = true;
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
                              for (var element
                                  in controller.archived_ideas_list) {
                                element.isSelected.value = false;
                              }
                              controller.archived_ideas_list[index].isSelected
                                  .value = true;
                            },
                            child: Container(
                              child: controller.archived_ideas_list[index]
                                      .groupIdeaImage.isEmpty
                                  ? ZeroItem(
                                      groupname: controller
                                          .archived_ideas_list[index]
                                          .ideaNameOrIdeaGroupname,
                                    )
                                  : controller.archived_ideas_list[index]
                                              .groupIdeaImage.length ==
                                          1
                                      ? OneItem(
                                          groupname: controller
                                              .archived_ideas_list[index]
                                              .ideaNameOrIdeaGroupname,
                                          one_item_image: controller
                                              .archived_ideas_list[index]
                                              .groupIdeaImage[0]
                                              .fileImage,
                                        )
                                      : controller.archived_ideas_list[index]
                                                  .groupIdeaImage.length ==
                                              2
                                          ? TwoItem(
                                              groupName: controller
                                                  .archived_ideas_list[index]
                                                  .ideaNameOrIdeaGroupname,
                                              imageOne: controller
                                                  .archived_ideas_list[index]
                                                  .groupIdeaImage[0]
                                                  .fileImage,
                                              imageTwo: controller
                                                  .archived_ideas_list[index]
                                                  .groupIdeaImage[1]
                                                  .fileImage,
                                            )
                                          : controller
                                                      .archived_ideas_list[
                                                          index]
                                                      .groupIdeaImage
                                                      .length ==
                                                  3
                                              ? ThreeItem(
                                                  groupName: controller
                                                      .archived_ideas_list[
                                                          index]
                                                      .ideaNameOrIdeaGroupname,
                                                  imageOne: controller
                                                      .archived_ideas_list[
                                                          index]
                                                      .groupIdeaImage[0]
                                                      .fileImage,
                                                  imageTwo: controller
                                                      .archived_ideas_list[
                                                          index]
                                                      .groupIdeaImage[1]
                                                      .fileImage,
                                                  imageThree: controller
                                                      .archived_ideas_list[
                                                          index]
                                                      .groupIdeaImage[2]
                                                      .fileImage,
                                                )
                                              : MoreThanThreeItem(
                                                  groupName: controller
                                                      .archived_ideas_list[
                                                          index]
                                                      .ideaNameOrIdeaGroupname,
                                                  imageOne: controller
                                                      .archived_ideas_list[
                                                          index]
                                                      .groupIdeaImage[0]
                                                      .fileImage,
                                                  imageTwo: controller
                                                      .archived_ideas_list[
                                                          index]
                                                      .groupIdeaImage[1]
                                                      .fileImage,
                                                  remainingCount: (controller
                                                              .archived_ideas_list[
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
                            child: Obx(
                              () => controller.isEditing_for_homescreen.value ==
                                      true
                                  ? controller.archived_ideas_list[index]
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
                          )
                        ],
                      );
                    } else {
                      return ArchivedUngroupedIdea(
                        ideaID: controller
                            .archived_ideas_list[index].groupIdOrIdeaId,
                        groupID: "",
                        index: index,
                        image:
                            controller.archived_ideas_list[index].ideaFileImage,
                        name: controller
                            .archived_ideas_list[index].ideaNameOrIdeaGroupname,
                      );
                    }
                  },
                ),
              ),
            ),
    );
  }
}
