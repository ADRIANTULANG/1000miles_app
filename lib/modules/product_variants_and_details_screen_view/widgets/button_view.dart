import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/product_variants_and_details_screen_controller.dart';

class ButtonView extends GetView<ProductVariantsAndDetailsController> {
  const ButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (controller.defaultSelectedIndex.value != 0) {
                controller.defaultSelectedIndex.value =
                    controller.defaultSelectedIndex.value - 1;
                controller.autoscroll_controller.scrollToIndex(
                    controller.defaultSelectedIndex.value,
                    duration: Duration(seconds: 1),
                    preferPosition: AutoScrollPosition.middle);
                print("scrolling");
                controller.changeImageBorder(
                    index: controller.defaultSelectedIndex.value,
                    id: controller
                        .product_variants_verticalList_view[
                            controller.defaultSelectedIndex.value]
                        .id);
                controller.carouselController
                    .jumpToPage(controller.defaultSelectedIndex.value);
              }
            },
            child: Container(
              width: 7.w,
              child: SvgPicture.asset(
                CustomIcons.arrowbackios,
                color: AppColor.black,
                height: 2.5.h,
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Container(
              height: 6.h,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.product_variants_carousel_view.length,
                  controller: controller.autoscroll_controller,
                  itemBuilder: (BuildContext context, int index) {
                    return AutoScrollTag(
                      key: ValueKey(index),
                      index: index,
                      controller: controller.autoscroll_controller,
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: InkWell(
                          onTap: () {
                            controller.defaultSelectedIndex.value = index;
                            controller.autoscroll_controller.scrollToIndex(
                                controller.defaultSelectedIndex.value,
                                duration: Duration(seconds: 1),
                                preferPosition: AutoScrollPosition.middle);
                            print("scrolling");
                            controller.changeImageBorder(
                                index: controller.defaultSelectedIndex.value,
                                id: controller
                                    .product_variants_verticalList_view[
                                        controller.defaultSelectedIndex.value]
                                    .id);
                            controller.carouselController.jumpToPage(
                                controller.defaultSelectedIndex.value);
                          },
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              height: 6.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                  color:
                                      controller.defaultSelectedIndex.value ==
                                              index
                                          ? AppColor.white
                                          : AppColor.greyBlue,
                                  border:
                                      controller.defaultSelectedIndex.value ==
                                              index
                                          ? Border.all(
                                              width: 0.5.w,
                                              color: AppColor.accentTorquise)
                                          : null,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          InkWell(
            onTap: () {
              if (controller.defaultSelectedIndex.value !=
                  controller.product_variants_carousel_view.length - 1) {
                controller.defaultSelectedIndex.value =
                    controller.defaultSelectedIndex.value + 1;
                controller.autoscroll_controller.scrollToIndex(
                    controller.defaultSelectedIndex.value,
                    duration: Duration(seconds: 1),
                    preferPosition: AutoScrollPosition.middle);
                print("scrolling");
                print(controller.defaultSelectedIndex.value);
                controller.changeImageBorder(
                    index: controller.defaultSelectedIndex.value,
                    id: controller
                        .product_variants_verticalList_view[
                            controller.defaultSelectedIndex.value]
                        .id);
                controller.carouselController
                    .jumpToPage(controller.defaultSelectedIndex.value);
              }
            },
            child: Container(
              width: 7.w,
              child: SvgPicture.asset(
                CustomIcons.arrowforwardios,
                color: AppColor.black,
                height: 2.5.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
