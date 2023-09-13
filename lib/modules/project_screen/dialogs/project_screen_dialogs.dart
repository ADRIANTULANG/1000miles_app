import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/icons_class.dart';
import '../controller/projects_controller.dart';

class ProjectScreenDialogs {
  static showEditProjectScreen(
      {required ProjectsScreenController controller,
      required String projectname,
      required String projectid,
      required BuildContext context}) async {
    controller.newProjectName.text = projectname.capitalizeFirst.toString();
    controller.newDescription.clear();
    controller.newTags.clear();
    controller.tagValues.value = "";
    controller.isFocusTag.value = true;
    controller.newImagePath.value = "";
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
      titlePadding:
          EdgeInsets.only(bottom: 2.h, top: 2.h, left: 5.w, right: 5.w),
      title: Text(
        "Edit project details",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColor.darkBlue,
            fontFamily: FontFamily.maloryBold,
            fontSize: 18.sp),
      ),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColor.darkBlue,
          fontFamily: FontFamily.maloryBold,
          fontSize: 18.sp),
      content: Container(
        height: 60.h,
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DottedBorder(
                color: AppColor.grey,
                strokeCap: StrokeCap.round,
                dashPattern: [2, 2, 2, 2],
                strokeWidth: 1,
                child: InkWell(
                  onTap: () {
                    controller.selectImage();
                  },
                  child: Obx(
                    () => controller.newImagePath.value == ""
                        ? Container(
                            height: 15.h,
                            width: 100.w,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              CustomIcons.addnew,
                              color: AppColor.grey,
                            ),
                          )
                        : Container(
                            height: 15.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                        File(controller.newImagePath.value)))),
                            alignment: Alignment.center,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 6.5.h,
                width: 100.w,
                child: TextField(
                  controller: controller.newProjectName,
                  obscureText: false,
                  style: TextStyle(
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: FontFamily.maloryLight,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: .5.h, bottom: .5.h, left: 4.w),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: AppColor.grey),
                        borderRadius: BorderRadius.circular(8)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Enter name here',
                    hintStyle: TextStyle(
                        color: AppColor.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryLight),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 12.h,
                width: 100.w,
                child: TextField(
                  controller: controller.newDescription,
                  obscureText: false,
                  maxLines: 10,
                  style: TextStyle(
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: FontFamily.maloryLight,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 2.h, bottom: .5.h, left: 4.w),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: AppColor.grey),
                        borderRadius: BorderRadius.circular(8)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Short description',
                    hintStyle: TextStyle(
                        color: AppColor.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryLight),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(
                () => controller.isFocusTag.value == true
                    ? Container(
                        height: 6.5.h,
                        width: 100.w,
                        child: TextField(
                          // expands: true,
                          // maxLines: null,
                          // minLines: null,
                          obscureText: false,
                          controller: controller.newTags,
                          focusNode: controller.projectTagFocusNode,
                          onChanged: (value) {
                            if (controller.debounce?.isActive ?? false)
                              controller.debounce!.cancel();
                            controller.debounce =
                                Timer(const Duration(milliseconds: 1000), () {
                              controller.tagsMaker(
                                  text: controller.newTags.text);
                              controller.projectTagFocusNode.unfocus();
                              controller.isFocusTag.value = false;
                            });
                          },
                          style: TextStyle(
                              color: AppColor.black,
                              fontFamily: FontFamily.maloryLight,
                              fontSize: 13.sp),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 1.h, bottom: 1.h, left: 3.w),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: AppColor.grey),
                                borderRadius: BorderRadius.circular(8)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: AppColor.grey),
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Enter tags, comma separated',
                            hintStyle: TextStyle(
                                color: AppColor.grey,
                                fontFamily: FontFamily.maloryLight,
                                fontSize: 13.sp),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          controller.isFocusTag.value = true;
                          controller.projectTagFocusNode.requestFocus();
                          print("here");
                        },
                        child: Container(
                          height: 6.5.h,
                          width: 100.w,
                          padding: EdgeInsets.only(
                              top: 1.65.h, bottom: 1.h, left: 2.4.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(width: 2, color: AppColor.grey)),
                          child: Obx(
                            () => controller.tagValues.value == ""
                                ? Text(
                                    'Enter tags, comma separated',
                                    style: TextStyle(
                                        color: AppColor.grey,
                                        fontFamily: FontFamily.maloryLight,
                                        fontSize: 13.sp),
                                  )
                                : Text(
                                    controller.tagValues.value,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColor.accentTorquise,
                                        fontFamily: FontFamily.maloryLight,
                                        fontSize: 13.sp),
                                  ),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                    controller.updateProjectDetails(
                        projectID: projectid,
                        projectname: controller.newProjectName.text);
                  },
                  child: Container(
                    height: 6.5.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.darkBlue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          CustomIcons.check,
                          color: AppColor.white,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "Save changes",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                            color: AppColor.white,
                            fontFamily: FontFamily.maloryBold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  static showDialogDeleteProject(
      {required String projectID,
      required ProjectsScreenController controller,
      required String projectname}) {
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 24.h,
        width: 80.w,
        padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 1.h,
            ),
            Text(
              "Delete project",
              style: TextStyle(
                  fontFamily: FontFamily.maloryBold,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColor.darkBlue),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "Are you sure you want to permanently remove project",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: FontFamily.maloryLight,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: AppColor.grey),
            ),
            Text(
              '${projectname.capitalizeFirst.toString()} ?',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: FontFamily.maloryBold,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: AppColor.darkBlue),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w500,
                        color: AppColor.accentTorquise,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    controller.deleteProject(projectID: projectID);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w500,
                        color: AppColor.accentTorquise,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
