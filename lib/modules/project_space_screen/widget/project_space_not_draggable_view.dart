import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../../project_ideas_gallery/view/project_ideas_gallery_view.dart';
import '../../project_products_gallery/view/project_products_gallery_view.dart';
import '../controller/project_space_controller.dart';

class ProjectSpaceNotDraggableView extends GetView<ProjectSpaceController> {
  const ProjectSpaceNotDraggableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 100.w,
        child: Theme(
          data: ThemeData(
            canvasColor: Colors.transparent,
            shadowColor: Colors.transparent,
            dialogBackgroundColor: Colors.transparent,
          ),
          child: Obx(
            () => ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: controller.projectOptions.length,
              itemBuilder: (BuildContext context, index) {
                return controller.projectOptions[index].optionName == "Ideas"
                    ? Padding(
                        key: ValueKey(index),
                        padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                        child: Showcase.withWidget(
                          height: 20.h,
                          width: 90.w,
                          key: controller.ideaButtonShowcase,
                          disposeOnTap: true,
                          container: Padding(
                            padding: EdgeInsets.only(right: 2.w, top: 2.h),
                            child: Column(
                              children: [
                                Container(
                                  height: 2.h,
                                  width: 90.w,
                                  child: SvgPicture.asset(
                                    CustomIcons.arrowpointerup,
                                    color: AppColor.white,
                                  ),
                                ),
                                Container(
                                  height: 20.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        width: 90.w,
                                        padding: EdgeInsets.only(right: 4.w),
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                          CustomIcons.clear,
                                          color: AppColor.darkBlue,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Container(
                                        width: 90.w,
                                        padding: EdgeInsets.only(left: 4.w),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Build idea collection",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                              color: AppColor.darkBlue,
                                              fontFamily:
                                                  FontFamily.maloryBold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        width: 90.w,
                                        padding: EdgeInsets.only(left: 4.w),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Start your project with collecting \nsome inspiration",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: AppColor.darkBlue,
                                              fontFamily:
                                                  FontFamily.maloryLight),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 1.5,
                                      blurRadius: 8,
                                      color: AppColor.boxShadow,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: controller.projectOptions[index]
                                                  .isPress.value ==
                                              true
                                          ? AppColor.accentTorquise
                                          : AppColor.greyBlue,
                                      width: controller.projectOptions[index]
                                                  .isPress.value ==
                                              true
                                          ? 2
                                          : .2.w)),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.projectOptions[index].isPress
                                          .value = true;
                                      Future.delayed(
                                          Duration(milliseconds: 300), () {
                                        if (controller.projectOptions[index]
                                                .optionName ==
                                            "Products") {
                                          Get.to(
                                              () =>
                                                  ProjectProductsGalleryView(),
                                              arguments: {
                                                "projectID":
                                                    controller.projectID.value,
                                                "projectName": controller
                                                    .projectName.value,
                                              });
                                        } else if (controller
                                                .projectOptions[index]
                                                .optionName ==
                                            "Ideas") {
                                          Get.to(
                                              () => ProjectIdeasGalleryView(),
                                              arguments: {
                                                "projectID":
                                                    controller.projectID.value,
                                                "projectName": controller
                                                    .projectName.value,
                                              });
                                        }
                                        controller.projectOptions[index].isPress
                                            .value = false;
                                      });
                                    },
                                    child: Container(
                                      height: 15.h,
                                      width: 74.w,
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              controller.projectOptions[index]
                                                          .icon ==
                                                      "Products"
                                                  ? SvgPicture.asset(
                                                      CustomIcons.box,
                                                      color: AppColor.black,
                                                    )
                                                  : controller
                                                              .projectOptions[
                                                                  index]
                                                              .icon ==
                                                          "Moodboard"
                                                      ? SvgPicture.asset(
                                                          CustomIcons.moodboard,
                                                          color: AppColor.black,
                                                        )
                                                      : controller
                                                                  .projectOptions[
                                                                      index]
                                                                  .icon ==
                                                              "Ideas"
                                                          ? SvgPicture.asset(
                                                              CustomIcons
                                                                  .addimages,
                                                              color: AppColor
                                                                  .black,
                                                            )
                                                          : SvgPicture.asset(
                                                              CustomIcons.truck,
                                                              color: AppColor
                                                                  .black,
                                                            ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                controller.projectOptions[index]
                                                    .optionName,
                                                style: TextStyle(
                                                    fontFamily:
                                                        FontFamily.maloryLight,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16.sp),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: .5.h,
                                          ),
                                          Row(
                                            children: [
                                              Obx(
                                                () => Text(
                                                  controller
                                                      .projectOptions[index]
                                                      .assetCount
                                                      .value
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: AppColor.greyBlue,
                                                      fontFamily: FontFamily
                                                          .maloryLight,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.sp),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                "assets",
                                                style: TextStyle(
                                                    color: AppColor.greyBlue,
                                                    fontFamily:
                                                        FontFamily.maloryLight,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 14.w,
                                    height: 15.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        key: ValueKey(index),
                        padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1.5,
                                    blurRadius: 8,
                                    color: AppColor.boxShadow,
                                    offset: Offset(0, 3),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: controller.projectOptions[index]
                                                .isPress.value ==
                                            true
                                        ? AppColor.accentTorquise
                                        : AppColor.greyBlue,
                                    width: controller.projectOptions[index]
                                                .isPress.value ==
                                            true
                                        ? 2
                                        : .2.w)),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.projectOptions[index].isPress
                                        .value = true;
                                    Future.delayed(Duration(milliseconds: 300),
                                        () {
                                      if (controller.projectOptions[index]
                                              .optionName ==
                                          "Products") {
                                        Get.to(
                                            () => ProjectProductsGalleryView(),
                                            arguments: {
                                              "projectID":
                                                  controller.projectID.value,
                                              "projectName":
                                                  controller.projectName.value,
                                            });
                                      } else if (controller
                                              .projectOptions[index]
                                              .optionName ==
                                          "Ideas") {
                                        Get.to(() => ProjectIdeasGalleryView(),
                                            arguments: {
                                              "projectID":
                                                  controller.projectID.value,
                                              "projectName":
                                                  controller.projectName.value,
                                            });
                                      }
                                      controller.projectOptions[index].isPress
                                          .value = false;
                                    });
                                  },
                                  child: Container(
                                    height: 15.h,
                                    width: 74.w,
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            controller.projectOptions[index]
                                                        .icon ==
                                                    "Products"
                                                ? SvgPicture.asset(
                                                    CustomIcons.box,
                                                    color: AppColor.black,
                                                  )
                                                : controller
                                                            .projectOptions[
                                                                index]
                                                            .icon ==
                                                        "Moodboard"
                                                    ? SvgPicture.asset(
                                                        CustomIcons.moodboard,
                                                        color: AppColor.black,
                                                      )
                                                    : controller
                                                                .projectOptions[
                                                                    index]
                                                                .icon ==
                                                            "Ideas"
                                                        ? SvgPicture.asset(
                                                            CustomIcons
                                                                .addimages,
                                                            color:
                                                                AppColor.black,
                                                          )
                                                        : SvgPicture.asset(
                                                            CustomIcons.truck,
                                                            color:
                                                                AppColor.black,
                                                          ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              controller.projectOptions[index]
                                                  .optionName,
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.maloryLight,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: .5.h,
                                        ),
                                        Row(
                                          children: [
                                            Obx(
                                              () => Text(
                                                controller.projectOptions[index]
                                                    .assetCount.value
                                                    .toString(),
                                                style: TextStyle(
                                                    color: AppColor.greyBlue,
                                                    fontFamily:
                                                        FontFamily.maloryLight,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              "assets",
                                              style: TextStyle(
                                                  color: AppColor.greyBlue,
                                                  fontFamily:
                                                      FontFamily.maloryLight,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 14.w,
                                  height: 15.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
