import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/config/endpoints.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/icons_class.dart';
import '../../project_space_screen/view/project_space_view.dart';
import '../controller/projects_controller.dart';
import '../dialogs/project_screen_dialogs.dart';

class RecentlyViewedProjects extends GetView<ProjectsScreenController> {
  const RecentlyViewedProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Obx(
        () => controller.recentlyViewedProjectList.length == 0
            ? Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      SvgPicture.asset(
                        CustomIcons.projectbigsize,
                        height: 7.5.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Discover project tools",
                        style: TextStyle(
                            fontFamily: FontFamily.maloryLight,
                            fontWeight: FontWeight.w400,
                            color: AppColor.greyBlue,
                            fontSize: 14.sp),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Text(
                        "by pressing + bellow",
                        style: TextStyle(
                            fontFamily: FontFamily.maloryLight,
                            fontWeight: FontWeight.w400,
                            color: AppColor.greyBlue,
                            fontSize: 14.sp),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        controller: controller.scrollController_recently_viewed,
                        itemCount: controller.recentlyViewedProjectList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 3.h,
                              left: 4.w,
                              top: 1.h,
                              right: 4.w,
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => ProjectSpaceView(), arguments: {
                                  'projectName': controller
                                      .recentlyViewedProjectList[index].name!,
                                  'projectID': controller
                                      .recentlyViewedProjectList[index].id!
                                      .toString()
                                });
                              },
                              child: Container(
                                height: 28.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: .5,
                                        blurRadius: 3,
                                        color: AppColor.boxShadow,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColor.greyBlue)),
                                child: Column(
                                  children: [
                                    controller.recentlyViewedProjectList[index]
                                                    .file!.file ==
                                                null ||
                                            controller
                                                    .recentlyViewedProjectList[
                                                        index]
                                                    .file!
                                                    .file ==
                                                ""
                                        ? Container(
                                            height: 20.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "assets/images/transparent.jpg"))),
                                          )
                                        : CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: AppEndpoint.endPointFile +
                                                "" +
                                                controller
                                                    .recentlyViewedProjectList[
                                                        index]
                                                    .file!
                                                    .file
                                                    .toString(),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: 20.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 20.h,
                                              width: 100.w,
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 35.w, right: 35.w),
                                                  child: Lottie.asset(
                                                      "assets/loading/animation.json"),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 20.h,
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/images/transparent.jpg"))),
                                            ),
                                          ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 2.w),
                                            width: 80.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  controller
                                                              .recentlyViewedProjectList[
                                                                  index]
                                                              .name
                                                              .toString() ==
                                                          ""
                                                      ? "Unnamed"
                                                      : controller
                                                              .recentlyViewedProjectList[
                                                                  index]
                                                              .name
                                                              .toString()
                                                              .capitalizeFirst
                                                              .toString() +
                                                          " " +
                                                          controller
                                                              .statuscode.value,
                                                  style: TextStyle(
                                                      color: AppColor.darkBlue,
                                                      fontFamily:
                                                          FontFamily.maloryBold,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  controller
                                                          .recentlyViewedProjectList[
                                                              index]
                                                          .dateWrite!
                                                          .day
                                                          .toString() +
                                                      "." +
                                                      controller
                                                          .recentlyViewedProjectList[
                                                              index]
                                                          .dateWrite!
                                                          .month
                                                          .toString() +
                                                      "." +
                                                      controller
                                                          .recentlyViewedProjectList[
                                                              index]
                                                          .dateWrite!
                                                          .year
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontFamily: FontFamily
                                                          .maloryLight,
                                                      fontSize: 10.sp,
                                                      color: AppColor.greyBlue,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: PopupMenuButton(
                                                offset: Offset(-25, 0),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: AppColor.grey,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      padding: EdgeInsets.zero,
                                                      enabled:
                                                          false, // DISABLED THIS ITEM
                                                      child: Container(
                                                        height: 17.h,
                                                        width: 35.w,
                                                        // padding:
                                                        //     EdgeInsets.only(
                                                        //         top: 2.h),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                                ProjectScreenDialogs.showEditProjectScreen(
                                                                    projectid: controller
                                                                        .recentlyViewedProjectList[
                                                                            index]
                                                                        .id!,
                                                                    projectname: controller
                                                                        .recentlyViewedProjectList[
                                                                            index]
                                                                        .name!,
                                                                    context:
                                                                        context,
                                                                    controller:
                                                                        controller);
                                                              },
                                                              child: Container(
                                                                width: 100.w,
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 5.w,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      CustomIcons
                                                                          .editwithbox,
                                                                      color: AppColor
                                                                          .darkBlue,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          3.w,
                                                                    ),
                                                                    Text(
                                                                      "Edit details",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .darkBlue,
                                                                          fontFamily: FontFamily
                                                                              .maloryBold,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                                controller.duplicateProject(
                                                                    projectID: controller
                                                                        .recentlyViewedProjectList[
                                                                            index]
                                                                        .id!);
                                                              },
                                                              child: Container(
                                                                width: 100.w,
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 5.w,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      CustomIcons
                                                                          .duplicate,
                                                                      color: AppColor
                                                                          .darkBlue,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          4.w,
                                                                    ),
                                                                    Text(
                                                                      "Duplicate",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .darkBlue,
                                                                          fontFamily: FontFamily
                                                                              .maloryBold,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                                controller.archivedProjects(
                                                                    projectID: controller
                                                                        .recentlyViewedProjectList[
                                                                            index]
                                                                        .id!);
                                                              },
                                                              child: Container(
                                                                width: 100.w,
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 5.w,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      CustomIcons
                                                                          .archived,
                                                                      color: AppColor
                                                                          .darkBlue,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          3.5.w,
                                                                    ),
                                                                    Text(
                                                                      "Archive",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .darkBlue,
                                                                          fontFamily: FontFamily
                                                                              .maloryBold,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                                ProjectScreenDialogs.showDialogDeleteProject(
                                                                    projectID: controller
                                                                        .recentlyViewedProjectList[
                                                                            index]
                                                                        .id!,
                                                                    controller:
                                                                        controller,
                                                                    projectname: controller
                                                                        .recentlyViewedProjectList[
                                                                            index]
                                                                        .name!);
                                                              },
                                                              child: Container(
                                                                width: 100.w,
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 5.w,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                      CustomIcons
                                                                          .trash,
                                                                      color: AppColor
                                                                          .darkBlue,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          4.w,
                                                                    ),
                                                                    Text(
                                                                      "Delete",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .darkBlue,
                                                                          fontFamily: FontFamily
                                                                              .maloryBold,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ];
                                                },
                                                child: SvgPicture.asset(
                                                  CustomIcons.morevertical,
                                                  height: 2.h,
                                                  color: AppColor.darkBlue,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
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
                ],
              ),
      ),
    );
  }
}
