import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
// import '../bottomsheets/projects_products_gallery_bottomsheets.dart';
import '../controller/project_products_gallery_controller.dart';

class GroupedProducts extends GetView<ProjectProductsGalleryController> {
  const GroupedProducts({required this.index, super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h, left: 5.w, right: 5.w),
      child: InkWell(
        onTap: () async {
          // await controller.getAllGroupedProducts(
          //     groupedID:
          //         controller.productsAndGroupsList[index].productIDorGroupedID);
          // ProjectsProductsGalleryBottomsheets.showProductsOfGroups(
          //   controller: controller,
          //   groupname:
          //       controller.productsAndGroupsList[index].productOrGroupName,
          // );
        },
        child: Container(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    CustomIcons.foldertop,
                    height: 2.h,
                  ),
                  Container(
                    height: 12.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        border: Border.all(
                            color: Color.fromARGB(255, 202, 200, 200))),
                  )
                ],
              ),
              SizedBox(
                width: 4.w,
              ),
              Container(
                width: 35.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      controller
                          .productsAndGroupsList[index].productOrGroupName,
                      style: TextStyle(
                          fontFamily: FontFamily.maloryBold,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Text(
                      "(${controller.productsAndGroupsList[index].noOfVariantsOrProducts} products)",
                      style: TextStyle(
                          color: AppColor.greyBlue,
                          fontFamily: FontFamily.maloryLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 5.h),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15.sp,
                        color: AppColor.greyBlue,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
