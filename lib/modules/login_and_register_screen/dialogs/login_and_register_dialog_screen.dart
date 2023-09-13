import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';

import '../controller/login_and_register_screen_controller.dart';

class LoginRegisterDialog {
  static showDialogForReviewTerms(
      {required LoginRegisterController controller}) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.all(4.w),
        content: Container(
          height: 25.h,
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: Text(
                  "Please review our Terms",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (controller.isCheckValue.value == true) {
                        controller.isCheckValue.value = false;
                      } else {
                        controller.isCheckValue.value = true;
                      }
                    },
                    child: Obx(() => controller.isCheckValue.value == false
                        ? Icon(Icons.check_box_outline_blank)
                        : Icon(
                            Icons.check_box,
                            color: AppColor.blueAccent,
                          )),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "I agree to yoooto Terms and Privacy Policy",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 8.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Obx(
                () => controller.isCreatingAccount.value == false
                    ? InkWell(
                        onTap: () {
                          controller.registerToGetOtp();
                        },
                        child: Container(
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(color: Colors.black54),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 7.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(8),
                          // border: Border.all(color: Colors.black54),
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child:
                              Lottie.asset("assets/loading/buttonloading.json"),
                        ),
                      ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Changed your mind?",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 8.sp),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    "Retrun to Homepage",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 8.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
