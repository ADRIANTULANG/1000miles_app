import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/modules/select_photo_for_idea_screen/view/select_photo_for_idea_camera_view.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../../select_photo_for_product_screen/view/select_photo_for_product_camera_view.dart';
import '../controller/bottomnav_controller.dart';

class BottomNavigationBottomSheet {
  static showAddNewProject(
      {required BottomNavigationController controller,
      required BuildContext context}) {
    controller.isFocusProjectTag.value = true;
    Get.bottomSheet(
        Obx(
          () => DraggableScrollableSheet(
              initialChildSize:
                  controller.isKeyboardOpen.value == true ? .92 : .95,
              maxChildSize: controller.isKeyboardOpen.value == true ? .92 : .95,
              minChildSize: 0.25,
              builder: (context, scrollController) {
                return GestureDetector(
                  onTap: () {
                    controller.projectNameFocusNode.unfocus();
                    controller.isFocusProjectTag.value = false;
                    controller.isFocusProjectName.value = false;
                    controller.projectTagFocusNode.unfocus();
                  },
                  child: Container(
                    height: 94.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          // color: Colors.red,
                          height: 5.h,
                          padding: EdgeInsets.only(
                            left: 5.w,
                            right: 5.w,
                          ),
                          child: Platform.isIOS
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Cancel",
                                      style: TextStyle(
                                          fontFamily: FontFamily.maloryBold,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.sp),
                                    ),
                                    Text(
                                      "New Project",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontFamily: FontFamily.maloryBold,
                                          fontSize: 16.sp),
                                    ),
                                    Obx(
                                      () => controller.isEnableContinueButton
                                                  .value ==
                                              true
                                          ? InkWell(
                                              onTap: () async {
                                                controller.isCreatingProject
                                                    .value = true;
                                                await controller
                                                    .createProject();
                                                controller.isCreatingProject
                                                    .value = false;
                                              },
                                              child: Text(
                                                "Continue",
                                                style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.maloryBold,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13.sp),
                                              ),
                                            )
                                          : Text(
                                              "Continue",
                                              style: TextStyle(
                                                  color: AppColor.greyBlue,
                                                  fontFamily:
                                                      FontFamily.maloryBold,
                                                  fontSize: 13.sp),
                                            ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          CustomIcons.arrowback,
                                          color: AppColor.black,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          "New Project",
                                          style: TextStyle(
                                              color: AppColor.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: FontFamily.maloryBold,
                                              fontSize: 16.sp),
                                        ),
                                      ],
                                    ),
                                    Obx(
                                      () => controller.isEnableContinueButton
                                                  .value ==
                                              true
                                          ? InkWell(
                                              onTap: () async {
                                                controller.isCreatingProject
                                                    .value = true;
                                                await controller
                                                    .createProject();
                                                controller.isCreatingProject
                                                    .value = false;
                                              },
                                              child: Text(
                                                "Continue",
                                                style: TextStyle(
                                                    color: AppColor.darkBlue,
                                                    fontFamily:
                                                        FontFamily.maloryBold,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.sp),
                                              ),
                                            )
                                          : Text(
                                              "Continue",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.greyBlue,
                                                  fontFamily:
                                                      FontFamily.maloryBold,
                                                  fontSize: 14.sp),
                                            ),
                                    )
                                  ],
                                ),
                        ),
                        Platform.isAndroid
                            ? Divider(
                                color: AppColor.grey,
                              )
                            : SizedBox(),
                        Obx(
                          () => Container(
                            height: controller.isKeyboardOpen.value == true
                                ? 90.h -
                                    MediaQuery.of(context).viewInsets.bottom
                                : 90.h,
                            width: 100.w,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 8.w, right: 5.w),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Project name",
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontFamily: FontFamily.maloryBold,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 5.w, right: 5.w),
                                    height: 6.5.h,
                                    width: 100.w,
                                    child: TextField(
                                      expands: true,
                                      maxLines: null,
                                      minLines: null,
                                      obscureText: false,
                                      focusNode:
                                          controller.projectNameFocusNode,
                                      controller: controller.projectname,
                                      onChanged: (value) {
                                        if (controller
                                            .projectname.text.isEmpty) {
                                          controller.isEnableContinueButton
                                              .value = false;
                                        } else {
                                          controller.isEnableContinueButton
                                              .value = true;
                                        }
                                      },
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontFamily: FontFamily.maloryLight,
                                          fontSize: 13.sp),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 1.h, bottom: 1.h, left: 3.w),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: AppColor.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: AppColor.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          hintText: 'Enter name here',
                                          hintStyle: TextStyle(
                                              color: AppColor.grey,
                                              fontFamily:
                                                  FontFamily.maloryLight,
                                              fontSize: 13.sp),
                                          alignLabelWithHint: true),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Obx(
                                    () => controller.isFocusProjectTag.value ==
                                            true
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                left: 5.w, right: 5.w),
                                            height: 6.5.h,
                                            width: 100.w,
                                            child: TextField(
                                              expands: true,
                                              maxLines: null,
                                              minLines: null,
                                              obscureText: false,
                                              controller:
                                                  controller.projecttags,
                                              focusNode: controller
                                                  .projectTagFocusNode,
                                              onChanged: (value) {
                                                controller.tagsMaker(
                                                    text: controller
                                                        .projecttags.text);
                                              },
                                              style: TextStyle(
                                                  color: AppColor.black,
                                                  fontFamily:
                                                      FontFamily.maloryLight,
                                                  fontSize: 13.sp),
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 1.h,
                                                    bottom: 1.h,
                                                    left: 3.w),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2,
                                                            color:
                                                                AppColor.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: AppColor.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                hintText:
                                                    'Enter tags, comma separated',
                                                hintStyle: TextStyle(
                                                    color: AppColor.grey,
                                                    fontFamily:
                                                        FontFamily.maloryLight,
                                                    fontSize: 13.sp),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.w, right: 5.w),
                                            child: InkWell(
                                              onTap: () {
                                                controller.isFocusProjectTag
                                                    .value = true;
                                                controller.projectTagFocusNode
                                                    .requestFocus();
                                                print("here");
                                              },
                                              child: Container(
                                                height: 6.5.h,
                                                width: 100.w,
                                                padding: EdgeInsets.only(
                                                    top: 1.65.h,
                                                    bottom: 1.h,
                                                    left: 2.4.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: AppColor.grey)),
                                                child: Obx(
                                                  () => controller.tagValues
                                                              .value ==
                                                          ""
                                                      ? Text(
                                                          'Enter tags, comma separated',
                                                          style: TextStyle(
                                                              color:
                                                                  AppColor.grey,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .maloryLight,
                                                              fontSize: 13.sp),
                                                        )
                                                      : Text(
                                                          controller
                                                              .tagValues.value,
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .accentTorquise,
                                                              fontFamily:
                                                                  FontFamily
                                                                      .maloryLight,
                                                              fontSize: 13.sp),
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 5.w, right: 5.w),
                                    width: 100.w,
                                    child: Text(
                                      "Choose team",
                                      style: TextStyle(
                                          fontFamily: FontFamily.maloryBold,
                                          color: AppColor.black,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Obx(
                                    () => controller.usersTeamList.length == 0
                                        ? Container(
                                            height: 30.h,
                                            padding: EdgeInsets.only(
                                                left: 5.w,
                                                right: 5.w,
                                                top: 5.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  CustomIcons.team,
                                                  color: AppColor.grey,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Text(
                                                  "No teams available",
                                                  style: TextStyle(
                                                      fontFamily: FontFamily
                                                          .maloryLight,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColor.grey),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(
                                            height: 30.h,
                                            width: 100.w,
                                            padding: EdgeInsets.only(
                                                left: 5.w, right: 5.w),
                                            child: Obx(
                                              () => ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                            .usersTeamList
                                                            .length >=
                                                        4
                                                    ? 4
                                                    : controller
                                                        .usersTeamList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: .5.h),
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
                                                                  Container(
                                                                    width: controller.usersTeamList[index].members.length ==
                                                                            1
                                                                        ? 11.w
                                                                        : 27.w,
                                                                    height: 5.h,
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          AlignmentDirectional
                                                                              .centerStart,
                                                                      children: [
                                                                        for (var stackindex =
                                                                                0;
                                                                            stackindex <
                                                                                (controller.usersTeamList[index].members.length > 3 ? 4 : controller.usersTeamList[index].members.length);
                                                                            stackindex++) ...[
                                                                          stackindex == 3 && controller.usersTeamList[index].members.length > 3
                                                                              ? Positioned(
                                                                                  left: stackindex == 0 ? 0.w : (stackindex * 5.w),
                                                                                  child: CircleAvatar(
                                                                                    radius: 5.5.w,
                                                                                    backgroundColor: Colors.white,
                                                                                    child: CircleAvatar(
                                                                                      radius: 5.w,
                                                                                      backgroundColor: Colors.black,
                                                                                      child: Text(
                                                                                        (controller.usersTeamList[index].members.length - 3).toString() + "+",
                                                                                        style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Positioned(
                                                                                  left: stackindex == 0 ? 0.w : (stackindex * 5.w),
                                                                                  child: CircleAvatar(
                                                                                    radius: 5.5.w,
                                                                                    backgroundColor: Colors.white,
                                                                                    child: CircleAvatar(
                                                                                      radius: 5.w,
                                                                                      // backgroundColor: controller.colorList[controller.getRandom()],
                                                                                      backgroundColor: AppColor.accentTorquise,
                                                                                      child: Text(
                                                                                        controller.usersTeamList[index].members[stackindex].email[0].capitalizeFirst.toString(),
                                                                                        style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                        .usersTeamList[
                                                                            index]
                                                                        .name,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            FontFamily
                                                                                .maloryLight,
                                                                        color: AppColor
                                                                            .black,
                                                                        fontSize:
                                                                            13.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                      .projectNameFocusNode
                                                                      .unfocus();
                                                                  controller
                                                                      .isFocusProjectTag
                                                                      .value = false;
                                                                  controller
                                                                      .projectTagFocusNode
                                                                      .unfocus();
                                                                  if (controller
                                                                          .usersTeamList[
                                                                              index]
                                                                          .isSelected
                                                                          .value ==
                                                                      true) {
                                                                    controller
                                                                        .usersTeamList[
                                                                            index]
                                                                        .isSelected
                                                                        .value = false;
                                                                    controller
                                                                        .selectedTeam
                                                                        .value = "";
                                                                  } else {
                                                                    controller.changeRadioButton(
                                                                        id: controller
                                                                            .usersTeamList[index]
                                                                            .id);
                                                                  }
                                                                },
                                                                child: Obx(
                                                                  () => controller
                                                                              .usersTeamList[
                                                                                  index]
                                                                              .isSelected
                                                                              .value ==
                                                                          true
                                                                      ? SvgPicture
                                                                          .asset(
                                                                          CustomIcons
                                                                              .radiobuttonactive,
                                                                          color:
                                                                              AppColor.black,
                                                                        )
                                                                      : SvgPicture
                                                                          .asset(
                                                                          CustomIcons
                                                                              .radiobutton,
                                                                          color:
                                                                              AppColor.black,
                                                                        ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Colors.grey,
                                                          )
                                                        ],
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
                                  Container(
                                    width: 100.w,
                                    padding:
                                        EdgeInsets.only(left: 5.w, right: 5.w),
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.usersTeamList.length >
                                            4) {
                                          FocusScope.of(context).unfocus();
                                          showListOfTeams(
                                              controller: controller);
                                        } else {}
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Obx(
                                            () => Text(
                                              "See All",
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.maloryBold,
                                                  color: controller
                                                              .usersTeamList
                                                              .length >
                                                          4
                                                      ? AppColor.grey
                                                      : AppColor.white,
                                                  fontSize: 12.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Obx(
                                            () => Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 17.sp,
                                              color: controller.usersTeamList
                                                          .length >
                                                      4
                                                  ? AppColor.grey
                                                  : AppColor.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Obx(
                                      () => controller
                                                  .isCreatingProject.value ==
                                              false
                                          ? InkWell(
                                              onTap: () async {
                                                if (controller
                                                        .isEnableContinueButton
                                                        .value ==
                                                    true) {
                                                  controller.isCreatingProject
                                                      .value = true;
                                                  await controller
                                                      .createProject();
                                                  controller.isCreatingProject
                                                      .value = false;
                                                } else {}
                                              },
                                              child: Obx(
                                                () => Opacity(
                                                  opacity: controller
                                                              .isEnableContinueButton
                                                              .value ==
                                                          true
                                                      ? 1
                                                      : 0.3,
                                                  child: Container(
                                                    height: 6.5.h,
                                                    width: 100.w,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.darkBlue,

                                                      border: Border.all(
                                                          color:
                                                              AppColor.darkBlue,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // border: Border.all(color: Colors.black54),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Continue",
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: AppColor.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 6.5.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: .8.w),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // border: Border.all(color: Colors.black54),
                                              ),
                                              alignment: Alignment.center,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColor.white,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        isScrollControlled: true);
  }

  static showListOfTeams({required BottomNavigationController controller}) {
    Get.bottomSheet(
        Container(
          height: 95.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Container(
                // color: Colors.red,
                height: 5.h,
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 5.w,
                ),
                child: Row(
                  children: [
                    Platform.isIOS
                        ? SvgPicture.asset(
                            CustomIcons.clear,
                            color: AppColor.black,
                          )
                        : SvgPicture.asset(
                            CustomIcons.arrowback,
                            color: AppColor.black,
                          ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.only(left: Platform.isIOS ? 0 : 4.w),
                        alignment: Platform.isIOS
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: Text(
                          "Choose Team",
                          style: TextStyle(
                              fontFamily: FontFamily.maloryBold,
                              color: AppColor.black,
                              fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Platform.isAndroid
                  ? Divider(
                      color: AppColor.grey,
                    )
                  : SizedBox(),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: ListView.builder(
                    itemCount: controller.usersTeamList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: .5.h),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 27.w,
                                        height: 5.h,
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          children: [
                                            for (var stackindex = 0;
                                                stackindex <
                                                    (controller
                                                                .usersTeamList[
                                                                    index]
                                                                .members
                                                                .length >
                                                            3
                                                        ? 4
                                                        : controller
                                                            .usersTeamList[
                                                                index]
                                                            .members
                                                            .length);
                                                stackindex++) ...[
                                              stackindex == 3 &&
                                                      controller
                                                              .usersTeamList[
                                                                  index]
                                                              .members
                                                              .length >
                                                          3
                                                  ? Positioned(
                                                      left: stackindex == 0
                                                          ? 0.w
                                                          : (stackindex * 5.w),
                                                      child: CircleAvatar(
                                                        radius: 5.5.w,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: CircleAvatar(
                                                          radius: 5.w,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: Text(
                                                            (controller.usersTeamList[index].members
                                                                            .length -
                                                                        3)
                                                                    .toString() +
                                                                "+",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Positioned(
                                                      left: stackindex == 0
                                                          ? 0.w
                                                          : (stackindex * 5.w),
                                                      child: CircleAvatar(
                                                        radius: 5.5.w,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: CircleAvatar(
                                                          radius: 5.w,
                                                          backgroundColor:
                                                              AppColor
                                                                  .accentTorquise,
                                                          // backgroundColor: controller
                                                          //         .colorList[
                                                          //     controller
                                                          //         .getRandom()],
                                                          child: Text(
                                                            controller
                                                                .usersTeamList[
                                                                    index]
                                                                .members[
                                                                    stackindex]
                                                                .email[0]
                                                                .capitalizeFirst
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        controller.usersTeamList[index].name,
                                        style: TextStyle(
                                            fontFamily: FontFamily.maloryLight,
                                            color: AppColor.black,
                                            fontSize: 13.sp),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.projectNameFocusNode.unfocus();
                                      controller.isFocusProjectTag.value =
                                          false;
                                      controller.projectTagFocusNode.unfocus();
                                      if (controller.usersTeamList[index]
                                              .isSelected.value ==
                                          true) {
                                        controller.usersTeamList[index]
                                            .isSelected.value = false;
                                        controller.selectedTeam.value = "";
                                      } else {
                                        controller.changeRadioButton(
                                            id: controller
                                                .usersTeamList[index].id);
                                      }
                                      // controller.changeRadioButton(
                                      //     id: controller
                                      //         .usersTeamList[index].id);
                                    },
                                    child: Obx(
                                      () => controller.usersTeamList[index]
                                                  .isSelected.value ==
                                              true
                                          ? SvgPicture.asset(
                                              CustomIcons.radiobuttonactive,
                                              color: AppColor.black,
                                            )
                                          : SvgPicture.asset(
                                              CustomIcons.radiobutton,
                                              color: AppColor.black,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
        isScrollControlled: true);
  }

  static showShortCutButtonsForIos(
      {required BottomNavigationController controller,
      required BuildContext context}) {
    Get.bottomSheet(
      Container(
        height: 45.h,
        width: 100.w,
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 4.w, right: 4.w),
        child: Column(
          children: [
            Container(
              height: 33.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(children: [
                Container(
                    height: 4.h,
                    width: 100.w,
                    padding: EdgeInsets.only(top: 1.h),
                    alignment: Alignment.center,
                    child: Text(
                      "Choose option",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.maloryLight,
                          color: Color.fromARGB(255, 187, 185, 185)),
                    )),
                Divider(
                  thickness: .15.h,
                ),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              CustomIcons.qrcode,
                              color: AppColor.accentTorquise,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              "Yoooto scanner",
                              style: TextStyle(
                                  color: AppColor.accentTorquise,
                                  fontSize: 15.sp,
                                  fontFamily: FontFamily.maloryLight,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))),
                Divider(
                  thickness: .15.h,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.back();
                    showAddNewProject(controller: controller, context: context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Create project",
                      style: TextStyle(
                          color: AppColor.accentTorquise,
                          fontSize: 15.sp,
                          fontFamily: FontFamily.maloryLight,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )),
                Divider(
                  thickness: .15.h,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() => CameraProductScreenView(), arguments: {
                      "isFromHomescreen": true,
                      "projectID": "",
                      "projectName": "",
                      "groupID": ""
                    });
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "New product",
                        style: TextStyle(
                            color: AppColor.accentTorquise,
                            fontSize: 15.sp,
                            fontFamily: FontFamily.maloryLight,
                            fontWeight: FontWeight.w400),
                      )),
                )),
                Divider(
                  thickness: .15.h,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() => CameraIdeaScreenView(), arguments: {
                      "isSavetoMyIdeas": false,
                      "isFromHomescreen": true,
                      "projectID": "",
                      "projectName": "",
                      "groupID": ""
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.only(bottom: 1.h),
                      alignment: Alignment.center,
                      child: Text(
                        "New idea",
                        style: TextStyle(
                            color: AppColor.accentTorquise,
                            fontSize: 15.sp,
                            fontFamily: FontFamily.maloryLight,
                            fontWeight: FontWeight.w400),
                      )),
                )),
              ]),
            ),
            Expanded(child: SizedBox()),
            Container(
              height: 9.h,
              width: 100.w,
              alignment: Alignment.center,
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: AppColor.accentTorquise,
                    fontSize: 15.sp,
                    fontFamily: FontFamily.maloryLight,
                    fontWeight: FontWeight.w400),
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(
              height: 1.5.h,
            )
          ],
        ),
      ),
    );
  }

  static showShortCutButtonsForAndroid(
      {required BottomNavigationController controller,
      required BuildContext context}) {
    Get.bottomSheet(Container(
      height: 25.h,
      width: 100.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              await controller.getUsersTeam();
              Get.back();
              showAddNewProject(controller: controller, context: context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  SvgPicture.asset(
                    CustomIcons.projects,
                    color: AppColor.black,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Create project",
                    style: TextStyle(
                      fontFamily: FontFamily.maloryBold,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColor.darkBlue,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: () {
              // Get.back();
              // Get.to(() => CameraProductScreenView(), arguments: {
              //   "isFromHomescreen": true,
              //   "projectID": "",
              //   "projectName": "",
              //   "groupID": ""
              // });
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.addwithborder,
                  color: AppColor.darkBlue,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "New product",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.darkBlue,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: () {
              Get.back();
              Get.to(() => CameraIdeaScreenView(), arguments: {
                "isSavetoMyIdeas": false,
                "isFromHomescreen": true,
                "projectID": "",
                "projectName": "",
                "groupID": ""
              });
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  SvgPicture.asset(
                    CustomIcons.addwithborder,
                    color: AppColor.black,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "New idea",
                    style: TextStyle(
                      fontFamily: FontFamily.maloryBold,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColor.darkBlue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
