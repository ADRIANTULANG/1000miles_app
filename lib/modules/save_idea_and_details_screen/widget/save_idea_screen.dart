import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/icons_class.dart';
import '../controller/save_idea_and_details_controller.dart';
import '../dialogs/save_idea_and_details_dialog.dart';

class SaveIdeaScreen extends GetView<SaveIdeaAndDetailsController> {
  const SaveIdeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Text(
              "Save idea",
              style: TextStyle(
                  fontFamily: FontFamily.maloryBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Container(
              height: 13.h,
              width: 100.w,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                itemCount: controller.imagesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Container(
                      height: 13.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColor.greyBlue),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                  File(controller.imagesList[index].path)))),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Save to new project",
                  style: TextStyle(
                      fontFamily: FontFamily.maloryBold,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                ),
                InkWell(
                  onTap: () {
                    controller.checkAndUncheckSaveToNewProject();
                  },
                  child: Obx(
                    () => controller.isSavetoNewProject.value == true
                        ? SvgPicture.asset(
                            CustomIcons.radiobuttonactive,
                          )
                        : SvgPicture.asset(
                            CustomIcons.radiobutton,
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Divider(),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (controller.isMyIdeasBoards.value == true) {
                          controller.isMyIdeasBoards.value = false;
                        } else {
                          controller.isMyIdeasBoards.value = true;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ideas",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                fontFamily: FontFamily.maloryBold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 1.w),
                            child: Obx(
                              () => controller.isMyIdeasBoards.value == true
                                  ? SvgPicture.asset(CustomIcons.arrowdown,
                                      color: AppColor.darkBlue, height: 1.5.h)
                                  : SvgPicture.asset(
                                      CustomIcons.arrowforwardios,
                                      color: AppColor.darkBlue,
                                      height: 2.5.h,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => controller.isMyIdeasBoards.value == false
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.myideas_board_list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 3.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (controller
                                                      .myideas_board_list[index]
                                                      .boardId ==
                                                  "Create board") {
                                                SaveIdeaDialog
                                                    .showCreateBoard_My_Ideas(
                                                        controller: controller);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                controller
                                                            .myideas_board_list[
                                                                index]
                                                            .boardId ==
                                                        "Ungrouped ideas"
                                                    ? SvgPicture.asset(
                                                        CustomIcons.addimages,
                                                      )
                                                    : controller
                                                                .myideas_board_list[
                                                                    index]
                                                                .boardId ==
                                                            "Create board"
                                                        ? SvgPicture.asset(
                                                            CustomIcons.addnew,
                                                          )
                                                        : SvgPicture.asset(
                                                            CustomIcons.folder,
                                                          ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Text(
                                                  controller
                                                      .myideas_board_list[index]
                                                      .boardName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      fontFamily: FontFamily
                                                          .maloryLight),
                                                ),
                                              ],
                                            ),
                                          ),
                                          controller.myideas_board_list[index]
                                                      .boardId ==
                                                  "Create board"
                                              ? SizedBox()
                                              : InkWell(
                                                  onTap: () {
                                                    controller.checkAndUncheck_MyIdeas(
                                                        isSelected: controller
                                                            .myideas_board_list[
                                                                index]
                                                            .isSelected
                                                            .value,
                                                        id: controller
                                                            .myideas_board_list[
                                                                index]
                                                            .boardId);
                                                  },
                                                  child: Obx(
                                                    () => controller
                                                                .myideas_board_list[
                                                                    index]
                                                                .isSelected
                                                                .value ==
                                                            true
                                                        ? SvgPicture.asset(
                                                            CustomIcons
                                                                .radiobuttonactive,
                                                          )
                                                        : SvgPicture.asset(
                                                            CustomIcons
                                                                .radiobutton,
                                                          ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.isShowProjects.value == true) {
                          controller.isShowProjects.value = false;
                        } else {
                          controller.isShowProjects.value = true;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Projects",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                fontFamily: FontFamily.maloryBold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 1.w),
                            child: Obx(
                              () => controller.isShowProjects.value == true
                                  ? SvgPicture.asset(CustomIcons.arrowdown,
                                      color: AppColor.darkBlue, height: 1.5.h)
                                  : SvgPicture.asset(
                                      CustomIcons.arrowforwardios,
                                      color: AppColor.darkBlue,
                                      height: 2.5.h,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Obx(
                      () => controller.isShowProjects.value == false
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.project_List.length,
                                  itemBuilder:
                                      (BuildContext context, int projectindex) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 3.h),
                                      child: InkWell(
                                        onTap: () {
                                          if (controller
                                                  .project_List[projectindex]
                                                  .isShown
                                                  .value ==
                                              true) {
                                            controller
                                                .project_List[projectindex]
                                                .isShown
                                                .value = false;
                                          } else {
                                            controller
                                                .project_List[projectindex]
                                                .isShown
                                                .value = true;
                                          }
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        CustomIcons.projects,
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Text(
                                                        controller
                                                            .project_List[
                                                                projectindex]
                                                            .projectName,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.sp,
                                                            fontFamily: FontFamily
                                                                .maloryLight),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 1.w),
                                                    child: Obx(
                                                      () => controller
                                                                  .project_List[
                                                                      projectindex]
                                                                  .isShown
                                                                  .value ==
                                                              false
                                                          ? SvgPicture.asset(
                                                              CustomIcons
                                                                  .arrowforwardios,
                                                              color: AppColor
                                                                  .darkBlue,
                                                              height: 2.5.h,
                                                            )
                                                          : SvgPicture.asset(
                                                              CustomIcons
                                                                  .arrowdown,
                                                              color: AppColor
                                                                  .darkBlue,
                                                              height: 1.5.h,
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Obx(
                                                () => controller
                                                            .project_List[
                                                                projectindex]
                                                            .isShown
                                                            .value ==
                                                        false
                                                    ? SizedBox()
                                                    : Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.w),
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: controller
                                                              .project_List[
                                                                  projectindex]
                                                              .boardList
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 3.h),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (controller
                                                                              .project_List[projectindex]
                                                                              .boardList[index]
                                                                              .boardId ==
                                                                          "Create board") {
                                                                        SaveIdeaDialog.showCreateBoard_Projects(
                                                                            projectID:
                                                                                controller.project_List[projectindex].projectId,
                                                                            controller: controller);
                                                                      }
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        controller.project_List[projectindex].boardList[index].boardId ==
                                                                                "Ungrouped ideas"
                                                                            ? SvgPicture.asset(
                                                                                CustomIcons.addimages,
                                                                              )
                                                                            : controller.project_List[projectindex].boardList[index].boardId == "Create board"
                                                                                ? SvgPicture.asset(
                                                                                    CustomIcons.addnew,
                                                                                  )
                                                                                : SvgPicture.asset(
                                                                                    CustomIcons.folder,
                                                                                  ),
                                                                        SizedBox(
                                                                          width:
                                                                              2.w,
                                                                        ),
                                                                        Text(
                                                                          controller
                                                                              .project_List[projectindex]
                                                                              .boardList[index]
                                                                              .boardName,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 14.sp,
                                                                              fontFamily: FontFamily.maloryLight),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  controller.project_List[projectindex].boardList[index]
                                                                              .boardId ==
                                                                          "Create board"
                                                                      ? SizedBox()
                                                                      : InkWell(
                                                                          onTap:
                                                                              () {
                                                                            controller.checkAndUnchecked_Projects(
                                                                                projectId: controller.project_List[projectindex].projectId,
                                                                                isSelected: controller.project_List[projectindex].boardList[index].isSelected.value,
                                                                                boardId: controller.project_List[projectindex].boardList[index].boardId);
                                                                          },
                                                                          child:
                                                                              Obx(
                                                                            () => controller.project_List[projectindex].boardList[index].isSelected.value == true
                                                                                ? SvgPicture.asset(
                                                                                    CustomIcons.radiobuttonactive,
                                                                                  )
                                                                                : SvgPicture.asset(
                                                                                    CustomIcons.radiobutton,
                                                                                  ),
                                                                          ),
                                                                        ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                              )
                                            ],
                                          ),
                                        ),
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
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: InkWell(
              onTap: () {
                controller.carouselController.nextPage();
              },
              child: Obx(
                () => Opacity(
                  opacity: controller.isSaveTo.value == "" ? 0.4 : 1,
                  child: Container(
                      height: 7.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                                fontFamily: FontFamily.maloryBold,
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp),
                          ),
                          SizedBox(
                            width: 2.2,
                          ),
                          SvgPicture.asset(
                            CustomIcons.arrowright,
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
    );
  }
}
