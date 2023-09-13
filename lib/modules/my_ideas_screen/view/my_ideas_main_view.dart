import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../services/storage_services.dart';
import '../../account_screen/view/accounts_view.dart';
import '../controller/my_ideas_controller.dart';
import '../widget/my_ideas_archived.dart';
import '../widget/my_ideas_recently_viewed.dart';
import '../widget/my_ideas_shared_with_me.dart';

class MyIdeasMainView extends GetView<MyIdeasController> {
  const MyIdeasMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.white,
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            Container(
              height: 9.h,
              width: 100.w,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: InkWell(
                        onTap: () {
                          // controller.getProjects();
                          Get.to(() => AccountScreen());
                        },
                        child: CircleAvatar(
                          radius: 6.w,
                          backgroundColor: AppColor.white,
                          child: CircleAvatar(
                            backgroundColor: AppColor.accentTorquise,
                            radius: 5.5.w,
                            child: Text(
                              Get.find<StorageServices>()
                                  .storage
                                  .read("email")[0]
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              style: TextStyle(
                                fontFamily: FontFamily.maloryBold,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                  Entry.all(
                    duration: Duration(milliseconds: 350),
                    child: Container(
                      padding: EdgeInsets.only(left: 2.w),
                      alignment: Platform.isIOS
                          ? Alignment.center
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: Text(
                          "Ideas",
                          style: TextStyle(
                              fontSize: 15.sp,
                              letterSpacing: .5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                    border: controller.scrollPosition_recently_viewed.value ==
                                0.0 &&
                            controller.scrollPosition_archived.value == 0.0 &&
                            controller.scrollPosition_shared.value == 0.0
                        ? Border(
                            bottom: BorderSide(
                            color: AppColor.white,
                            width: 0.5,
                          ))
                        : Border(
                            bottom: BorderSide(
                            color: AppColor.greyBlue,
                            width: 0.5,
                          ))),
                child: Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 1.h),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.carouselController.jumpToPage(0);
                          controller.scrollPosition_recently_viewed.value = 0.0;
                          controller.scrollPosition_archived.value = 0.0;
                          controller.scrollPosition_shared.value = 0.0;
                        },
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            height: 3.5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: controller.selectedIndex.value == 0
                                    ? AppColor.accentLightblue
                                    : AppColor.white),
                            padding: EdgeInsets.only(left: 3.w, right: 3.w),
                            child: Text(
                              "Recently updated",
                              style: TextStyle(
                                  color: controller.selectedIndex.value == 0
                                      ? AppColor.darkBlue
                                      : AppColor.grey,
                                  fontFamily: FontFamily.maloryLight,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.carouselController.jumpToPage(1);
                          controller.scrollPosition_recently_viewed.value = 0.0;
                          controller.scrollPosition_archived.value = 0.0;
                          controller.scrollPosition_shared.value = 0.0;
                        },
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            height: 3.5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: controller.selectedIndex.value == 1
                                    ? AppColor.accentLightblue
                                    : AppColor.white),
                            padding: EdgeInsets.only(left: 3.w, right: 3.w),
                            child: Text(
                              "Shared",
                              style: TextStyle(
                                  color: controller.selectedIndex.value == 1
                                      ? AppColor.darkBlue
                                      : AppColor.grey,
                                  fontFamily: FontFamily.maloryLight,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.carouselController.jumpToPage(2);
                          controller.scrollPosition_recently_viewed.value = 0.0;
                          controller.scrollPosition_archived.value = 0.0;
                          controller.scrollPosition_shared.value = 0.0;
                        },
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            height: 3.5.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: controller.selectedIndex.value == 2
                                    ? AppColor.accentLightblue
                                    : AppColor.white),
                            padding: EdgeInsets.only(left: 3.w, right: 3.w),
                            child: Text(
                              "Archived",
                              style: TextStyle(
                                  color: controller.selectedIndex.value == 2
                                      ? AppColor.darkBlue
                                      : AppColor.grey,
                                  fontFamily: FontFamily.maloryLight,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: CarouselSlider(
                  carouselController: controller.carouselController,
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      controller.selectedIndex.value = index;
                      controller.scrollPosition_recently_viewed.value = 0.0;
                      controller.scrollPosition_archived.value = 0.0;
                      controller.scrollPosition_shared.value = 0.0;
                    },
                    height: 100.h,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    // autoPlay: false,
                  ),
                  items: [
                    MyIdeasRecentlyViewed(),
                    MyIdeasSharedWithMe(),
                    MyIdeasArchived(),
                  ]
                      .map(
                        (view) => view,
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
