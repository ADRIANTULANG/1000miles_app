import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../controller/my_ideas_controller.dart';

class MyIdeasOneItem extends GetView<MyIdeasController> {
  const MyIdeasOneItem(
      {required this.one_item_image, required this.groupname, super.key});
  final String one_item_image;
  final String groupname;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: AppEndpoint.endPointFile + "" + one_item_image.toString(),
            imageBuilder: (context, imageProvider) => Container(
              height: 23.h,
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
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Container(
              height: 23.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/transparent.jpg"))),
            ),
            errorWidget: (context, url, error) => Container(
              height: 23.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/transparent.jpg"))),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 2.5.w),
            alignment: Alignment.centerLeft,
            child: Text(
              groupname.capitalizeFirst.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.maloryBold,
                  fontSize: 12.sp),
            ),
          ))
        ],
      ),
    );
  }
}
