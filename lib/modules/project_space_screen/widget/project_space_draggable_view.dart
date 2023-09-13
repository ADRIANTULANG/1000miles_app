import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/project_space_controller.dart';

class ProjectSpaceDraggableView extends GetView<ProjectSpaceController> {
  const ProjectSpaceDraggableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 100.w,
        child: Theme(
          data: ThemeData(
            canvasColor: Color.fromARGB(255, 230, 235, 234),
            shadowColor: Color.fromARGB(255, 230, 235, 234),
            dialogBackgroundColor: Color.fromARGB(255, 230, 235, 234),
            backgroundColor: Color.fromARGB(255, 230, 235, 234),
          ),
          child: Obx(
            () => ReorderableListView.builder(
              itemCount: controller.projectOptions.length,
              onReorderStart: (int) {
                HapticFeedback.heavyImpact();
                print("dragging $int");
                controller.projectOptions[int].paddingValue.value = 0;
              },
              onReorderEnd: (int) {
                for (var i = 0; i < controller.projectOptions.length; i++) {
                  controller.projectOptions[i].paddingValue.value = 1;
                }
                print("stop dragging at ${int - 1}");
              },
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex--;
                final newitem = controller.projectOptions.removeAt(oldIndex);
                controller.projectOptions.insert(newIndex, newitem);
              },
              itemBuilder: (BuildContext context, index) {
                return Container(
                  key: ValueKey(index),
                  child: Obx(
                    () => Padding(
                      padding: EdgeInsets.only(
                          top: controller
                              .projectOptions[index].paddingValue.value.h,
                          bottom: controller
                              .projectOptions[index].paddingValue.value.h),
                      child: Container(
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
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColor.greyBlue, width: .2.w)),
                        child: Row(
                          children: [
                            Container(
                              height: 15.h,
                              width: 75.w,
                              padding: EdgeInsets.only(left: 5.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      controller.projectOptions[index].icon ==
                                              "Products"
                                          ? SvgPicture.asset(
                                              CustomIcons.box,
                                              color: AppColor.black,
                                            )
                                          : controller.projectOptions[index]
                                                      .icon ==
                                                  "Moodboard"
                                              ? SvgPicture.asset(
                                                  CustomIcons.moodboard,
                                                  color: AppColor.black,
                                                )
                                              : controller.projectOptions[index]
                                                          .icon ==
                                                      "Ideas"
                                                  ? SvgPicture.asset(
                                                      CustomIcons.addimages,
                                                      color: AppColor.black,
                                                    )
                                                  : SvgPicture.asset(
                                                      CustomIcons.truck,
                                                      color: AppColor.black,
                                                    ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        controller
                                            .projectOptions[index].optionName,
                                        style: TextStyle(
                                            fontFamily: FontFamily.maloryLight,
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
                                            fontFamily: FontFamily.maloryLight,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 14.w,
                              height: 15.h,
                              alignment: Alignment.center,
                              child: Container(
                                height: 2.h,
                                child: Entry.offset(
                                  xOffset: 1000,
                                  yOffset: 0,
                                  child: SvgPicture.asset(
                                    CustomIcons.threebar,
                                    color: Color.fromARGB(255, 199, 197, 197),
                                    height: 2.h,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
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
