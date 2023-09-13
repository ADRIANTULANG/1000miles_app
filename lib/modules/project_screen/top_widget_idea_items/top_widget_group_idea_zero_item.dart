import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../controller/projects_controller.dart';

class TopIdeaWidgetZeroItem extends GetView<ProjectsScreenController> {
  const TopIdeaWidgetZeroItem({required this.groupname, super.key});
  final String groupname;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
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
                color: Colors.white),
            alignment: Alignment.center,
            child: Text(
              "0 ideas",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.maloryBold,
                  fontSize: 14.sp),
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
