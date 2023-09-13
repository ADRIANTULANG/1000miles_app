import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/save_idea_and_details_controller.dart';

class SaveIdeaAndDetailsView extends GetView<SaveIdeaAndDetailsController> {
  const SaveIdeaAndDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SaveIdeaAndDetailsController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (controller.isFromHomescreen.value == false) {
            return true;
          } else {
            if (controller.selectedIndex.value == 0) {
              return true;
            } else {
              controller.carouselController.previousPage();
              return false;
            }
          }
        },
        child: SafeArea(
            child: Container(
          child: Column(children: [
            Container(
              height: 7.h,
              width: 100.w,
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (controller.isFromHomescreen.value == false) {
                        Get.back();
                      } else {
                        if (controller.selectedIndex.value == 1) {
                          controller.carouselController.previousPage();
                        } else {
                          Get.back();
                        }
                      }
                    },
                    child: Container(
                      width: 20.w,
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        CustomIcons.arrowbackios,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.isFromHomescreen.value == false
                        ? SizedBox()
                        : Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 4.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => controller.selectedIndex.value == 0
                                        ? SvgPicture.asset(
                                            CustomIcons.dotblue,
                                          )
                                        : SvgPicture.asset(
                                            CustomIcons.dotblack,
                                          ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Obx(
                                    () => controller.selectedIndex.value == 1
                                        ? SvgPicture.asset(
                                            CustomIcons.dotblue,
                                          )
                                        : SvgPicture.asset(
                                            CustomIcons.dotblack,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  Obx(
                    () => controller.selectedIndex.value == 1
                        ? Obx(
                            () => controller.isCreatingIdea.value == false
                                ? InkWell(
                                    onTap: () async {
                                      controller.isCreatingIdea(true);
                                      if (controller.isFromHomescreen.value ==
                                          true) {
                                        if (controller
                                                .isSavetoNewProject.value ==
                                            true) {
                                          await controller
                                              .createProjectFirstBeforeCreatingIdea();
                                        } else {
                                          await controller
                                              .uploadIdeaImageFromHomeScreen();
                                        }
                                      } else {
                                        if (controller.groupID.value != "") {
                                          controller
                                              .uploadIdeaImageFromIdeaScreen_but_fromGroupFolder();
                                        } else {
                                          await controller
                                              .uploadIdeaImageFromIdeaScreen();
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 20.w,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                          fontFamily: FontFamily.maloryBold,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 20.w,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        fontFamily: FontFamily.maloryBold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                          )
                        : InkWell(
                            onTap: () {
                              if (controller.isSaveTo.value == "") {
                              } else {
                                controller.carouselController.nextPage();
                              }
                            },
                            child: Container(
                              width: 20.w,
                              alignment: Alignment.centerRight,
                              child: Obx(
                                () => Text(
                                  "Next",
                                  style: TextStyle(
                                    color: controller.isSaveTo.value == ""
                                        ? AppColor.greyBlue
                                        : AppColor.darkBlue,
                                    fontFamily: FontFamily.maloryBold,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: Obx(
                () => CarouselSlider(
                  carouselController: controller.carouselController,
                  options: CarouselOptions(
                    initialPage: controller.initialPage.value,
                    enableInfiniteScroll: false,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index, reason) {
                      controller.selectedIndex.value = index;
                    },
                    height: 100.h,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    // autoPlay: false,
                  ),
                  items: List.generate(controller.screen.length, (index) {
                    return controller.screen[index];
                  }),
                ),
              ),
            ))
          ]),
        )),
      ),
    );
  }
}
