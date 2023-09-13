import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../controller/save_idea_and_details_controller.dart';

class AddDetailsScreen extends GetView<SaveIdeaAndDetailsController> {
  const AddDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Text(
              "Add details",
              style: TextStyle(
                  color: AppColor.darkBlue,
                  fontFamily: FontFamily.maloryBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Text(
              controller.imagesList.length == 1
                  ? "Name new idea (Optional)"
                  : "Name new ideas (Optional)",
              style: TextStyle(
                  fontFamily: FontFamily.maloryBold,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Expanded(
            child: controller.imagesList.length == 1
                ? Container(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    height: 7.h,
                    child: TextField(
                      controller: controller.forSingleImage,
                      obscureText: false,
                      onChanged: (value) {
                        controller.imagesList[0].imageTitle = value;
                      },
                      style: TextStyle(
                        color: AppColor.darkBlue,
                        fontFamily: FontFamily.maloryLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.accentTorquise, width: .5.w),
                            borderRadius: BorderRadius.circular(6)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.greyBlue, width: .5.w),
                            borderRadius: BorderRadius.circular(6)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.greyBlue, width: .5.w),
                            borderRadius: BorderRadius.circular(6)),
                        hintText: 'Enter idea name',
                        hintStyle: TextStyle(
                          color: AppColor.greyBlue,
                          fontFamily: FontFamily.maloryLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: ListView.builder(
                      itemCount: controller.imagesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        controller.textEditingController
                            .add(new TextEditingController());
                        return Padding(
                          padding: EdgeInsets.only(bottom: 1.5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 14.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColor.greyBlue),
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(File(controller
                                            .imagesList[index].path)))),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: Container(
                                  height: 7.h,
                                  child: TextField(
                                    controller:
                                        controller.textEditingController[index],
                                    obscureText: false,
                                    onChanged: (value) {
                                      controller.imagesList[index].imageTitle =
                                          value;
                                    },
                                    style: TextStyle(
                                      color: AppColor.darkBlue,
                                      fontFamily: FontFamily.maloryLight,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.accentTorquise,
                                              width: .5.w),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.greyBlue,
                                              width: .5.w),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.greyBlue,
                                              width: .5.w),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      hintText: 'Enter idea name',
                                      hintStyle: TextStyle(
                                        color: AppColor.greyBlue,
                                        fontFamily: FontFamily.maloryLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Obx(
              () => controller.isCreatingIdea.value == false
                  ? InkWell(
                      onTap: () async {
                        controller.isCreatingIdea(true);
                        if (controller.isSavetoMyIdeas.value == false) {
                          if (controller.isFromHomescreen.value == true) {
                            if (controller.isSavetoNewProject.value == true) {
                              await controller
                                  .createProjectFirstBeforeCreatingIdea();
                              print(
                                  "MAG CREATE DAAN UG PROJECT AYHA MAG SAVE SA IDEAS");
                            } else {
                              await controller.uploadIdeaImageFromHomeScreen();
                              print("EH SAVE GIKAN SA HOME SCREEN");
                            }
                          } else {
                            if (controller.groupID.value != "") {
                              controller
                                  .uploadIdeaImageFromIdeaScreen_but_fromGroupFolder();
                              print("EH SAVE NIYA GIKAN SA GROUP IDEA SCREEN");
                            } else {
                              print("EH SAVE NIYA GIKAN SA IDEA SCREEN");
                              await controller.uploadIdeaImageFromIdeaScreen();
                            }
                          }
                        } else {
                          controller.saveToMyIdeas();
                          print("EH SAVE NIYA SA MYIDEAS");
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Save idea",
                            style: TextStyle(
                                fontFamily: FontFamily.maloryBold,
                                color: AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp),
                          )),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 7.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:
                            Lottie.asset("assets/loading/buttonloading.json"),
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
