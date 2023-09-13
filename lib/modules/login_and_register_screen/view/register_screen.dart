import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/login_and_register_screen_controller.dart';
import '../dialogs/login_and_register_dialog_screen.dart';

class RegisterView extends GetView<LoginRegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              width: 100.w,
              alignment: Alignment.centerLeft,
              child: Text(
                "Your name",
                style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.bold,
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
                controller: controller.register_name,
                obscureText: false,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.maloryLight,
                  color: AppColor.darkBlue,
                  fontSize: 14.sp,
                ),
                onChanged: ((value) {
                  if (value.isEmpty) {
                    controller.isYournameTextEmpty.value = true;
                  } else {
                    controller.isYournameTextEmpty.value = false;
                  }
                }),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: .5.h, bottom: .5.h, left: 4.w),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: controller.isYournameTextEmpty.value == true
                              ? 2
                              : 2,
                          color: controller.isYournameTextEmpty.value == true
                              ? AppColor.grey
                              : AppColor.accentTorquise),
                      borderRadius: BorderRadius.circular(8)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.accentTorquise),
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Please provide your full name',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey,
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
                "Company name",
                style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.bold,
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
                controller: controller.register_company,
                obscureText: false,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.maloryLight,
                  color: AppColor.darkBlue,
                  fontSize: 14.sp,
                ),
                onChanged: ((value) {
                  if (value.isEmpty) {
                    controller.isCompanyTextEmpty.value = true;
                  } else {
                    controller.isCompanyTextEmpty.value = false;
                  }
                }),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: .5.h, bottom: .5.h, left: 4.w),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: controller.isCompanyTextEmpty.value == true
                              ? 2
                              : 2,
                          color: controller.isCompanyTextEmpty.value == true
                              ? AppColor.grey
                              : AppColor.accentTorquise),
                      borderRadius: BorderRadius.circular(8)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.accentTorquise),
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Company name (optional)',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey,
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
                "Email address",
                style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.bold,
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
                controller: controller.register_email,
                obscureText: false,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.maloryLight,
                  color: AppColor.darkBlue,
                  fontSize: 14.sp,
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    controller.isEmailAddressTextEmpty.value = true;
                  } else {
                    controller.isEmailAddressTextEmpty.value = false;
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: .5.h, bottom: .5.h, left: 4.w),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width:
                              controller.isEmailAddressTextEmpty.value == true
                                  ? 2
                                  : 2,
                          color:
                              controller.isEmailAddressTextEmpty.value == true
                                  ? AppColor.grey
                                  : AppColor.accentTorquise),
                      borderRadius: BorderRadius.circular(8)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.accentTorquise),
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Valid company email',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey,
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
                    fontFamily: FontFamily.maloryBold,
                    color: AppColor.darkBlue,
                    fontWeight: FontWeight.bold,
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
                controller: controller.register_password,
                obscureText: controller.isObscurePassword.value,
                obscuringCharacter: '●',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.maloryLight,
                  color: controller.isObscurePassword.value == true
                      ? controller.eightcharactersLong.value == "true" &&
                              controller.hasCapitalLetter.value == "true" &&
                              controller.hasNumber.value == "true"
                          ? AppColor.blueAccent
                          : AppColor.redAccent
                      : AppColor.darkBlue,
                  letterSpacing:
                      controller.isObscurePassword.value == true ? 3 : 0,
                  fontSize: 14.sp,
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    controller.isPasswordTextEmpty.value = true;
                  } else {
                    controller.isPasswordTextEmpty.value = false;
                  }
                  controller.checkIfContains(
                      password: controller.register_password.text);
                },
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
                                  color: AppColor.greyBlue,
                                )
                              : Icon(
                                  Icons.remove_red_eye,
                                  color: AppColor.greyBlue,
                                ))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: controller.isPasswordTextEmpty.value == true
                            ? 2
                            : 2,
                        color: AppColor.grey,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: controller.eightcharactersLong.value == "true" &&
                                controller.hasCapitalLetter.value == "true" &&
                                controller.hasNumber.value == "true"
                            ? AppColor.accentTorquise
                            : controller.isPasswordTextEmpty.value == true
                                ? AppColor.accentTorquise
                                : AppColor.redAccent,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: controller.eightcharactersLong.value == "true" &&
                                controller.hasCapitalLetter.value == "true" &&
                                controller.hasNumber.value == "true"
                            ? AppColor.accentTorquise
                            : AppColor.redAccent,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Your password',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey,
                      letterSpacing: 0,
                      fontSize: 14.sp,
                      fontFamily: FontFamily.maloryLight),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (controller.showPasswordInstructions.value == false) {
                      controller.showPasswordInstructions.value = true;
                    } else {
                      controller.showPasswordInstructions.value = false;
                    }
                  },
                  child: SvgPicture.asset(
                    CustomIcons.information,
                    color: AppColor.accentTorquise,
                  ),
                ),
                Obx(
                  () => Container(
                    width: 19.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: controller.hasCapitalLetter.value == "true" ||
                                controller.hasNumber.value == "true" ||
                                controller.eightcharactersLong.value == "true"
                            ? controller.eightcharactersLong.value == "true" &&
                                    controller.hasCapitalLetter.value ==
                                        "true" &&
                                    controller.hasNumber.value == "true"
                                ? AppColor.accentTorquise
                                : AppColor.redAccent
                            : AppColor.paleBlue),
                  ),
                ),
                Obx(
                  () => Container(
                    width: 19.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: (controller.hasCapitalLetter.value == "true" &&
                                    controller.hasNumber.value == "true") ||
                                (controller.eightcharactersLong.value ==
                                        "true" &&
                                    controller.hasNumber.value == "true") ||
                                (controller.eightcharactersLong.value ==
                                        "true" &&
                                    controller.hasCapitalLetter.value == "true")
                            ? controller.eightcharactersLong.value == "true" &&
                                    controller.hasCapitalLetter.value ==
                                        "true" &&
                                    controller.hasNumber.value == "true"
                                ? AppColor.accentTorquise
                                : AppColor.redAccent
                            : AppColor.paleBlue),
                  ),
                ),
                Obx(
                  () => Container(
                    width: 19.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: controller.eightcharactersLong.value == "true" &&
                                controller.hasCapitalLetter.value == "true" &&
                                controller.hasNumber.value == "true"
                            ? AppColor.accentTorquise
                            : AppColor.paleBlue),
                  ),
                ),
                Obx(
                  () => Container(
                    width: 19.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: controller.eightcharactersLong.value == "true" &&
                                controller.hasCapitalLetter.value == "true" &&
                                controller.hasNumber.value == "true"
                            ? AppColor.accentTorquise
                            : AppColor.paleBlue),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => controller.showPasswordInstructions.value == false
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => SvgPicture.asset(
                                CustomIcons.check,
                                color: controller.eightcharactersLong.value ==
                                        "true"
                                    ? AppColor.accentTorquise
                                    : AppColor.greyBlue,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text("8 characters minimum"),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => SvgPicture.asset(
                                CustomIcons.check,
                                color:
                                    controller.hasCapitalLetter.value == "true"
                                        ? AppColor.accentTorquise
                                        : AppColor.greyBlue,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text("1 capital letter"),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Obx(
                              () => SvgPicture.asset(
                                CustomIcons.check,
                                color: controller.hasNumber.value == "true"
                                    ? AppColor.accentTorquise
                                    : AppColor.greyBlue,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text("1 number"),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => controller.isGettingCredentials.value == false
                ? Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: InkWell(
                      onTap: () async {
                        controller.isSignupPress(true);
                        await controller.checkIfContains(
                            password: controller.register_password.text);
                        if (controller.eightcharactersLong.value == "false" ||
                            controller.hasCapitalLetter.value == "false" ||
                            controller.hasNumber.value == "false" ||
                            controller.eightcharactersLong.value == "" ||
                            controller.hasCapitalLetter.value == "" ||
                            controller.hasNumber.value == "") {
                        } else {
                          LoginRegisterDialog.showDialogForReviewTerms(
                              controller: controller);
                        }
                        Future.delayed(Duration(milliseconds: 600), () {
                          controller.isSignupPress(false);
                        });
                      },
                      child: Obx(
                        () => Container(
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor.darkBlue,
                            borderRadius: BorderRadius.circular(8),
                            border: controller.isSignupPress.value == true
                                ? Border.all(
                                    color: AppColor.accentTorquise2, width: 2)
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: FontFamily.maloryBold,
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
                          color: AppColor.darkBlue,
                          borderRadius: BorderRadius.circular(8),
                          border: controller.isSignupPress.value == true
                              ? Border.all(
                                  color: AppColor.accentTorquise2, width: 2)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child:
                              Lottie.asset("assets/loading/buttonloading.json"),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
