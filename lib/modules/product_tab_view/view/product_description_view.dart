import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';

import '../../../constant/icons_class.dart';
import '../controller/product_tab_controller.dart';

class ProductDescriptionView extends GetView<ProductTabController> {
  const ProductDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(right: 4.w, left: 4.w),
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: 100.w,
                height: 7.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColor.accentTorquise,
                    )),
                child: Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "#summercollection",
                      style: TextStyle(
                          color: AppColor.accentTorquise,
                          fontSize: 11.sp,
                          letterSpacing: .5,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "#looks",
                      style: TextStyle(
                          color: AppColor.accentTorquise,
                          fontSize: 11.sp,
                          letterSpacing: .5,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "#men",
                      style: TextStyle(
                          color: AppColor.accentTorquise,
                          fontSize: 11.sp,
                          letterSpacing: .5,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://img.freepik.com/free-photo/pink-headphones-wireless-digital-device_53876-96804.jpg?w=2000",
                    imageBuilder: (context, imageProvider) => Container(
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 1.h,
                    right: 3.w,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        CustomIcons.morevertical,
                        color: AppColor.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                  width: 100.w,
                  height: 7.h,
                  padding: EdgeInsets.only(left: 4.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColor.accentTorquise,
                      )),
                  child: Text(
                    "T-Shirt",
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 11.sp,
                        letterSpacing: .5,
                        fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 2.h,
              ),
              Container(
                  width: 100.w,
                  height: 7.h,
                  padding: EdgeInsets.only(left: 4.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColor.accentTorquise,
                      )),
                  child: Text(
                    "Men Clothing",
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 11.sp,
                        letterSpacing: .5,
                        fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: 2.h,
              ),
              Container(
                  width: 100.w,
                  height: 16.h,
                  padding: EdgeInsets.only(left: 4.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColor.accentTorquise,
                      )),
                  child: Text(
                    "A cotton shirt with printed design",
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 11.sp,
                        letterSpacing: .5,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          )),
    );
  }
}
