import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../controller/my_ideas_controller.dart';

class MyIdeasUngroupedItem extends GetView<MyIdeasController> {
  const MyIdeasUngroupedItem(
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
    return Container(
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
                    border: Border.all(width: 0.5.sp, color: AppColor.greyBlue),
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
                          image: AssetImage("assets/images/transparent.jpg"))),
                ),
                errorWidget: (context, url, error) => Container(
                  height: name == "" ? 26.h : 23.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/transparent.jpg"))),
                ),
              ),
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
    );
  }
}
