import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../../bottom_navigation_screen/controller/bottomnav_controller.dart';
import '../controller/my_ideas_controller.dart';
import '../model/my_ideas_model.dart';
import 'package:bordered_text/bordered_text.dart';

class MyIdeasShareIdeas extends GetView<MyIdeasController> {
  const MyIdeasShareIdeas(
      {required this.ideasGroupOrUngroup, required this.groupID, super.key});
  final List<MyIdeasModel> ideasGroupOrUngroup;
  final String groupID;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              height: 7.h,
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 22.w,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.maloryLight,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Share ideas",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.maloryBold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    width: 22.w,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 3.w,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w),
              height: 12.h,
              width: 100.w,
              child: ListView.builder(
                itemCount: ideasGroupOrUngroup.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  if (ideasGroupOrUngroup[index].isGroup == true) {
                    return Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Container(
                        height: 12.h,
                        width: 25.w,
                        alignment: Alignment.center,
                        decoration:
                            ideasGroupOrUngroup[index].groupIdeaImage.length ==
                                    0
                                ? null
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: AppColor.greyBlue, width: 1.sp),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppEndpoint.endPointFile +
                                                "/" +
                                                ideasGroupOrUngroup[index]
                                                    .groupIdeaImage[0]
                                                    .fileImage))),
                        child: BorderedText(
                          strokeWidth: 4.0,
                          strokeColor: AppColor.black,
                          child: Text(
                            ideasGroupOrUngroup[index].groupIdeaImage.length ==
                                    0
                                ? "0 Ideas"
                                : "+" +
                                    (ideasGroupOrUngroup[index]
                                                .groupIdeaImage
                                                .length -
                                            1)
                                        .toString(),
                            style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.sp,
                              fontFamily: FontFamily.maloryBold,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Container(
                        height: 12.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColor.greyBlue, width: 1.sp),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(AppEndpoint.endPointFile +
                                    "/" +
                                    ideasGroupOrUngroup[index].ideaFileImage))),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: 100.w,
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.maloryBold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              height: 6.5.h,
              width: 100.w,
              child: TextField(
                controller: controller.emailAddress,
                obscureText: false,
                style: TextStyle(
                  color: AppColor.darkBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  fontFamily: FontFamily.maloryLight,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: .5.h, bottom: .5.h, left: 4.w),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.accentTorquise),
                      borderRadius: BorderRadius.circular(8)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.accentTorquise),
                      borderRadius: BorderRadius.circular(8)),
                  hintText: "Enter email address",
                  hintStyle: TextStyle(
                      color: AppColor.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: FontFamily.maloryLight),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: 100.w,
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "Or choose team",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.maloryBold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount:
                    Get.find<BottomNavigationController>().usersTeamList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              CustomIcons.team,
                              color: AppColor.darkBlue,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              Get.find<BottomNavigationController>()
                                  .usersTeamList[index]
                                  .name,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.maloryBold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            for (var element
                                in Get.find<BottomNavigationController>()
                                    .usersTeamList) {
                              if (Get.find<BottomNavigationController>()
                                      .usersTeamList[index]
                                      .id ==
                                  element.id) {
                                if (element.isSelected.value == false) {
                                  element.isSelected.value = true;
                                } else {
                                  element.isSelected.value = false;
                                }
                              } else {
                                element.isSelected.value = false;
                              }
                            }
                          },
                          child: Obx(
                            () => Get.find<BottomNavigationController>()
                                        .usersTeamList[index]
                                        .isSelected
                                        .value ==
                                    true
                                ? SvgPicture.asset(
                                    CustomIcons.radiobuttonactive,
                                    color: AppColor.darkBlue,
                                  )
                                : SvgPicture.asset(
                                    CustomIcons.radiobutton,
                                    color: AppColor.darkBlue,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ))
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: InkWell(
            onTap: () async {
              String teamID = "";
              String emailAddress = "";
              List ideaIDList = [];
              List groupIDList = [];
              for (var element
                  in Get.find<BottomNavigationController>().usersTeamList) {
                if (element.isSelected.value == true) {
                  teamID = element.id;
                }
              }
              if (controller.emailAddress.text.isEmpty) {
                emailAddress = "";
              } else {
                emailAddress = controller.emailAddress.text;
              }
              for (var element in ideasGroupOrUngroup) {
                if (element.isGroup == true) {
                  groupIDList.add(element.groupIdOrIdeaId);
                } else {
                  ideaIDList.add(element.groupIdOrIdeaId);
                }
              }
              if (ideaIDList.length == 0) {
                controller.shareGroup(
                    groupIdList: groupIDList,
                    email: emailAddress,
                    teamID: teamID);
              } else {
                controller.shareIdeas(
                    ideasIdList: ideaIDList,
                    email: emailAddress,
                    teamID: teamID);
              }
            },
            child: Container(
                alignment: Alignment.center,
                height: 6.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Share",
                  style: TextStyle(
                      fontFamily: FontFamily.maloryBold,
                      color: AppColor.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp),
                )),
          ),
        ),
      ),
    );
  }
}
