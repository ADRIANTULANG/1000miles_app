import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../controller/login_and_register_screen_controller.dart';
import 'main_screen.dart';

class PreLoginView extends GetView<LoginRegisterController> {
  const PreLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginRegisterController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 30.h,
              width: 100.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image:
                          AssetImage("assets/images/splashscreentoobig.png"))),
            ),
            SizedBox(
              height: 2.h,
            ),
            Image.asset("assets/images/1.5x.png"),
            Image.asset("assets/images/barries.png"),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              child: InkWell(
                onTap: () async {
                  controller.isSigninPress_preScreen(true);
                  controller.indexSelected.value = 0;
                  controller.initialPage.value = await 0;
                  controller.isSignInSelected.value = await true;
                  controller.isSignUpSelected.value = await false;
                  Get.to(() => LoginRegisterScreenView());
                  // controller.navigateTo(index: 0);
                  Future.delayed(Duration(milliseconds: 600), () {
                    controller.isSigninPress_preScreen(false);
                  });
                },
                child: Obx(
                  () => Container(
                    height: 8.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColor.darkBlue,
                      borderRadius: BorderRadius.circular(13),
                      border: controller.isSigninPress_preScreen.value == true
                          ? Border.all(
                              color: AppColor.accentTorquise2, width: 2)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontSize: 14.sp,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              child: InkWell(
                onTap: () async {
                  controller.isSignupPress_preScreen(true);
                  controller.indexSelected.value = 1;
                  controller.initialPage.value = await 1;
                  controller.isSignInSelected.value = await false;
                  controller.isSignUpSelected.value = await true;
                  Get.to(() => LoginRegisterScreenView());
                  Future.delayed(Duration(milliseconds: 600), () {
                    controller.isSignupPress_preScreen(false);
                  });
                  // controller.navigateTo(index: 1);
                },
                child: Obx(
                  () => Container(
                    height: 8.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      border: controller.isSignupPress_preScreen.value == true
                          ? Border.all(
                              color: AppColor.accentTorquise2, width: 2)
                          : Border.all(width: 2, color: AppColor.greyBlue),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: FontFamily.maloryBold,
                        color: AppColor.darkBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
