import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/project_space_controller.dart';
import '../widget/project_space_draggable_view.dart';
import '../widget/project_space_not_draggable_view.dart';

class ProjectSpaceView extends GetView<ProjectSpaceController> {
  const ProjectSpaceView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectSpaceController());
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
                backgroundColor: Color.fromARGB(255, 230, 235, 234),
                body: Container(
                  height: 100.h,
                  width: 100.w,
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 6.5.h,
                        width: 100.w,
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: 30.w,
                                child: Platform.isIOS
                                    ? Text(
                                        "All projects",
                                        style: TextStyle(
                                            fontFamily: FontFamily.maloryLight,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                      )
                                    : SvgPicture.asset(
                                        CustomIcons.arrowback,
                                        color: AppColor.black,
                                      ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.isEditing.value == true) {
                                  controller.isEditing.value = false;
                                } else {
                                  controller.isEditing.value = true;
                                }
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 30.w,
                                child: Obx(
                                  () => Text(
                                    controller.isEditing.value == true
                                        ? "Done"
                                        : "Edit",
                                    style: controller.isEditing.value == true
                                        ? TextStyle(
                                            fontFamily: FontFamily.maloryBold,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp)
                                        : TextStyle(
                                            fontFamily: FontFamily.maloryLight,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Obx(
                        () => Text(
                          controller.projectName.value == ""
                              ? "Unnamed project"
                              : controller.projectName.value.capitalizeFirst
                                  .toString(),
                          style: TextStyle(
                              fontFamily: FontFamily.maloryBold,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Obx(() => controller.isEditing.value == true
                          ? ProjectSpaceDraggableView()
                          : ProjectSpaceNotDraggableView())
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
