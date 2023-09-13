import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/project_products_gallery_controller.dart';

class UngroupedProdcuts extends GetView<ProjectProductsGalleryController> {
  const UngroupedProdcuts({required this.index, super.key});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h, left: 5.w, right: 5.w),
      child: InkWell(
        onTap: () {
          // Get.to(() => ProductVariantsAndDetailsView(), arguments: {
          //   "productId": controller
          //       .productsAndGroupsList[index].productIDorGroupedID
          //       .toString(),
          //   "productName": controller
          //       .productsAndGroupsList[index].productOrGroupName
          //       .toString()
          // });
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
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: AppEndpoint.endPointDomain +
                    "" +
                    controller.productsAndGroupsList[index].productImage
                        .toString(),
                imageBuilder: (context, imageProvider) => Container(
                  height: 14.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: .5,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                          color: AppColor.boxShadow)
                    ],
                    border: Border.all(color: AppColor.greyBlue),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => Container(
                    height: 14.h,
                    width: 40.w,
                    child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Container(
                  height: 14.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/transparent.jpg"))),
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
                      "(${controller.productsAndGroupsList[index].noOfVariantsOrProducts} variants)",
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
