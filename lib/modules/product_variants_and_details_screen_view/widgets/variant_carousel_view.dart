import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';

import '../../../config/endpoints.dart';
import '../controller/product_variants_and_details_screen_controller.dart';

class VariantCarouselView extends GetView<ProductVariantsAndDetailsController> {
  const VariantCarouselView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 45.h,
          width: 100.w,
          child: Obx(
            () => CarouselSlider(
              carouselController: controller.carouselController,
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    print(
                        "print variant id${controller.product_variants_carousel_view[index].id}");
                    controller.variant_no_indentifier.value = index + 1;
                    int id =
                        controller.product_variants_carousel_view[index].id;
                    controller.changeImageBorder(index: index, id: id);
                    controller.defaultSelectedIndex.value = index;
                    controller.autoscroll_controller.scrollToIndex(
                        controller.defaultSelectedIndex.value,
                        duration: Duration(seconds: 1),
                        preferPosition: AutoScrollPosition.middle);
                  },
                  height: 55.h,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false),
              items: List.generate(
                controller.product_variants_carousel_view.length,
                (index) {
                  return CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: AppEndpoint.endPointDomain +
                        "" +
                        controller.getMainUrl(
                            fileList: controller
                                .product_variants_carousel_view[index].file),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 45.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        height: 45.h,
                        width: 100.w,
                        child: Center(child: CircularProgressIndicator())),
                    errorWidget: (context, url, error) => Container(
                      height: 45.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/transparent.jpg"))),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
            left: 3.w,
            top: 20.h,
            child: InkWell(
              onTap: () {
                controller.carouselController.previousPage();
              },
              child: CircleAvatar(
                  radius: 6.w,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 13.sp,
                  )),
            )),
        Positioned(
            right: 3.w,
            top: 20.h,
            child: InkWell(
              onTap: () {
                controller.carouselController.nextPage();
              },
              child: CircleAvatar(
                  radius: 6.w,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                    size: 13.sp,
                  )),
            )),
        Positioned(
          right: 3.w,
          top: 38.h,
          child: Container(
            padding:
                EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10)),
            child: Obx(
              () => Text(
                "${controller.variant_no_indentifier.value}/${controller.product_variants_carousel_view.length}",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
