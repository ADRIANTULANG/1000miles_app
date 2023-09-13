import 'package:cached_network_image/cached_network_image.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../../project_space_screen/view/project_space_view.dart';
import '../controller/search_screen_controller.dart';
import '../dialogs/search_dialogs.dart';

class SearchScreenView extends GetView<SearchScreenController> {
  const SearchScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchScreenController());
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Column(
          children: [
            SizedBox(
              height: 7.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 6.5.h,
                  width: 73.w,
                  child: Obx(
                    () => TextField(
                      focusNode: controller.searchFocusNode,
                      obscureText: false,
                      controller: controller.searchController,
                      style: TextStyle(
                          color: AppColor.darkBlue,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          fontFamily: FontFamily.maloryLight),
                      onChanged: (value) {
                        controller.searchFunction(projectname: value);
                      },
                      decoration: InputDecoration(
                          contentPadding: controller.isFocus.value == true
                              ? EdgeInsets.only(top: 1.h, left: 3.w)
                              : EdgeInsets.only(top: 1.h, left: 1.w),
                          prefixIcon: controller.isFocus.value == false
                              ? Entry.opacity(
                                  duration: Duration(milliseconds: 1500),
                                  child: Icon(
                                    Icons.search,
                                    size: 25.sp,
                                    color: Colors.black,
                                  ),
                                )
                              : null,
                          suffixIcon: controller.isFocus.value == false
                              ? null
                              : InkWell(
                                  onTap: () {
                                    // FocusScope.of(context).unfocus();
                                    controller.searchController.clear();
                                    controller.projectlist.assignAll(
                                        controller.projectListMaster);
                                  },
                                  child: Entry.opacity(
                                    duration: Duration(milliseconds: 1000),
                                    child: Icon(
                                      Icons.clear,
                                      size: 20.sp,
                                      color: Color.fromARGB(255, 197, 195, 195),
                                    ),
                                  ),
                                ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.accentTorquise, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 190, 189, 189),
                                  width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.accentTorquise, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          hintText: controller.isFocus.value == true
                              ? null
                              : 'Search here..',
                          alignLabelWithHint: true),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (controller.searchController.text.isNotEmpty) {
                      controller.searchFocusNode.unfocus();
                      controller.searchController.clear();
                      controller.projectlist
                          .assignAll(controller.projectListMaster);
                    } else if (controller.searchFocusNode.hasFocus == true) {
                      controller.searchFocusNode.unfocus();
                      controller.searchController.clear();
                    } else {
                      Get.back();
                    }
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.maloryBold,
                      fontSize: 14.sp,
                    ),
                  ),
                )
              ],
            ),
            Obx(() => controller.searchScrollPosition.value == 0.0
                ? SizedBox(
                    height: 2.h,
                  )
                : SizedBox(
                    height: 0.h,
                  )),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.all(0),
                  controller: controller.searchScrollController,
                  itemCount: controller.projectlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 3.h,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ProjectSpaceView(), arguments: {
                            'projectName': controller.projectlist[index].name!,
                            'projectID':
                                controller.projectlist[index].id!.toString()
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
                              border: Border.all(color: AppColor.greyBlue)),
                          child: Column(
                            children: [
                              controller.projectlist[index].file!.file ==
                                          null ||
                                      controller
                                              .projectlist[index].file!.file ==
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
                                              .projectlist[index].file!.file
                                              .toString(),
                                      imageBuilder: (context, imageProvider) =>
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
                                      placeholder: (context, url) => Container(
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
                                      errorWidget: (context, url, error) =>
                                          Container(
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
                                            controller.projectlist[index].name
                                                        .toString() ==
                                                    ""
                                                ? "Unnamed"
                                                : controller
                                                    .projectlist[index].name
                                                    .toString()
                                                    .capitalizeFirst
                                                    .toString(),
                                            style: TextStyle(
                                                color: AppColor.darkBlue,
                                                fontFamily:
                                                    FontFamily.maloryBold,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            controller.projectlist[index]
                                                    .dateWrite!.day
                                                    .toString() +
                                                "." +
                                                controller.projectlist[index]
                                                    .dateWrite!.month
                                                    .toString() +
                                                "." +
                                                controller.projectlist[index]
                                                    .dateWrite!.year
                                                    .toString(),
                                            style: TextStyle(
                                                fontFamily:
                                                    FontFamily.maloryLight,
                                                fontSize: 10.sp,
                                                color: AppColor.greyBlue,
                                                fontWeight: FontWeight.w400),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0))),
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
                                                          SearchDialog.showEditProjectScreen(
                                                              projectid: controller
                                                                  .projectlist[
                                                                      index]
                                                                  .id!,
                                                              projectname:
                                                                  controller
                                                                      .projectlist[
                                                                          index]
                                                                      .name!,
                                                              context: context,
                                                              controller:
                                                                  controller);
                                                        },
                                                        child: Container(
                                                          width: 100.w,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 5.w,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                CustomIcons
                                                                    .editwithbox,
                                                                color: AppColor
                                                                    .darkBlue,
                                                              ),
                                                              SizedBox(
                                                                width: 3.w,
                                                              ),
                                                              Text(
                                                                "Edit details",
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .darkBlue,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .maloryBold,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
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
                                                                  .projectlist[
                                                                      index]
                                                                  .id!);
                                                        },
                                                        child: Container(
                                                          width: 100.w,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 5.w,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                CustomIcons
                                                                    .duplicate,
                                                                color: AppColor
                                                                    .darkBlue,
                                                              ),
                                                              SizedBox(
                                                                width: 4.w,
                                                              ),
                                                              Text(
                                                                "Duplicate",
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .darkBlue,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .maloryBold,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
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
                                                                  .projectlist[
                                                                      index]
                                                                  .id!);
                                                        },
                                                        child: Container(
                                                          width: 100.w,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 5.w,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                CustomIcons
                                                                    .archived,
                                                                color: AppColor
                                                                    .darkBlue,
                                                              ),
                                                              SizedBox(
                                                                width: 3.5.w,
                                                              ),
                                                              Text(
                                                                "Archive",
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .darkBlue,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .maloryBold,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                          SearchDialog.showDialogDeleteProject(
                                                              projectID: controller
                                                                  .projectlist[
                                                                      index]
                                                                  .id!,
                                                              controller:
                                                                  controller,
                                                              projectname:
                                                                  controller
                                                                      .projectlist[
                                                                          index]
                                                                      .name!);
                                                        },
                                                        child: Container(
                                                          width: 100.w,
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 5.w,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                CustomIcons
                                                                    .trash,
                                                                color: AppColor
                                                                    .darkBlue,
                                                              ),
                                                              SizedBox(
                                                                width: 4.w,
                                                              ),
                                                              Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .darkBlue,
                                                                    fontFamily:
                                                                        FontFamily
                                                                            .maloryBold,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
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
