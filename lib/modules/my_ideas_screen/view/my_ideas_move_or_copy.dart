import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/my_ideas_controller.dart';
import '../dialogs/my_ideas_alert_dialogs.dart';
import '../model/my_ideas_move_copy_images_model.dart';

class MyIdeasMoveOrCopyIdeas extends GetView<MyIdeasController> {
  const MyIdeasMoveOrCopyIdeas(
      {required this.imagesList,
      required this.moveOrCopy,
      required this.previousBoardID,
      super.key});
  final List<ImagesModel> imagesList;
  final String moveOrCopy;
  final String previousBoardID;

  @override
  Widget build(BuildContext context) {
    print("previous board id: ${previousBoardID}");
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(children: [
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
                itemCount: imagesList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Container(
                      height: 12.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColor.greyBlue, width: 1.sp),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(AppEndpoint.endPointFile +
                                  "/" +
                                  imagesList[index].ideaFileImage))),
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
                                                        .myideas_board_list[
                                                            index]
                                                        .boardId ==
                                                    "Create board") {
                                                  MyIdeasAlertDialog
                                                      .showCreateBoard_My_Ideas(
                                                          controller:
                                                              controller);
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
                                                              CustomIcons
                                                                  .addnew,
                                                            )
                                                          : SvgPicture.asset(
                                                              CustomIcons
                                                                  .folder,
                                                            ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Text(
                                                    controller
                                                        .myideas_board_list[
                                                            index]
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
                                                      if (controller
                                                              .myideas_board_list[
                                                                  index]
                                                              .isSelected
                                                              .value ==
                                                          true) {
                                                        controller.uncheckAll();
                                                      } else {
                                                        controller.checkForMyIdeas(
                                                            boardID: controller
                                                                .myideas_board_list[
                                                                    index]
                                                                .boardId);
                                                      }
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
                                    itemBuilder: (BuildContext context,
                                        int projectindex) {
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
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .maloryBold),
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
                                                          child:
                                                              ListView.builder(
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
                                                                        top: 3
                                                                            .h),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (controller.project_List[projectindex].boardList[index].boardId ==
                                                                            "Create board") {
                                                                          MyIdeasAlertDialog.showCreateBoard_Projects(
                                                                              projectID: controller.project_List[projectindex].projectId,
                                                                              controller: controller);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          controller.project_List[projectindex].boardList[index].boardId == "Ungrouped ideas"
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
                                                                            controller.project_List[projectindex].boardList[index].boardName,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 14.sp,
                                                                                fontFamily: FontFamily.maloryLight),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    controller.project_List[projectindex].boardList[index].boardId ==
                                                                            "Create board"
                                                                        ? SizedBox()
                                                                        : InkWell(
                                                                            onTap:
                                                                                () {
                                                                              if (controller.project_List[projectindex].boardList[index].isSelected.value == false) {
                                                                                controller.checkForProjects(boardID: controller.project_List[projectindex].boardList[index].boardId, projectID: controller.project_List[projectindex].projectId);
                                                                              } else {
                                                                                controller.uncheckAll();
                                                                              }
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
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: InkWell(
            onTap: () async {
              if (moveOrCopy == "copy") {
                List ideasList = [];
                for (var i = 0; i < imagesList.length; i++) {
                  ideasList.add(imagesList[i].ideaId);
                }
                controller.copyIdeas(
                    selectedBoardID: previousBoardID,
                    destinationProjectID: controller.selected_projectID.value,
                    destinationBoardID: controller.selected_boardID.value,
                    imageIdList: ideasList);
              } else {
                List ideasList = [];
                for (var i = 0; i < imagesList.length; i++) {
                  ideasList.add(imagesList[i].ideaId);
                }
                controller.moveIdeas(
                    previousBoardID: previousBoardID,
                    destinationProjectID: controller.selected_projectID.value,
                    destinationBoardID: controller.selected_boardID.value,
                    imageIdList: ideasList);
              }
            },
            child: Container(
                alignment: Alignment.center,
                height: 6.h,
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
    );
  }
}
