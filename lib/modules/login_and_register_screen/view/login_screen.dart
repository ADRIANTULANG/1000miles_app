import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/icons_class.dart';
import '../controller/login_and_register_screen_controller.dart';

class LoginScreenView extends GetView<LoginRegisterController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                width: 100.w,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email address",
                  style: TextStyle(
                      fontFamily: FontFamily.maloryBold,
                      color: AppColor.darkBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                )),
            SizedBox(
              height: 1.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              height: 6.5.h,
              width: 100.w,
              child: Obx(
                () => TextField(
                  controller: controller.email,
                  obscureText: false,
                  style: TextStyle(
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: FontFamily.maloryLight,
                  ),
                  onChanged: ((value) {
                    if (value.isEmpty) {
                      controller.isLogiUsernameEmpty.value = true;
                    } else {
                      controller.isLogiUsernameEmpty.value = false;
                    }
                  }),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: .5.h, bottom: .5.h, left: 4.w),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: controller.isLogiUsernameEmpty.value == true
                                ? 2
                                : 2,
                            color: controller.isLogiUsernameEmpty.value == true
                                ? AppColor.grey
                                : AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Your registered email',
                    hintStyle: TextStyle(
                        color: AppColor.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryLight),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                width: 100.w,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                      fontFamily: FontFamily.maloryLight,
                      color: controller.isSignInSelected.value == true
                          ? Colors.black
                          : Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                )),
            SizedBox(
              height: 1.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              height: 6.5.h,
              width: 100.w,
              child: Obx(
                () => TextField(
                  controller: controller.password,
                  obscureText: controller.isObscurePassword.value,
                  obscuringCharacter: '●',
                  onTap: () {
                    controller.isPasswordCorrect.value = "true";
                  },
                  style: TextStyle(
                      color: controller.isObscurePassword.value == true
                          ? controller.isPasswordCorrect.value == "false"
                              ? AppColor.redAccent
                              : AppColor.blueAccent
                          : AppColor.darkBlue,
                      fontSize: 14.sp,
                      fontFamily: FontFamily.maloryLight,
                      letterSpacing:
                          controller.isObscurePassword.value == true ? 3 : 0),
                  onChanged: ((value) {
                    if (value.isEmpty) {
                      controller.isLoginPasswordEmpty.value = true;
                    } else {
                      controller.isLoginPasswordEmpty.value = false;
                    }
                    controller.isPasswordCorrect.value = "true";
                  }),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: .5.h, bottom: .5.h, left: 4.w),
                    suffixIcon: InkWell(
                        onTap: () {
                          if (controller.isObscurePassword.value == true) {
                            controller.isObscurePassword.value = false;
                          } else {
                            controller.isObscurePassword.value = true;
                          }
                        },
                        child:
                            Obx(() => controller.isObscurePassword.value == true
                                ? Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: AppColor.grey,
                                  )
                                : Icon(
                                    Icons.remove_red_eye,
                                    color: AppColor.grey,
                                  ))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: controller.isLoginPasswordEmpty.value == true
                                ? 2
                                : 2,
                            color: controller.isPasswordCorrect.value == "" ||
                                    controller.isPasswordCorrect.value == "true"
                                ? controller.isLoginPasswordEmpty.value == true
                                    ? AppColor.grey
                                    : AppColor.accentTorquise
                                : AppColor.redAccent),
                        borderRadius: BorderRadius.circular(8)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: controller.isPasswordCorrect.value == "false"
                                ? AppColor.redAccent
                                : AppColor.accentTorquise),
                        borderRadius: BorderRadius.circular(8)),
                    hintText: 'Your password',
                    hintStyle: TextStyle(
                        color: AppColor.grey,
                        letterSpacing: 0,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryLight),
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.isPasswordCorrect.value == "false"
                  ? Container(
                      padding: EdgeInsets.only(left: 7.w, right: 5.w, top: 1.h),
                      width: 100.w,
                      child: Text(
                        "Wrong password. Please try another or check if it matches email.",
                        style: TextStyle(
                            fontFamily: FontFamily.maloryLight,
                            color: AppColor.redAccent,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp),
                      ),
                    )
                  : SizedBox(),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              alignment: Alignment.centerLeft,
              child: Text(
                "Forgot password?",
                style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.sp),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Obx(
              () => controller.isGettingCredentials.value == false
                  ? Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: InkWell(
                        onTap: () async {
                          controller.isSigninPress.value = true;
                          controller.isGettingCredentials(true);
                          if (controller.email.text.isEmpty ||
                              controller.password.text.isEmpty) {
                            // Get.to(() => BottomNavigationBarView());
                            Future.delayed(Duration(milliseconds: 600), () {
                              controller.isGettingCredentials(false);
                              controller.isSigninPress.value = false;
                            });
                            print("age dre");
                          } else {
                            await controller.login();
                            FocusScope.of(context).unfocus();
                          }
                        },
                        child: Obx(
                          () => Container(
                            height: 7.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: AppColor.darkBlue,
                              borderRadius: BorderRadius.circular(8),
                              border: controller.isSigninPress.value == true
                                  ? Border.all(
                                      color: AppColor.accentTorquise2, width: 2)
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontFamily: "Mallory",
                                    fontSize: 14.sp,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                SvgPicture.asset(
                                  CustomIcons.arrowright,
                                  color: AppColor.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Obx(
                        () => Container(
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(8),
                            border: controller.isSigninPress.value == true
                                ? Border.all(
                                    color: AppColor.accentTorquise2, width: 2)
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Center(
                            child: Lottie.asset(
                                "assets/loading/buttonloading.json"),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
