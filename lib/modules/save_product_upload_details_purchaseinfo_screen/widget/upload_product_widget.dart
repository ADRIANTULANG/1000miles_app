import 'dart:io';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/icons_class.dart';
import '../controller/save_product_upload_details_purchaseinfo_controller.dart';

class UploadProductWidget
    extends GetView<ProductUploadDetailsPurchaseInfoController> {
  const UploadProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Entry.all(
            child: Text(
              "Upload products",
              style: TextStyle(
                fontFamily: FontFamily.maloryBold,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            height: 12.h,
            width: 100.w,
            child: Obx(
              () => ListView.builder(
                itemCount: controller.final_selected_images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 1.w, left: 1.w),
                    child: Container(
                      height: 12.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColor.greyBlue, width: .3.w),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(controller
                                  .final_selected_images[index].path)))),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Save to new project",
                  style: TextStyle(
                      fontFamily: FontFamily.maloryBold,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                ),
                InkWell(
                  onTap: () {
                    if (controller.isCreateToNewProject.value == true) {
                      controller.isCreateToNewProject.value = false;
                    } else {
                      controller.isCreateToNewProject.value = true;
                    }
                    controller.projectID.value = "";
                    controller.groupID.value = "";
                    controller.uncheckAll();
                  },
                  child: Obx(
                    () => controller.isCreateToNewProject.value == true
                        ? SvgPicture.asset(
                            CustomIcons.radiobuttonactive,
                            color: AppColor.black,
                          )
                        : SvgPicture.asset(
                            CustomIcons.radiobutton,
                            color: AppColor.black,
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select current project",
                  style: TextStyle(
                      fontFamily: FontFamily.maloryBold,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                ),
                SvgPicture.asset(
                  CustomIcons.search,
                  color: AppColor.black,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Expanded(
            child: Container(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: controller.projects_and_groups_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 0.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (controller
                                            .projects_and_groups_list[index]
                                            .showGroup
                                            .value ==
                                        true) {
                                      controller.projects_and_groups_list[index]
                                          .showGroup.value = false;
                                    } else {
                                      controller.projects_and_groups_list[index]
                                          .showGroup.value = true;
                                    }
                                  },
                                  child: Text(
                                    controller.projects_and_groups_list[index]
                                                .name ==
                                            ""
                                        ? "Unnamed"
                                        : controller
                                            .projects_and_groups_list[index]
                                            .name
                                            .capitalizeFirst
                                            .toString(),
                                    style: TextStyle(
                                        fontFamily: FontFamily.maloryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.isCreateToNewProject.value =
                                        false;
                                    if (controller
                                            .projects_and_groups_list[index]
                                            .isSelected
                                            .value ==
                                        true) {
                                      controller.projects_and_groups_list[index]
                                          .isSelected.value = false;
                                      controller.uncheckAll();
                                      // SET PROJECT ID TO DEFAULT
                                      controller.projectID.value = "";
                                      // =========================
                                      // SET GROUP ID TO DEFAULT
                                      controller.groupID.value = "";
                                      // ==========================
                                    } else {
                                      controller.projects_and_groups_list[index]
                                          .isSelected.value = true;
                                      controller
                                          .checkSelectedProjectAndUncheckUnselected(
                                              id: controller
                                                  .projects_and_groups_list[
                                                      index]
                                                  .id);
                                      //  SET PROJECT ID
                                      controller.projectID.value = controller
                                          .projects_and_groups_list[index].id
                                          .toString();
                                      // ===============
                                      // SET GROUP ID TO DEFAULT
                                      controller.groupID.value = "";
                                      // ==========================
                                    }
                                  },
                                  child: Obx(
                                    () => controller
                                                .projects_and_groups_list[index]
                                                .isSelected
                                                .value ==
                                            true
                                        ? SvgPicture.asset(
                                            CustomIcons.radiobuttonactive,
                                            color: AppColor.black,
                                          )
                                        : SvgPicture.asset(
                                            CustomIcons.radiobutton,
                                            color: AppColor.black,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Obx(
                            () => controller.projects_and_groups_list[index]
                                        .showGroup.value ==
                                    false
                                ? SizedBox()
                                : Container(
                                    child: ListView.builder(
                                      itemCount: controller
                                          .projects_and_groups_list[index]
                                          .groups
                                          .length,
                                      // itemCount: 3,
                                      padding: EdgeInsets.all(0),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context,
                                          int groupindex) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 1.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.w),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          CustomIcons.folder,
                                                          color: AppColor.black,
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Text(
                                                          controller
                                                              .projects_and_groups_list[
                                                                  index]
                                                              .groups[
                                                                  groupindex]
                                                              .name
                                                              .capitalizeFirst
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  FontFamily
                                                                      .maloryLight,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .isCreateToNewProject
                                                          .value = false;
                                                      if (controller
                                                              .projects_and_groups_list[
                                                                  index]
                                                              .groups[
                                                                  groupindex]
                                                              .isSelected
                                                              .value ==
                                                          true) {
                                                        controller
                                                            .projects_and_groups_list[
                                                                index]
                                                            .groups[groupindex]
                                                            .isSelected
                                                            .value = false;
                                                        controller.uncheckAll();
                                                        // SET PROJECT ID TO DEFAULT
                                                        controller.projectID
                                                            .value = "";
                                                        // ========================
                                                        //SET PROJECT ID TO DEFAULT
                                                        controller
                                                            .groupID.value = "";
                                                        // ========================
                                                      } else {
                                                        controller
                                                            .projects_and_groups_list[
                                                                index]
                                                            .groups[groupindex]
                                                            .isSelected
                                                            .value = true;
                                                        // SET GROUP ID
                                                        controller
                                                                .groupID.value =
                                                            controller
                                                                .projects_and_groups_list[
                                                                    index]
                                                                .groups[
                                                                    groupindex]
                                                                .id
                                                                .toString();
                                                        // =================
                                                        // SET PROJECT ID
                                                        controller.projectID
                                                                .value =
                                                            controller
                                                                .projects_and_groups_list[
                                                                    index]
                                                                .id
                                                                .toString();
                                                        // ==================================
                                                      }
                                                    },
                                                    child: Obx(
                                                      () => controller
                                                                  .projects_and_groups_list[
                                                                      index]
                                                                  .isSelected
                                                                  .value ==
                                                              true
                                                          ? SvgPicture.asset(
                                                              CustomIcons
                                                                  .radiobuttonactive,
                                                              color: AppColor
                                                                  .black,
                                                            )
                                                          : SvgPicture.asset(
                                                              CustomIcons
                                                                  .radiobutton,
                                                              color: AppColor
                                                                  .black,
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Divider(
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.carouselController.nextPage();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Container(
                height: 6.5.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(
                          fontFamily: FontFamily.maloryLight,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 20.sp,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }
}
