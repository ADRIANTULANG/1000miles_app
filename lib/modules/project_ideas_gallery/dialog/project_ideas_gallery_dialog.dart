import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../controller/project_ideas_gallery_controller.dart';
import '../model/project_gallery_display_group_items_model.dart';

class ProjectIdeaGalleryDialog {
  static showEditGroupName(
      {required String groupname,
      required String groupID,
      required ProjectIdeasGalleryController controller}) {
    TextEditingController groupnameEditor = TextEditingController();
    groupnameEditor.text = groupname;
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.white,
        contentPadding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.h),
        content: Container(
          height: 25.h,
          width: 90.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rename group",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColor.darkBlue,
                    fontSize: 18.sp,
                    fontFamily: FontFamily.maloryBold),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 6.5.h,
                width: 100.w,
                child: TextField(
                  controller: groupnameEditor,
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
                        borderSide: BorderSide(
                            width: 2, color: AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
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
              InkWell(
                onTap: () {
                  Get.back();

                  controller.renameGroupName(
                      groupIdea: groupID, newname: groupnameEditor.text);
                },
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.only(right: 3.w),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Rename",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor.accentTorquise,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryBold),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.only(right: 3.w),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor.darkBlue,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryBold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showArchiveDialog(
      {required ProjectIdeasGalleryController controller,
      required String isIdeaOrGroup}) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.white,
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        content: Container(
          height: 25.h,
          width: 90.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Archive ideas",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.maloryBold,
                    color: AppColor.darkBlue,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Are you sure you want to archive",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey,
                    fontFamily: FontFamily.maloryLight,
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: .5.h,
              ),
              Text(
                "selected items",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey,
                    fontFamily: FontFamily.maloryLight,
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  if (isIdeaOrGroup == "ideas") {
                    controller.archivedIdeas();
                  } else {
                    controller.archivedGroupIdeas();
                  }
                },
                child: Container(
                  width: 100.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "ARCHIVE",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.maloryBold,
                        color: AppColor.accentTorquise,
                        fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 100.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.maloryBold,
                        color: AppColor.darkBlue,
                        fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showArchivedIdeaFromGroup(
      {required ProjectIdeasGalleryController controller,
      required RxList<ProjectDisplayGroupItemsModel> data,
      required String groupID}) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.white,
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        content: Container(
          height: 25.h,
          width: 90.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Archive ideas",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.maloryBold,
                    color: AppColor.darkBlue,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Are you sure you want to archive",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey,
                    fontFamily: FontFamily.maloryLight,
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: .5.h,
              ),
              Text(
                "selected items",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey,
                    fontFamily: FontFamily.maloryLight,
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  controller.archiveIdeasFromGroup(
                      list: data, groupID: groupID);
                },
                child: Container(
                  width: 100.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "ARCHIVE",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.maloryBold,
                        color: AppColor.accentTorquise,
                        fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 100.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.maloryBold,
                        color: AppColor.darkBlue,
                        fontSize: 14.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showLoadingScreen() {
    Get.dialog(
        AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 30.h),
          contentPadding: EdgeInsets.zero,
          content: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Container(
              height: 12.h,
              width: 12.h,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.accentTorquise,
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  static showCreateBoard_Projects(
      {required ProjectIdeasGalleryController controller,
      required String projectID}) {
    TextEditingController groupnameEditor = TextEditingController();
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.white,
        contentPadding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.h),
        content: Container(
          height: 25.h,
          width: 90.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create board",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColor.darkBlue,
                    fontSize: 18.sp,
                    fontFamily: FontFamily.maloryBold),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 6.5.h,
                width: 100.w,
                child: TextField(
                  controller: groupnameEditor,
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
                        borderSide: BorderSide(
                            width: 2, color: AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
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
              InkWell(
                onTap: () {
                  Get.back();
                  controller.createNewBoardFromMoveOrCopyScreen(
                      projectID: projectID, projectName: groupnameEditor.text);
                },
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.only(right: 3.w),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Create",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor.accentTorquise,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryBold),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.only(right: 3.w),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColor.darkBlue,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryBold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showDeleteDialog({
    required ProjectIdeasGalleryController controller,
    required List listOfBoardId,
    required List listOfIdeaID,
    required String groupID,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.white,
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        content: Container(
          height: 25.h,
          width: 90.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delete ideas",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.maloryBold,
                    color: AppColor.darkBlue,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Are you sure you want to delete",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey,
                    fontFamily: FontFamily.maloryLight,
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: .5.h,
              ),
              Text(
                "selected items",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey,
                    fontFamily: FontFamily.maloryLight,
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  controller.deleteGroup(
                      groupID: groupID,
                      ideaIdList: listOfIdeaID,
                      groupIdList: listOfBoardId);
                },
                child: Container(
                  width: 100.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "DELETE",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.maloryBold,
                        color: AppColor.accentTorquise,
                        fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 100.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.maloryBold,
                        color: AppColor.darkBlue,
                        fontSize: 14.sp),
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
