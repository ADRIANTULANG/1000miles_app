import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../controller/account_controller.dart';

class AccountScreenDialog {
  static showAccountScreenSignoutDialogForIos(
      {required AccountScreenScreenController controller}) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 18.h,
          width: 80.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13), color: Colors.white),
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Sign out",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Are you sure you want to sign out? You\nwill be returned to the sign-in screen.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Divider(
                height: 0.1.h,
                color: Color.fromARGB(255, 192, 189, 189),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColor.accentTorquise,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Color.fromARGB(255, 192, 189, 189),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          controller.logoutUser();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Sign-out",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColor.accentTorquise,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static showAccountScreenSignoutDialogForAndroid(
      {required AccountScreenScreenController controller}) {
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
              "Sign out",
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
              "Are you sure you want to sign out? You will be returned to the sign-in screen.",
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
                        color: AppColor.accentTorquise,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    controller.logoutUser();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Sign-out",
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
