import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/config/endpoints.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/project_ideas_gallery_controller.dart';
import '../dialog/project_ideas_gallery_dialog.dart';
import '../model/final_project_ideas_gallery_model.dart';

class ProjectIdeasMoveIdea extends GetView<ProjectIdeasGalleryController> {
  const ProjectIdeasMoveIdea(
      {required this.imageList,
      required this.from,
      required this.moveOrCopy,
      super.key});
  final List<FinalProjectGalleryModel> imageList;
  final String moveOrCopy;
  final String from;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.selected_previous_groupid_for_moving.value = "";
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  height: 7.h,
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                          controller
                              .selected_previous_groupid_for_moving.value = "";
                        },
                        child: Container(
                          width: 22.w,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.maloryLight,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Choose Project",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.maloryBold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        width: 22.w,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.w,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.w),
                  height: 12.h,
                  width: 100.w,
                  child: ListView.builder(
                    itemCount: imageList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: Container(
                          height: 12.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColor.greyBlue, width: 1.sp),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppEndpoint.endPointFile +
                                      "/" +
                                      imageList[index].ideaFileImage))),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Container(
                              child: Obx(
                                () => ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                      .current_project_and_group_list.length,
                                  itemBuilder:
                                      (BuildContext context, int projectindex) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: 5.w,
                                        right: 5.w,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    CustomIcons.projects,
                                                    color: AppColor.darkBlue,
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (controller
                                                              .current_project_and_group_list[
                                                                  projectindex]
                                                              .isShown
                                                              .value ==
                                                          true) {
                                                        controller
                                                            .current_project_and_group_list[
                                                                projectindex]
                                                            .isShown
                                                            .value = false;
                                                      } else {
                                                        controller
                                                            .current_project_and_group_list[
                                                                projectindex]
                                                            .isShown
                                                            .value = true;
                                                      }
                                                    },
                                                    child: Text(
                                                      "Current project",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: FontFamily
                                                            .maloryBold,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (controller
                                                          .current_project_and_group_list[
                                                              projectindex]
                                                          .isShown
                                                          .value ==
                                                      true) {
                                                    controller
                                                        .current_project_and_group_list[
                                                            projectindex]
                                                        .isShown
                                                        .value = false;
                                                  } else {
                                                    controller
                                                        .current_project_and_group_list[
                                                            projectindex]
                                                        .isShown
                                                        .value = true;
                                                  }
                                                },
                                                child: Obx(
                                                  () => controller
                                                              .current_project_and_group_list[
                                                                  projectindex]
                                                              .isShown
                                                              .value ==
                                                          true
                                                      ? SvgPicture.asset(
                                                          CustomIcons.arrowdown,
                                                          color:
                                                              AppColor.darkBlue,
                                                          height: 1.5.h,
                                                        )
                                                      : SvgPicture.asset(
                                                          CustomIcons
                                                              .arrowforwardios,
                                                          color:
                                                              AppColor.darkBlue,
                                                          height: 2.5.h,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Obx(
                                            () => controller
                                                        .current_project_and_group_list[
                                                            projectindex]
                                                        .isShown
                                                        .value ==
                                                    false
                                                ? SizedBox()
                                                : Container(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: controller
                                                          .current_project_and_group_list[
                                                              projectindex]
                                                          .groupLists
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int groupindex) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2.h),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 5
                                                                            .w),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        controller.current_project_and_group_list[projectindex].groupLists[groupindex].id ==
                                                                                "Ungrouped ideas"
                                                                            ? SvgPicture.asset(
                                                                                CustomIcons.addimages,
                                                                                color: AppColor.darkBlue,
                                                                              )
                                                                            : controller.current_project_and_group_list[projectindex].groupLists[groupindex].id == "Create board"
                                                                                ? SvgPicture.asset(
                                                                                    CustomIcons.addnew,
                                                                                    color: AppColor.darkBlue,
                                                                                  )
                                                                                : SvgPicture.asset(
                                                                                    CustomIcons.folder,
                                                                                    color: AppColor.darkBlue,
                                                                                  ),
                                                                        SizedBox(
                                                                          width:
                                                                              3.w,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (controller.current_project_and_group_list[projectindex].groupLists[groupindex].id ==
                                                                                "Create board") {
                                                                              ProjectIdeaGalleryDialog.showCreateBoard_Projects(controller: controller, projectID: controller.current_project_and_group_list[projectindex].id);
                                                                            } else {}
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            controller.current_project_and_group_list[projectindex].groupLists[groupindex].name,
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: FontFamily.maloryLight,
                                                                              fontSize: 14.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    controller.current_project_and_group_list[projectindex].groupLists[groupindex].id ==
                                                                            "Create board"
                                                                        ? SizedBox()
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              if (controller.current_project_and_group_list[projectindex].groupLists[groupindex].isSelected.value == false) {
                                                                                controller.checkRadioButton_for_group_current_project(projectid: controller.current_project_and_group_list[projectindex].id, groupidID: controller.current_project_and_group_list[projectindex].groupLists[groupindex].id);
                                                                              } else {
                                                                                controller.un_checkRadioButton();
                                                                              }
                                                                            },
                                                                            child:
                                                                                Obx(
                                                                              () => controller.current_project_and_group_list[projectindex].groupLists[groupindex].isSelected.value == false
                                                                                  ? SvgPicture.asset(
                                                                                      CustomIcons.radiobutton,
                                                                                      color: AppColor.darkBlue,
                                                                                    )
                                                                                  : SvgPicture.asset(
                                                                                      CustomIcons.radiobuttonactive,
                                                                                      color: AppColor.darkBlue,
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      },
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
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Container(
                              child: Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.project_and_group_list.length,
                                  itemBuilder:
                                      (BuildContext context, int projectindex) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.w, right: 5.w, bottom: 2.h),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    CustomIcons.projects,
                                                    color: AppColor.darkBlue,
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (controller.projectID
                                                              .value !=
                                                          controller
                                                              .project_and_group_list[
                                                                  projectindex]
                                                              .id) {
                                                        if (controller
                                                                .project_and_group_list[
                                                                    projectindex]
                                                                .isShown
                                                                .value ==
                                                            false) {
                                                          controller
                                                              .project_and_group_list[
                                                                  projectindex]
                                                              .isShown
                                                              .value = true;
                                                        } else {
                                                          controller
                                                              .project_and_group_list[
                                                                  projectindex]
                                                              .isShown
                                                              .value = false;
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                      controller
                                                          .project_and_group_list[
                                                              projectindex]
                                                          .name,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: FontFamily
                                                            .maloryBold,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (controller
                                                          .projectID.value !=
                                                      controller
                                                          .project_and_group_list[
                                                              projectindex]
                                                          .id) {
                                                    if (controller
                                                            .project_and_group_list[
                                                                projectindex]
                                                            .isShown
                                                            .value ==
                                                        false) {
                                                      controller
                                                          .project_and_group_list[
                                                              projectindex]
                                                          .isShown
                                                          .value = true;
                                                    } else {
                                                      controller
                                                          .project_and_group_list[
                                                              projectindex]
                                                          .isShown
                                                          .value = false;
                                                    }
                                                  }
                                                },
                                                child: Obx(
                                                  () => controller
                                                              .project_and_group_list[
                                                                  projectindex]
                                                              .isShown
                                                              .value ==
                                                          true
                                                      ? SvgPicture.asset(
                                                          CustomIcons.arrowdown,
                                                          color:
                                                              AppColor.darkBlue,
                                                          height: 1.5.h,
                                                        )
                                                      : SvgPicture.asset(
                                                          CustomIcons
                                                              .arrowforwardios,
                                                          color:
                                                              AppColor.darkBlue,
                                                          height: 2.5.h,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Obx(
                                            () => controller
                                                        .project_and_group_list[
                                                            projectindex]
                                                        .isShown
                                                        .value ==
                                                    false
                                                ? SizedBox()
                                                : Container(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: controller
                                                          .project_and_group_list[
                                                              projectindex]
                                                          .groupLists
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int groupindex) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2.h),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 5
                                                                            .w),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        controller.project_and_group_list[projectindex].groupLists[groupindex].id ==
                                                                                "Ungrouped ideas"
                                                                            ? SvgPicture.asset(
                                                                                CustomIcons.addimages,
                                                                                color: AppColor.darkBlue,
                                                                              )
                                                                            : controller.project_and_group_list[projectindex].groupLists[groupindex].id == "Create board"
                                                                                ? SvgPicture.asset(
                                                                                    CustomIcons.addnew,
                                                                                    color: AppColor.darkBlue,
                                                                                  )
                                                                                : SvgPicture.asset(
                                                                                    CustomIcons.folder,
                                                                                    color: AppColor.darkBlue,
                                                                                  ),
                                                                        SizedBox(
                                                                          width:
                                                                              3.w,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (controller.project_and_group_list[projectindex].groupLists[groupindex].id ==
                                                                                "Create board") {
                                                                              ProjectIdeaGalleryDialog.showCreateBoard_Projects(controller: controller, projectID: controller.project_and_group_list[projectindex].id);
                                                                            } else {}
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            controller.project_and_group_list[projectindex].groupLists[groupindex].name,
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: FontFamily.maloryLight,
                                                                              fontSize: 14.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    controller.project_and_group_list[projectindex].groupLists[groupindex].id ==
                                                                            "Create board"
                                                                        ? SizedBox()
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              if (controller.project_and_group_list[projectindex].groupLists[groupindex].isSelected.value == false) {
                                                                                controller.checkRadioButton_for_group_not_current_projects(projectid: controller.project_and_group_list[projectindex].id, groupidID: controller.project_and_group_list[projectindex].groupLists[groupindex].id);
                                                                              } else {
                                                                                controller.un_checkRadioButton();
                                                                              }
                                                                            },
                                                                            child:
                                                                                Obx(
                                                                              () => controller.project_and_group_list[projectindex].groupLists[groupindex].isSelected.value == false
                                                                                  ? SvgPicture.asset(
                                                                                      CustomIcons.radiobutton,
                                                                                      color: AppColor.darkBlue,
                                                                                    )
                                                                                  : SvgPicture.asset(
                                                                                      CustomIcons.radiobuttonactive,
                                                                                      color: AppColor.darkBlue,
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      },
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
                        ],
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
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: InkWell(
              onTap: () async {
                if (moveOrCopy == "copy") {
                  controller.copyTo(imageList: imageList);
                } else {
                  controller.moveTo(imageList: imageList, from: from);
                  print(controller.selected_previous_groupid_for_moving.value);
                }
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
                    moveOrCopy == "copy" ? "Copy" : "Move",
                    style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        color: AppColor.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
