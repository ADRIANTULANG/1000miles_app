import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/modules/login_and_register_screen/controller/login_and_register_screen_controller.dart';

import 'login_screen.dart';
import 'register_screen.dart';
// import 'package:get/get.dart';

class LoginRegisterScreenView extends GetView<LoginRegisterController> {
  const LoginRegisterScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      height: 15.h,
                      width: 100.w,
                      child: Image.asset("assets/images/1.5x.png")),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.carouselController.jumpToPage(0);
                          },
                          child: Obx(
                            () => Container(
                                alignment: Alignment.center,
                                height: 4.h,
                                width: 44.w,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: .5.w,
                                            color: controller
                                                        .indexSelected.value ==
                                                    0
                                                ? AppColor.darkBlue
                                                : AppColor.grey))),
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: controller.indexSelected.value == 0
                                          ? AppColor.darkBlue
                                          : AppColor.grey,
                                      fontFamily: FontFamily.maloryBold,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.carouselController.jumpToPage(1);
                          },
                          child: Obx(
                            () => Container(
                                alignment: Alignment.center,
                                height: 4.h,
                                width: 44.w,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: .5.w,
                                            color: controller
                                                        .indexSelected.value ==
                                                    1
                                                ? AppColor.darkBlue
                                                : AppColor.grey))),
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: FontFamily.maloryBold,
                                      color: controller.indexSelected.value == 1
                                          ? AppColor.darkBlue
                                          : AppColor.grey,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Obx(
                    () => CarouselSlider(
                      carouselController: controller.carouselController,
                      options: CarouselOptions(
                        initialPage: controller.initialPage.value,
                        onPageChanged: (index, reason) {
                          controller.indexSelected.value = index;
                          if (controller.indexSelected.value == 0) {
                            controller.showPasswordInstructions.value = false;
                          }
                        },
                        height:
                            controller.showPasswordInstructions.value == false
                                ? 74.h
                                : 80.h,

                        enableInfiniteScroll: false,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        // autoPlay: false,
                      ),
                      items: [LoginScreenView(), RegisterView()],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
