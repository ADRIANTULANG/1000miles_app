import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/modules/project_ideas_gallery/view/project_ideas_move_ideas.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../bottomsheet/project_ideas_gallery_bottomsheet.dart';
import '../controller/project_ideas_gallery_controller.dart';
import '../dialog/project_ideas_gallery_dialog.dart';
import '../model/final_project_ideas_gallery_model.dart';
import '../widget/archived_ideas.dart';
import '../widget/group_ideas_view.dart';
import '../widget/ungrouped_ideas_view.dart';

class ProjectIdeasGalleryView extends GetView<ProjectIdeasGalleryController> {
  const ProjectIdeasGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectIdeasGalleryController());
    return WillPopScope(
      onWillPop: () async {
        if (controller.isEditing_for_homescreen.value == true) {
          controller.isEditing_for_homescreen.value = false;
          for (var element in controller.ungrouped_list) {
            element.isSelected.value = false;
          }
          return false;
        } else {
          return true;
        }
      },
      child: Obx(
        () => controller.isLoading.value == true
            ? Scaffold(
                body: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 25.w, right: 25.w, bottom: 15.h),
                    child: Lottie.asset("assets/loading/animation.json"),
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: AppColor.white,
                body: SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        Obx(
                          () => Container(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            height: 7.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              border: controller
                                              .scrollPosition_archived.value !=
                                          0.0 ||
                                      controller
                                              .scrollPosition_ungrouped.value !=
                                          0.0 ||
                                      controller.scrollPosition_idea_groups
                                              .value !=
                                          0.0
                                  ? Border(
                                      bottom:
                                          BorderSide(color: AppColor.greyBlue))
                                  : null,
                              // boxShadow: controller.scrollPosition.value == 0.0
                              //     ? []
                              //     : [
                              //         BoxShadow(
                              //           spreadRadius: 1,
                              //           blurRadius: .1,
                              //           color: Color.fromARGB(255, 218, 214, 214),
                              //           offset: Offset(0, 3),
                              //         )
                              //       ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        Get.back();
                                      },
                                      child: Container(
                                        width: 7.w,
                                        alignment: Alignment.centerLeft,
                                        child: Platform.isAndroid
                                            ? SvgPicture.asset(
                                                CustomIcons.arrowback,
                                                color: AppColor.black,
                                              )
                                            : SvgPicture.asset(
                                                CustomIcons.arrowbackios,
                                                color: AppColor.black,
                                              ),
                                      ),
                                    ),
                                    controller.scrollPosition_archived.value !=
                                                0.0 ||
                                            controller
                                                    .scrollPosition_idea_groups
                                                    .value !=
                                                0.0 ||
                                            controller.scrollPosition_ungrouped
                                                    .value !=
                                                0.0
                                        ? SizedBox()
                                        : Entry.all(
                                            duration:
                                                Duration(milliseconds: 500),
                                            child: InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Obx(
                                                  () => Text(
                                                    controller.projectName
                                                                .value ==
                                                            ""
                                                        ? "Unnamed project"
                                                        : controller
                                                            .projectName
                                                            .value
                                                            .capitalizeFirst
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .maloryLight,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Obx(
                                  () => controller.scrollPosition_archived
                                                  .value !=
                                              0.0 ||
                                          controller.scrollPosition_idea_groups
                                                  .value !=
                                              0.0 ||
                                          controller.scrollPosition_ungrouped
                                                  .value !=
                                              0.0
                                      ? Entry.all(
                                          duration: Duration(milliseconds: 500),
                                          child: Obx(
                                            () => Text(
                                              controller.projectName.value
                                                  .capitalizeFirst
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColor.darkBlue,
                                                  fontFamily:
                                                      FontFamily.maloryBold,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (controller
                                            .isEditing_for_homescreen.value ==
                                        true) {
                                      controller.isEditing_for_homescreen
                                          .value = false;
                                    } else {
                                      controller.isEditing_for_homescreen
                                          .value = true;
                                    }
                                    for (var element
                                        in controller.ungrouped_list) {
                                      element.isSelected.value = false;
                                    }
                                    for (var element
                                        in controller.grouped_list) {
                                      element.isSelected.value = false;
                                    }
                                    for (var element
                                        in controller.archived_ideas_list) {
                                      element.isSelected.value = false;
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Obx(
                                      () => Text(
                                        controller.isEditing_for_homescreen
                                                    .value ==
                                                true
                                            ? "Cancel"
                                            : "Select",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily: FontFamily.maloryLight,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => controller.scrollPosition_archived.value !=
                                      0.0 ||
                                  controller.scrollPosition_idea_groups.value !=
                                      0.0 ||
                                  controller.scrollPosition_ungrouped.value !=
                                      0.0
                              ? SizedBox()
                              : Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 5.w, right: 5.w),
                                      width: 100.w,
                                      child: Entry.offset(
                                        xOffset: -10000,
                                        yOffset: 0,
                                        duration: Duration(milliseconds: 500),
                                        child: Text(
                                          "Project ideas",
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
                                      padding: EdgeInsets.only(
                                          left: 5.w, right: 5.w),
                                      child: Entry.offset(
                                        duration: Duration(milliseconds: 500),
                                        xOffset: -10000,
                                        yOffset: 0,
                                        child: Row(
                                          children: [
                                            // InkWell(
                                            //   onTap: () {
                                            //     controller.carouselController
                                            //         .jumpToPage(0);

                                            //     controller.selectedCarouselIndex
                                            //         .value = 0;
                                            //     controller
                                            //         .isEditing_for_homescreen
                                            //         .value = false;
                                            //   },
                                            //   child: Obx(
                                            //     () => Container(
                                            //       padding: EdgeInsets.only(
                                            //           left: 3.w, right: 3.w),
                                            //       height: 3.h,
                                            //       alignment: Alignment.center,
                                            //       decoration: BoxDecoration(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   4),
                                            //           color: controller
                                            //                       .selectedCarouselIndex
                                            //                       .value ==
                                            //                   0
                                            //               ? AppColor
                                            //                   .accentLightblue
                                            //               : AppColor.white),
                                            //       child: Text(
                                            //         "See All",
                                            //         style: TextStyle(
                                            //             fontWeight:
                                            //                 FontWeight.w700,
                                            //             fontFamily: FontFamily
                                            //                 .maloryLight,
                                            //             fontSize: 12.sp,
                                            //             color: controller
                                            //                         .selectedCarouselIndex
                                            //                         .value ==
                                            //                     0
                                            //                 ? AppColor.darkBlue
                                            //                 : AppColor.grey),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   width: 3.w,
                                            // ),
                                            InkWell(
                                              onTap: () {
                                                controller.carouselController
                                                    .jumpToPage(0);
                                                controller.selectedCarouselIndex
                                                    .value = 0;
                                                controller
                                                    .isEditing_for_homescreen
                                                    .value = false;
                                              },
                                              child: Obx(
                                                () => Container(
                                                  padding: EdgeInsets.only(
                                                      left: 3.w, right: 3.w),
                                                  height: 3.h,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: controller
                                                                  .selectedCarouselIndex
                                                                  .value ==
                                                              0
                                                          ? AppColor
                                                              .accentLightblue
                                                          : AppColor.white),
                                                  child: Text(
                                                    "Boards",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: FontFamily
                                                            .maloryLight,
                                                        fontSize: 12.sp,
                                                        color: controller
                                                                    .selectedCarouselIndex
                                                                    .value ==
                                                                0
                                                            ? AppColor.darkBlue
                                                            : AppColor.grey),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller.carouselController
                                                    .jumpToPage(1);

                                                controller.selectedCarouselIndex
                                                    .value = 1;
                                                controller
                                                    .isEditing_for_homescreen
                                                    .value = false;
                                              },
                                              child: Obx(
                                                () => Container(
                                                  padding: EdgeInsets.only(
                                                      left: 3.w, right: 3.w),
                                                  height: 3.h,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: controller
                                                                  .selectedCarouselIndex
                                                                  .value ==
                                                              1
                                                          ? AppColor
                                                              .accentLightblue
                                                          : AppColor.white),
                                                  child: Text(
                                                    "Ideas",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: FontFamily
                                                            .maloryLight,
                                                        fontSize: 12.sp,
                                                        color: controller
                                                                    .selectedCarouselIndex
                                                                    .value ==
                                                                1
                                                            ? AppColor.darkBlue
                                                            : AppColor.grey),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller.carouselController
                                                    .jumpToPage(2);

                                                controller.selectedCarouselIndex
                                                    .value = 2;
                                                controller
                                                    .isEditing_for_homescreen
                                                    .value = false;
                                              },
                                              child: Obx(
                                                () => Container(
                                                  padding: EdgeInsets.only(
                                                      left: 3.w, right: 3.w),
                                                  height: 3.h,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: controller
                                                                  .selectedCarouselIndex
                                                                  .value ==
                                                              2
                                                          ? AppColor
                                                              .accentLightblue
                                                          : AppColor.white),
                                                  child: Text(
                                                    "Archived",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: FontFamily
                                                            .maloryLight,
                                                        fontSize: 12.sp,
                                                        color: controller
                                                                    .selectedCarouselIndex
                                                                    .value ==
                                                                2
                                                            ? AppColor.darkBlue
                                                            : AppColor.grey),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                  ],
                                ),
                        ),
                        Expanded(
                          child: Container(
                            child: CarouselSlider(
                              carouselController: controller.carouselController,
                              options: CarouselOptions(
                                enableInfiniteScroll: false,
                                onPageChanged: (index, reason) {
                                  controller.selectedCarouselIndex.value =
                                      index;
                                  print(index);
                                  controller.scrollPosition_archived.value =
                                      0.0;
                                  controller.scrollPosition_idea_groups.value =
                                      0.0;
                                  controller.scrollPosition_ungrouped.value =
                                      0.0;
                                  controller.isEditing_for_homescreen.value =
                                      false;
                                  for (var element
                                      in controller.archived_ideas_list) {
                                    element.isSelected.value = false;
                                  }
                                  for (var element
                                      in controller.ungrouped_list) {
                                    element.isSelected.value = false;
                                  }
                                },
                                height: 100.h,
                                viewportFraction: 1.0,
                                enlargeCenterPage: false,
                                // autoPlay: false,
                              ),
                              items: [
                                GroupedIdeasView(),
                                UngroupedIdeasView(),
                                ArchivedIdeas()
                              ]
                                  .map(
                                    (view) => view,
                                  )
                                  .toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Obx(
                  () => controller.isEditing_for_homescreen.value == true &&
                          controller.selectedCarouselIndex.value == 1
                      ? Container(
                          height: 5.h,
                          width: 100.w,
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              border: Border(
                                  top: BorderSide(color: AppColor.greyBlue))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // InkWell(
                              //   onTap: () {
                              //     if (controller
                              //             .check_if_there_is_true_in_ungroup_items()
                              //             .value ==
                              //         true) {
                              //       ProjectIdeaGalleryDialog.showArchiveDialog(
                              //           isIdeaOrGroup: "ideas",
                              //           controller: controller);
                              //     } else {}
                              //   },
                              //   child: Obx(
                              //     () => Text(
                              //       // ungrouped list view
                              //       "Archive",
                              //       style: TextStyle(
                              //           fontFamily: FontFamily.maloryLight,
                              //           color: controller
                              //                       .check_if_there_is_true_in_ungroup_items()
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
                                  controller.getProjectsAndIdeaGroups();
                                  // ProjectIdeaGallerBottomsheet.moveBottomSheet(
                                  //     controller: controller);
                                  if (controller
                                          .check_if_there_is_true_in_ungroup_items()
                                          .value ==
                                      true) {
                                    List<FinalProjectGalleryModel> listtopass =
                                        [];
                                    for (var element
                                        in controller.ungrouped_list) {
                                      if (element.isSelected.value == true) {
                                        listtopass.add(element);
                                      }
                                    }
                                    Get.to(() => ProjectIdeasMoveIdea(
                                          from: "Ungroup",
                                          imageList: listtopass,
                                          moveOrCopy: "copy",
                                        ));
                                    controller.scrollPosition_ungrouped.value =
                                        0.0;
                                  }
                                },
                                child: Obx(
                                  () => Text(
                                    "Copy",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryLight,
                                        color: controller
                                                    .check_if_there_is_true_in_ungroup_items()
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
                                          .check_if_there_is_true_in_ungroup_items()
                                          .value ==
                                      true) {
                                    List listOfIdeasID = [];
                                    for (var element
                                        in controller.ungrouped_list) {
                                      if (element.isSelected.value == true) {
                                        listOfIdeasID
                                            .add(element.groupIdOrIdeaId);
                                      }
                                    }
                                    ProjectIdeaGalleryDialog.showDeleteDialog(
                                        groupID: "",
                                        controller: controller,
                                        listOfBoardId: [],
                                        listOfIdeaID: listOfIdeasID);
                                  }
                                },
                                child: Obx(
                                  () => Text(
                                    "Delete",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryLight,
                                        color: controller
                                                    .check_if_there_is_true_in_ungroup_items()
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
                                  // ProjectIdeaGallerBottomsheet.moveBottomSheet(
                                  //     controller: controller);
                                  if (controller
                                          .check_if_there_is_true_in_ungroup_items()
                                          .value ==
                                      true) {
                                    controller
                                        .selected_previous_groupid_for_moving
                                        .value = "";
                                    List<FinalProjectGalleryModel> listtopass =
                                        [];
                                    for (var element
                                        in controller.ungrouped_list) {
                                      if (element.isSelected.value == true) {
                                        listtopass.add(element);
                                      }
                                    }
                                    Get.to(() => ProjectIdeasMoveIdea(
                                          from: "Ungroup",
                                          imageList: listtopass,
                                          moveOrCopy: "move",
                                        ));
                                    controller.scrollPosition_ungrouped.value =
                                        0.0;
                                  }
                                },
                                child: Obx(
                                  () => Text(
                                    "Move",
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryLight,
                                        color: controller
                                                    .check_if_there_is_true_in_ungroup_items()
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
                        )
                      : Container(
                          height: 5.h,
                          width: 100.w,
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: AppColor.greyBlue))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => controller.selectedCarouselIndex.value ==
                                        2
                                    ? Obx(
                                        () => controller
                                                    .check_if_there_is_true_in_archived_items()
                                                    .value ==
                                                true
                                            ? InkWell(
                                                onTap: () {
                                                  controller.recoverIdeas();
                                                },
                                                child: Container(
                                                  width: 20.w,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: SvgPicture.asset(
                                                    CustomIcons.refresh,
                                                    color: AppColor.black,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 20.w,
                                                alignment: Alignment.centerLeft,
                                                child: SvgPicture.asset(
                                                  CustomIcons.refresh,
                                                  color: AppColor.grey,
                                                ),
                                              ),
                                      )
                                    : controller.selectedCarouselIndex.value ==
                                                0 &&
                                            controller.isEditing_for_homescreen
                                                    .value ==
                                                true
                                        ? InkWell(
                                            onTap: () {
                                              if (controller
                                                      .check_if_there_is_true_in_group_boards()
                                                      .value ==
                                                  true) {
                                                ProjectIdeaGalleryDialog
                                                    .showArchiveDialog(
                                                        isIdeaOrGroup: "group",
                                                        controller: controller);
                                              }
                                            },
                                            child: Obx(
                                              () => Text(
                                                // grouped list view
                                                "Archived",
                                                style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.maloryLight,
                                                    color: controller
                                                                .check_if_there_is_true_in_group_boards()
                                                                .value ==
                                                            true
                                                        ? AppColor.darkBlue
                                                        : AppColor.grey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                              ),
                              Obx(() =>
                                  controller.selectedCarouselIndex.value == 2
                                      ? InkWell(
                                          onTap: () {
                                            if (controller
                                                    .check_if_there_is_true_in_archived_items()
                                                    .value ==
                                                true) {
                                              List boardIDList = [];
                                              for (var element in controller
                                                  .archived_ideas_list) {
                                                if (element.isSelected.value ==
                                                    true) {
                                                  boardIDList.add(
                                                      element.groupIdOrIdeaId);
                                                }
                                              }
                                              ProjectIdeaGalleryDialog
                                                  .showDeleteDialog(
                                                      controller: controller,
                                                      listOfBoardId:
                                                          boardIDList,
                                                      listOfIdeaID: [],
                                                      groupID: "");
                                            }
                                          },
                                          child: Container(
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            child: Obx(
                                              () => SvgPicture.asset(
                                                CustomIcons.trash,
                                                color: controller
                                                            .check_if_there_is_true_in_archived_items()
                                                            .value ==
                                                        true
                                                    ? AppColor.darkBlue
                                                    : AppColor.grey,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox()),
                              Obx(
                                () => controller.selectedCarouselIndex.value ==
                                            0 &&
                                        controller.isEditing_for_homescreen
                                                .value ==
                                            true
                                    ? InkWell(
                                        onTap: () {
                                          if (controller
                                                  .check_if_there_is_true_in_group_boards()
                                                  .value ==
                                              true) {
                                            List boardIDList = [];
                                            for (var element
                                                in controller.grouped_list) {
                                              if (element.isSelected.value ==
                                                  true) {
                                                boardIDList.add(
                                                    element.groupIdOrIdeaId);
                                              }
                                            }
                                            ProjectIdeaGalleryDialog
                                                .showDeleteDialog(
                                                    groupID: "",
                                                    listOfIdeaID: [],
                                                    listOfBoardId: boardIDList,
                                                    controller: controller);
                                          }
                                        },
                                        child: Obx(
                                          () => Text(
                                            // grouped list view
                                            "Delete",
                                            style: TextStyle(
                                                fontFamily:
                                                    FontFamily.maloryLight,
                                                color: controller
                                                            .check_if_there_is_true_in_group_boards()
                                                            .value ==
                                                        true
                                                    ? AppColor.darkBlue
                                                    : AppColor.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          ProjectIdeaGallerBottomsheet
                                              .showBottomSheetButtonAndroid(
                                                  controller: controller,
                                                  context: context);
                                        },
                                        child: Container(
                                          width: 20.w,
                                          alignment: Alignment.centerRight,
                                          child: Showcase.withWidget(
                                            height: 20.h,
                                            width: 90.w,
                                            key: controller.addIdeaShocaseKey,
                                            disposeOnTap: true,
                                            container: Padding(
                                              padding: EdgeInsets.only(
                                                  right: 2.w, top: 2.h),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 20.h,
                                                    width: 90.w,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Container(
                                                          width: 90.w,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 4.w),
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child:
                                                              SvgPicture.asset(
                                                            CustomIcons.clear,
                                                            color: AppColor
                                                                .darkBlue,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Container(
                                                          width: 90.w,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4.w),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Create an idea",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18.sp,
                                                                color: AppColor
                                                                    .darkBlue,
                                                                fontFamily:
                                                                    FontFamily
                                                                        .maloryBold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Container(
                                                          width: 90.w,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4.w),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Tap plus icon and choose the \npreffered image upload method",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                                color: AppColor
                                                                    .darkBlue,
                                                                fontFamily:
                                                                    FontFamily
                                                                        .maloryLight),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 2.h,
                                                    width: 90.w,
                                                    padding: EdgeInsets.only(
                                                        right: 3.w),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: SvgPicture.asset(
                                                      CustomIcons.arrowpointer,
                                                      color: AppColor.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              CustomIcons.addnew,
                                              color: AppColor.black,
                                            ),
                                          ),
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
