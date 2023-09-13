import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../controller/idea_details_controller.dart';

class MyIdeasDialog {
  static showEditIdeaName(
      {required String ideaname, required IdeaDetailController controller}) {
    TextEditingController ideanameEditor = TextEditingController();
    ideanameEditor.text = ideaname;
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
                "Rename idea",
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
                  controller: ideanameEditor,
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

                  controller.renameIdea(label: ideanameEditor.text);
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

  static showDeleteConfirmation(
      {required String ideaname, required IdeaDetailController controller}) {
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
              "Delete",
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
              "Are you sure you want to delete this idea? This idea will be permanently remove.",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: FontFamily.maloryLight,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: AppColor.grey),
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
                        color: AppColor.darkBlue,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Get.back();
                    controller.deleteIdea();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w500,
                        color: AppColor.redAccent,
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
