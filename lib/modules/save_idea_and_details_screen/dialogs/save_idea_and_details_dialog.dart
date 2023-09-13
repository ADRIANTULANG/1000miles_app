import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../controller/save_idea_and_details_controller.dart';

class SaveIdeaDialog {
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

  static showCreateBoard_My_Ideas(
      {required SaveIdeaAndDetailsController controller}) {
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
      {required SaveIdeaAndDetailsController controller,
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
