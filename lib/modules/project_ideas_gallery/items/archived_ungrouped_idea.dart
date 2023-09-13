import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../../idea_details_screen/view/idea_detail_view.dart';
import '../controller/project_ideas_gallery_controller.dart';

class ArchivedUngroupedIdea extends GetView<ProjectIdeasGalleryController> {
  const ArchivedUngroupedIdea(
      {required this.image,
      required this.index,
      required this.name,
      required this.ideaID,
      required this.groupID,
      super.key});
  final String image;
  final String name;
  final int index;
  final String ideaID;
  final String groupID;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (controller.isEditing_for_homescreen.value == true &&
            controller.selectedCarouselIndex.value == 2) {
          if (controller.archived_ideas_list[index].isSelected.value == false) {
            controller.archived_ideas_list[index].isSelected.value = true;
          } else {
            controller.archived_ideas_list[index].isSelected.value = false;
          }
        } else {
          Get.to(() => IdeaDetailView(), arguments: {
            "ideaID": ideaID,
            "projectID": controller.projectID.value,
            "groupID": groupID,
          });
        }
      },
      onLongPress: () {
        controller.isEditing_for_homescreen.value = true;
        for (var element in controller.ungrouped_list) {
          element.isSelected.value = false;
        }
        for (var element in controller.grouped_list) {
          element.isSelected.value = false;
        }
        for (var element in controller.archived_ideas_list) {
          element.isSelected.value = false;
        }
        controller.archived_ideas_list[index].isSelected.value = true;
      },
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: AppEndpoint.endPointFile + "" + image.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    height: name == "" ? 26.h : 23.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.5.sp, color: AppColor.greyBlue),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: .5,
                          blurRadius: 3,
                          color: AppColor.boxShadow,
                          offset: Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    height: name == "" ? 26.h : 23.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage("assets/images/transparent.jpg"))),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: name == "" ? 26.h : 23.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage("assets/images/transparent.jpg"))),
                  ),
                ),
                Obx(
                  () => controller.isEditing_for_homescreen.value == true &&
                          controller.selectedCarouselIndex.value == 2
                      ? Positioned(
                          right: 2.w,
                          top: 1.h,
                          child: InkWell(
                            onTap: () {
                              if (controller.archived_ideas_list[index]
                                      .isSelected.value ==
                                  false) {
                                controller.archived_ideas_list[index].isSelected
                                    .value = true;
                              } else {
                                controller.archived_ideas_list[index].isSelected
                                    .value = false;
                              }
                            },
                            child: Obx(
                              () => controller.archived_ideas_list[index]
                                          .isSelected.value ==
                                      false
                                  ? SvgPicture.asset(
                                      CustomIcons.checkboxUnchecked,
                                      color: AppColor.black,
                                    )
                                  : SvgPicture.asset(
                                      CustomIcons.checkboxcheckedwhite,
                                    ),
                            ),
                          ),
                        )
                      : SizedBox(),
                )
              ],
            ),
            name == ""
                ? SizedBox()
                : Container(
                    height: 3.h,
                    width: 100.w,
                    padding: EdgeInsets.only(left: 2.5.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name.capitalizeFirst.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.maloryBold,
                          fontSize: 12.sp),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
