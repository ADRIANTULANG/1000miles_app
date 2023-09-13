import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../controller/my_ideas_controller.dart';

class MyIdeasAlertDialog {
  static showArchivedIdeaAlertDialog(
      {required MyIdeasController controller,
      required List ideastoarchive,
      required List grouptoarchive,
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
                  Get.back();
                  controller.archivedMyIdeas(
                      groupIDtoArchive: grouptoarchive,
                      groupID: groupID,
                      ideasImagesToArchived: ideastoarchive);
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

  static showEditGroupName(
      {required String groupname,
      required String groupID,
      required MyIdeasController controller}) {
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
                  controller.renameGroup(
                      groupID: groupID, groupName: groupnameEditor.text);
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

  static showCreateBoard({required MyIdeasController controller}) {
    TextEditingController boardname = TextEditingController();
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
                  controller: boardname,
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
                  List ideaIdList = [];
                  for (var i = 0; i < controller.ideas_List.length; i++) {
                    if (controller.ideas_List[i].isSelected.value == true) {
                      ideaIdList.add(controller.ideas_List[i].ideaId);
                    }
                  }
                  controller.createBoardWithIdeas(
                      boardName: boardname.text, imageIdList: ideaIdList);
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
    required MyIdeasController controller,
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

  static showCreateBoard_My_Ideas({required MyIdeasController controller}) {
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
                  controller.createBoards_My_ideas(
                      boardname: groupnameEditor.text);
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

  static showCreateBoard_Projects(
      {required MyIdeasController controller, required String projectID}) {
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
                  controller.createBoards_projects(
                      boardname: groupnameEditor.text, projectID: projectID);
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
}
