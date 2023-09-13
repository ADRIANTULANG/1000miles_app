// import 'dart:io';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/constant/icons_class.dart';
// import '../../add_product_screen/view/add_product_view.dart';
// import '../../google_sign_in_screen/view/google_sign_in_screen_view.dart';
import '../../add_product_screen/view/add_product_view.dart';
import '../bottomsheet/bottom_navigation_bottomsheets.dart';
import '../controller/bottomnav_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarView extends GetView<BottomNavigationController> {
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationController());

    return Obx(
      () => controller.isLoading.value == true
          ? Scaffold(
              drawerEnableOpenDragGesture: false,
              body: Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 25.w, right: 25.w, bottom: 15.h),
                  child: Lottie.asset("assets/loading/animation.json"),
                ),
              ),
            )
          : SafeArea(
              child: Scaffold(
                drawerEnableOpenDragGesture: false,
                drawer: Drawer(
                    backgroundColor: Colors.white,
                    child: ListView(
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                              child:
                                  Image.asset("assets/images/splashlogo.png")),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(Icons.list),
                          title: Text('My List'),
                        ),
                        ListTile(
                          onTap: () {
                            // Get.to(() => MsSignInPage(
                            //       title: "Azure AD",
                            //     ));
                          },
                          leading: Icon(Icons.info),
                          title: Text('Request'),
                        ),
                        ListTile(
                          onTap: () {
                            Get.back();
                            Get.to(() => AddProductsView());
                          },
                          leading: Icon(Icons.qr_code),
                          title: Text('My QR code'),
                        ),
                      ],
                    )),
                body: Obx(() => Container(
                    child: controller.views
                        .elementAt(controller.currentIndex.value))),
                bottomNavigationBar: Container(
                  width: 100.w,
                  height: 7.h,
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //     spreadRadius: .1,
                      //     blurRadius: 8,
                      //     color: Color.fromARGB(255, 223, 218, 218),
                      //     offset: Offset(0, -3),
                      //   )
                      // ],
                      border: Border(
                          top: BorderSide(
                              color: AppColor.greyBlue, width: 0.2.w)),
                      color: Colors.white),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.currentIndex.value = 0;
                          },
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                width: 1.w,
                                color: controller.currentIndex.value == 0
                                    ? AppColor.accentTorquise
                                    : Colors.white,
                              ))),
                              height: 7.h,
                              width: 20.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    CustomIcons.projects,
                                    color: AppColor.black,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Projects",
                                    style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontFamily: FontFamily.maloryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.currentIndex.value = 1;
                          },
                          child: Obx(
                            () => Container(
                              height: 7.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                width: 1.w,
                                color: controller.currentIndex.value == 1
                                    ? AppColor.accentTorquise
                                    : Colors.white,
                              ))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    CustomIcons.addimages,
                                    color: AppColor.darkBlue,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Ideas",
                                    style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontFamily: FontFamily.maloryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // controller.currentIndex.value = 2;
                          },
                          child: Obx(
                            () => Container(
                              height: 7.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                width: 1.w,
                                color: controller.currentIndex.value == 2
                                    ? AppColor.accentTorquise
                                    : Colors.white,
                              ))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    CustomIcons.feed,
                                    color: AppColor.darkBlue,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Feed",
                                    style: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontFamily: FontFamily.maloryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Obx(
                            () => Container(
                              height: 7.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                width: 1.w,
                                color: controller.currentIndex.value == 3
                                    ? AppColor.accentTorquise
                                    : Colors.white,
                              ))),
                            ),
                          ),
                        ),
                      ]),
                ),
                floatingActionButton: Entry.scale(
                  duration: Duration(milliseconds: 800),
                  child: Showcase.withWidget(
                    onTargetClick: () {
                      print("close");
                    },
                    disposeOnTap: true,
                    height: 15.h,
                    width: 80.w,
                    key: controller.floatingButtonKey,
                    targetShapeBorder: CircleBorder(),
                    container: Padding(
                      padding: EdgeInsets.only(right: 5.w, top: 2.h),
                      child: Column(
                        children: [
                          Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Container(
                                    width: 80.w,
                                    padding: EdgeInsets.only(right: 3.5.w),
                                    alignment: Alignment.centerRight,
                                    child: SvgPicture.asset(
                                      CustomIcons.clear,
                                      color: AppColor.darkBlue,
                                    ),
                                  ),
                                  Container(
                                      width: 80.w,
                                      height: 20.h,
                                      child: Image.asset(
                                          "assets/images/onboarding.gif")),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                    width: 80.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 3.w),
                                      child: Text(
                                        "Start a project",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.sp,
                                            color: AppColor.darkBlue,
                                            fontFamily: FontFamily.maloryBold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    width: 80.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 3.w),
                                      child: Text(
                                        "Time to get creative. Press the shortcut",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: AppColor.darkBlue,
                                            fontFamily: FontFamily.maloryLight),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 3.w),
                                      child: Text(
                                        "plus button and select 'Create project''",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: AppColor.darkBlue,
                                            fontFamily: FontFamily.maloryLight),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            height: 2.h,
                            width: 80.w,
                            padding: EdgeInsets.only(left: 60.w),
                            child: SvgPicture.asset(
                              CustomIcons.arrowpointer,
                              color: AppColor.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    child: Container(
                      height: 7.h,
                      width: 7.h,
                      child: FloatingActionButton(
                        backgroundColor: AppColor.accentTorquise,
                        onPressed: () {
                          controller.tagValues.value = "";
                          controller.isFocusProjectTag.value = true;

                          controller.isEnableContinueButton.value = false;
                          controller.projectname.clear();
                          controller.projecttags.clear();
                          for (var i = 0;
                              i < controller.usersTeamList.length;
                              i++) {
                            controller.usersTeamList[i].isSelected.value =
                                false;
                          }
                          // if (Platform.isIOS) {
                          //   BottomNavigationBottomSheet
                          //       .showShortCutButtonsForIos(
                          //           context: context, controller: controller);
                          // } else {
                          BottomNavigationBottomSheet
                              .showShortCutButtonsForAndroid(
                                  context: context, controller: controller);
                          // }
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
              ),
            ),
    );
  }
}
