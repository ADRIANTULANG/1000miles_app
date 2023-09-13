import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/product_tab_controller.dart';

class ProductVariantsScreen extends GetView<ProductTabController> {
  const ProductVariantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 100.h,
        // width: 100.w,
        child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
              child: Container(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
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
                    ),
                    Positioned(
                        bottom: 0.h,
                        child: Container(
                          height: 5.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                "Black,",
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 11.sp,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Container(
                                child: Text(
                                  "Purple,",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 11.sp,
                                      letterSpacing: .5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                "L",
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 11.sp,
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
