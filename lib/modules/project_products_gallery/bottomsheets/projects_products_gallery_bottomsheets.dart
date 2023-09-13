import 'package:cached_network_image/cached_network_image.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import '../../../config/endpoints.dart';
import '../../../constant/icons_class.dart';
import '../../select_photo_for_product_screen/controller/select_photo_for_product_controller.dart';
import '../../select_photo_for_product_screen/model/select_photo_for_product_model.dart';
import '../../select_photo_for_product_screen/view/select_photo_for_product_camera_view.dart';
import '../controller/project_products_gallery_controller.dart';

class ProjectsProductsGalleryBottomsheets {
  static showEditBottomSheets(
      {required ProjectProductsGalleryController controller}) {
    Get.bottomSheet(
        Container(
          height: 93.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 1.h),
                height: 7.h,
                width: 100.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          CustomIcons.clear,
                        ),
                        SizedBox(
                          width: 3.5.w,
                        ),
                        Text(
                          "Filters",
                          style: TextStyle(
                              fontSize: 14.sp,
                              letterSpacing: .5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.isGroupsOnly.value = false;
                        controller.isRecentlyAdded.value = false;
                        controller.productsAndGroupsList.assignAll(
                            controller.productsAndGroupsList_masterList);
                      },
                      child: Text(
                        "Deselect all",
                        style: TextStyle(
                            fontSize: 12.sp,
                            letterSpacing: .5,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: .15.w,
                color: AppColor.greyBlue,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                width: 100.w,
                padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 1.h),
                child: Text(
                  "Sort by",
                  style: TextStyle(
                      fontSize: 14.sp,
                      letterSpacing: .5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                width: 100.w,
                padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recently added first",
                      style: TextStyle(
                          fontSize: 14.sp,
                          letterSpacing: .5,
                          fontWeight: FontWeight.w300),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.isRecentlyAdded.value == true) {
                          controller.isRecentlyAdded.value = false;
                        } else {
                          controller.isRecentlyAdded.value = true;
                        }
                        controller.recentlyaddedFirst(
                            isRecentlyAdded: controller.isRecentlyAdded.value);
                      },
                      child: Obx(
                        () => SvgPicture.asset(
                          controller.isRecentlyAdded.value == true
                              ? CustomIcons.radiobuttonactive
                              : CustomIcons.radiobutton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 1.h),
                child: Divider(
                  color: AppColor.greyBlue,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                width: 100.w,
                padding: EdgeInsets.only(right: 2.w, left: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          CustomIcons.folder,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "Show only Groups",
                          style: TextStyle(
                              fontSize: 14.sp,
                              letterSpacing: .5,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Obx(
                      () => Switch(
                          inactiveTrackColor: Colors.black,
                          activeColor: Colors.black,
                          value: controller.isGroupsOnly.value,
                          onChanged: (value) {
                            controller.isGroupsOnly.value = value;
                            controller.groupsOnly(
                                isGroup: controller.isGroupsOnly.value);
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        isScrollControlled: true);
  }

  static showShortButtons(
      {required ProjectProductsGalleryController controller}) {
    Get.bottomSheet(Container(
      height: 30.h,
      width: 100.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.qrcode,
                  color: AppColor.white,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Yoooto scanner",
                  style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: () {
              // Get.back();
              // showCreateGroupBottomSheet(controller: controller);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.folder,
                  color: AppColor.white,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Create a Group",
                  style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: () async {
              Get.back();
              Get.to(() => CameraProductScreenView(), arguments: {
                "isFromHomescreen": false,
                "projectID": controller.projectID.value,
                "projectName": controller.projectName.value,
                "groupID": ""
              });
              final ImagePicker picker = ImagePicker();
              final List<XFile>? images = await picker.pickMultiImage();
              if (Get.isRegistered<SelectProductPhotoController>() == true) {
                if (images != null) {
                  for (var i = 0; i < images.length; i++) {
                    PicturesProductModel map = PicturesProductModel(
                        path: images[i].path,
                        isFirst: false,
                        isLast: false,
                        isSelected: false.obs);
                    Get.find<SelectProductPhotoController>()
                        .storageImages
                        .add(map);
                  }
                }
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.addimages,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Choose from Library",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: () {
              Get.back();
              Get.to(() => CameraProductScreenView(), arguments: {
                "isFromHomescreen": false,
                "projectID": controller.projectID.value,
                "projectName": controller.projectName.value,
                "groupID": ""
              });
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.camera,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Take a photo",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  static showCreateGroupBottomSheet(
      {required ProjectProductsGalleryController controller}) {
    Get.bottomSheet(
        Container(
          height: 93.h,
          width: 100.w,
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    "Done",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Create Group",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    letterSpacing: .5),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 7.h,
                width: 100.w,
                child: TextField(
                  obscureText: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      letterSpacing: .5),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.accentTorquise, width: .5.w),
                        borderRadius: BorderRadius.circular(6)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.greyBlue, width: .5.w),
                        borderRadius: BorderRadius.circular(6)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.accentTorquise, width: .5.w),
                        borderRadius: BorderRadius.circular(6)),
                    hintText: 'Enter group name',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                        color: AppColor.greyBlue,
                        letterSpacing: .5),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Select products",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    letterSpacing: .5),
              ),
              SizedBox(
                height: 3.h,
              ),
              Expanded(
                  child: Container(
                child: Obx(
                  () => controller.ungrouped_products.length == 0
                      ? Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                CustomIcons.box,
                                color: AppColor.greyBlue,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                "No Products available",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.greyBlue,
                                ),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.ungrouped_products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 15.h,
                              width: 100.w,
                              child: Row(
                                children: [
                                  Container(
                                    height: 15.h,
                                    alignment: Alignment.topCenter,
                                    child: SvgPicture.asset(
                                      CustomIcons.cloudarrowup,
                                      height: 2.h,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: AppEndpoint.endPointDomain +
                                        "" +
                                        controller.ungrouped_products[index]
                                            .productImage
                                            .toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 14.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                        height: 14.h,
                                        width: 40.w,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      height: 14.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/transparent.jpg"))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Container(
                                    width: 30.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.ungrouped_products[index]
                                              .productOrGroupName,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp),
                                        ),
                                        SizedBox(
                                          height: .5.h,
                                        ),
                                        Text(
                                          "(${controller.ungrouped_products[index].noOfVariantsOrProducts} variants)",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.ungrouped_products[index]
                                                .isSelected.value ==
                                            false) {
                                          controller.ungrouped_products[index]
                                              .isSelected.value = true;
                                        } else {
                                          controller.ungrouped_products[index]
                                              .isSelected.value = false;
                                        }
                                      },
                                      child: Obx(
                                        () => Container(
                                          alignment: Alignment.centerRight,
                                          child: controller
                                                      .ungrouped_products[index]
                                                      .isSelected
                                                      .value ==
                                                  false
                                              ? SvgPicture.asset(
                                                  CustomIcons.checkboxUnchecked,
                                                )
                                              : SvgPicture.asset(
                                                  CustomIcons.checkboxchecked,
                                                ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ))
            ],
          ),
        ),
        isScrollControlled: true);
  }

  static showProductsOfGroups(
      {required ProjectProductsGalleryController controller,
      required String groupname}) {
    Get.bottomSheet(
        Container(
          height: 93.h,
          width: 100.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: Column(
            children: [
              Obx(
                () => Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      boxShadow: controller.group_scrollPosition.value == 0.0
                          ? []
                          : [
                              BoxShadow(
                                spreadRadius: .1,
                                blurRadius: 5,
                                color: Color.fromARGB(255, 218, 214, 214),
                                offset: Offset(0, 3),
                              )
                            ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            CustomIcons.arrowbackios,
                            height: 1.7.h,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                        ],
                      ),
                      Obx(
                        () => controller.group_scrollPosition.value == 0.0
                            ? Expanded(
                                child: Container(
                                  child: Entry.all(
                                    child: Text(
                                      "Products",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 3.w),
                                  alignment: Alignment.center,
                                  child: Entry.all(
                                    child: Text(
                                      groupname,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 12.sp,
                            letterSpacing: .5,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Obx(
                () => controller.group_scrollPosition.value == 0.0
                    ? Container(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        width: 100.w,
                        child: Entry.offset(
                          xOffset: -1000,
                          yOffset: 0,
                          child: Text(
                            groupname,
                            style: TextStyle(
                                fontSize: 18.sp,
                                letterSpacing: .5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: ListView.builder(
                  controller: controller.group_scrollController,
                  itemCount: controller.grouped_products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Container(
                        height: 15.h,
                        width: 100.w,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 1.h),
                              height: 15.h,
                              alignment: Alignment.topCenter,
                              child: SvgPicture.asset(
                                CustomIcons.cloudarrowup,
                                height: 2.h,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: AppEndpoint.endPointDomain +
                                  "" +
                                  controller
                                      .grouped_products[index].productImage
                                      .toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 14.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                  height: 14.h,
                                  width: 40.w,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) => Container(
                                height: 14.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/transparent.jpg"))),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Container(
                              width: 35.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.grouped_products[index]
                                        .productOrGroupName,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                  SizedBox(
                                    height: .5.h,
                                  ),
                                  Text(
                                    "(${controller.grouped_products[index].noOfVariantsOrProducts} variants)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15.sp,
                                      color: AppColor.greyBlue,
                                    )))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ))
            ],
          ),
        ),
        isScrollControlled: true);
  }
}
