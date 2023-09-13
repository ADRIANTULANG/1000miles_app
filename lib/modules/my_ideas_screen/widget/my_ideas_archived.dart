import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/my_ideas_controller.dart';
import '../items/group_idea_more_than_three_item.dart';
import '../items/group_idea_one_item.dart';
import '../items/group_idea_three_item.dart';
import '../items/group_idea_two_item.dart';
import '../items/group_idea_zero_item.dart';
import '../items/ungroup_item.dart';
import '../view/my_ideas_display_all_archived.dart';

class MyIdeasArchived extends GetView<MyIdeasController> {
  const MyIdeasArchived({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.archived_ideas.length == 0
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
                controller: controller.scrollController_archived,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(
                      () => controller.archived_ideas.length == 0
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
                                    "Archived",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryBold,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.darkBlue),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.isEditing.value = false;

                                      Get.to(() => MyIdeasDisplayArchived());
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
                      () => controller.archived_ideas.length == 0
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
                                  itemCount: controller.archived_ideas.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (controller
                                            .archived_ideas[index].isGroup ==
                                        true) {
                                      return InkWell(
                                        onTap: () async {},
                                        child: Container(
                                          child: controller
                                                  .archived_ideas[index]
                                                  .groupIdeaImage
                                                  .isEmpty
                                              ? MyIdeasZeroItem(
                                                  groupname: controller
                                                      .archived_ideas[index]
                                                      .ideaNameOrIdeaGroupname,
                                                )
                                              : controller
                                                          .archived_ideas[index]
                                                          .groupIdeaImage
                                                          .length ==
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
                                                  : controller
                                                              .archived_ideas[
                                                                  index]
                                                              .groupIdeaImage
                                                              .length ==
                                                          2
                                                      ? MyIdeasTwoItem(
                                                          groupName: controller
                                                              .archived_ideas[
                                                                  index]
                                                              .ideaNameOrIdeaGroupname,
                                                          imageOne: controller
                                                              .archived_ideas[
                                                                  index]
                                                              .groupIdeaImage[0]
                                                              .fileImage,
                                                          imageTwo: controller
                                                              .archived_ideas[
                                                                  index]
                                                              .groupIdeaImage[1]
                                                              .fileImage,
                                                        )
                                                      : controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .groupIdeaImage
                                                                  .length ==
                                                              3
                                                          ? MyIdeasThreeItem(
                                                              groupName: controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .ideaNameOrIdeaGroupname,
                                                              imageOne: controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .groupIdeaImage[
                                                                      0]
                                                                  .fileImage,
                                                              imageTwo: controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .groupIdeaImage[
                                                                      1]
                                                                  .fileImage,
                                                              imageThree: controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .groupIdeaImage[
                                                                      2]
                                                                  .fileImage,
                                                            )
                                                          : MyIdeasMoreThanThreeItem(
                                                              groupName: controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .ideaNameOrIdeaGroupname,
                                                              imageOne: controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .groupIdeaImage[
                                                                      0]
                                                                  .fileImage,
                                                              imageTwo: controller
                                                                  .archived_ideas[
                                                                      index]
                                                                  .groupIdeaImage[
                                                                      1]
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
                                      );
                                    } else {
                                      return MyIdeasUngroupedItem(
                                        groupID: "",
                                        ideaID: controller.archived_ideas[index]
                                            .groupIdOrIdeaId,
                                        index: index,
                                        image: controller.archived_ideas[index]
                                            .ideaFileImage,
                                        name: controller.archived_ideas[index]
                                            .ideaNameOrIdeaGroupname,
                                      );
                                    }
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
