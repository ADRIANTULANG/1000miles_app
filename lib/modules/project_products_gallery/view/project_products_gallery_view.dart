import 'dart:io';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/modules/project_products_gallery/widgets/grouped_products.dart';
import 'package:yoooto/modules/project_products_gallery/widgets/ungrouped_products.dart';
import '../../../constant/icons_class.dart';
import '../bottomsheets/projects_products_gallery_bottomsheets.dart';
import '../controller/project_products_gallery_controller.dart';

class ProjectProductsGalleryView
    extends GetView<ProjectProductsGalleryController> {
  const ProjectProductsGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectProductsGalleryController());
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
          : Scaffold(
              body: SafeArea(
                child: Container(
                  color: Colors.white,
                  height: 100.h,
                  width: 100.w,
                  child: Column(
                    children: [
                      Obx(
                        () => Container(
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: controller.scrollPosition.value == 0.0
                                ? null
                                : Border(
                                    bottom:
                                        BorderSide(color: AppColor.greyBlue)),
                            // boxShadow: controller.scrollPosition.value == 0.0
                            //     ? []
                            //     : [
                            //         BoxShadow(
                            //           spreadRadius: .1,
                            //           blurRadius: 5,
                            //           color: Color.fromARGB(255, 218, 214, 214),
                            //           offset: Offset(0, 3),
                            //         )
                            //       ],
                          ),
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Obx(
                                  () => Container(
                                    width:
                                        controller.scrollPosition.value == 0.0
                                            ? 50.w
                                            : 32.w,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Platform.isIOS
                                            ? SvgPicture.asset(
                                                CustomIcons.arrowbackios,
                                                height: 2.h,
                                              )
                                            : SvgPicture.asset(
                                                CustomIcons.arrowback,
                                                height: 2.h,
                                              ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Obx(
                                          () => controller
                                                      .scrollPosition.value ==
                                                  0.0
                                              ? Entry.scale(
                                                  child: Obx(
                                                    () => Text(
                                                      controller
                                                          .projectName.value,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontFamily: FontFamily
                                                              .maloryLight,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => controller.scrollPosition.value != 0.0
                                    ? Entry.all(
                                        child: Text(
                                          "Products",
                                          style: TextStyle(
                                              fontFamily: FontFamily.maloryBold,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    : SizedBox(),
                              ),
                              InkWell(
                                onTap: () {
                                  ProjectsProductsGalleryBottomsheets
                                      .showEditBottomSheets(
                                          controller: controller);
                                },
                                child: Container(
                                  width: 32.w,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.black,
                                        fontFamily: FontFamily.maloryLight,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => controller.scrollPosition.value == 0.0
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5.w),
                                    width: 100.w,
                                    alignment: Alignment.centerLeft,
                                    child: Entry.offset(
                                      xOffset: -1000,
                                      yOffset: 0,
                                      child: Text(
                                        "Products",
                                        style: TextStyle(
                                            fontFamily: FontFamily.maloryBold,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Obx(
                            () => controller.productsAndGroupsList.length == 0
                                ? Container(
                                    height: 100.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          CustomIcons.addwithborderbig,
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Text(
                                          "Let's add content to your",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.maloryLight,
                                              fontSize: 14.sp,
                                              color: AppColor.greyBlue,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "project via tool below",
                                          style: TextStyle(
                                              fontFamily:
                                                  FontFamily.maloryLight,
                                              fontSize: 14.sp,
                                              color: AppColor.greyBlue,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                      ],
                                    ),
                                  )
                                : Obx(
                                    () => ListView.builder(
                                      controller: controller.scrollController,
                                      itemCount: controller
                                          .productsAndGroupsList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                            child: controller
                                                        .productsAndGroupsList[
                                                            index]
                                                        .isGroup ==
                                                    true
                                                ? GroupedProducts(index: index)
                                                : UngroupedProdcuts(
                                                    index: index));
                                      },
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: 7.h,
                width: 100.w,
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: AppColor.greyBlue))
                    // boxShadow: [
                    //   BoxShadow(
                    //     spreadRadius: .1,
                    //     blurRadius: 5,
                    //     color: Color.fromARGB(255, 218, 214, 214),
                    //     offset: Offset(0, -3),
                    //   )
                    // ],
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20.w,
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        CustomIcons.threelinesmalltobig,
                        color: AppColor.white,
                      ),
                    ),
                    Obx(
                      () => controller.productsAndGroupsList.length == 0
                          ? Text(
                              "No assets available",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  letterSpacing: .1,
                                  color: AppColor.greyBlue,
                                  fontWeight: FontWeight.w400),
                            )
                          : SizedBox(),
                    ),
                    InkWell(
                      onTap: () {
                        ProjectsProductsGalleryBottomsheets.showShortButtons(
                            controller: controller);
                      },
                      child: Container(
                        width: 20.w,
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          CustomIcons.addnew,
                          color: AppColor.darkBlue,
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
