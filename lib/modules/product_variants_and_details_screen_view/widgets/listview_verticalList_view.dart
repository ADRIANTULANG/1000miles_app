import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';

import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/product_variants_and_details_screen_controller.dart';

class ListViewVerticalListView
    extends GetView<ProductVariantsAndDetailsController> {
  const ListViewVerticalListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w),
      height: 13.h,
      width: 100.w,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.product_variants_verticalList_view.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: 1.5.w),
              child: controller
                          .product_variants_verticalList_view[index].isAddNew ==
                      true
                  ? Container(
                      height: 13.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColor.greyBlue),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            CustomIcons.addnew,
                            color: AppColor.greyBlue,
                            height: 2.5.h,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "New Variant",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: AppColor.greyBlue),
                          )
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        controller.changeImageBorder(
                            index: index,
                            id: controller
                                .product_variants_verticalList_view[index].id);
                        controller.carouselController.jumpToPage(index);
                        controller.defaultSelectedIndex.value = index;
                        controller.autoscroll_controller.scrollToIndex(
                            controller.defaultSelectedIndex.value,
                            duration: Duration(seconds: 1),
                            preferPosition: AutoScrollPosition.middle);
                      },
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: AppEndpoint.endPointDomain +
                            "" +
                            controller.getMainUrl(
                                fileList: controller
                                    .product_variants_carousel_view[index]
                                    .file),
                        imageBuilder: (context, imageProvider) => Obx(
                          () => Container(
                            height: 13.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: controller
                                              .product_variants_verticalList_view[
                                                  index]
                                              .isSelected
                                              .value ==
                                          true
                                      ? 0.5.w
                                      : 1,
                                  color: controller
                                              .product_variants_verticalList_view[
                                                  index]
                                              .isSelected
                                              .value ==
                                          true
                                      ? AppColor.accentTorquise
                                      : AppColor.greyBlue),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                            height: 13.h,
                            width: 30.w,
                            child: Center(child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Obx(
                          () => Container(
                            height: 13.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: controller
                                                .product_variants_verticalList_view[
                                                    index]
                                                .isSelected
                                                .value ==
                                            true
                                        ? 0.5.w
                                        : 1,
                                    color: controller
                                                .product_variants_verticalList_view[
                                                    index]
                                                .isSelected
                                                .value ==
                                            true
                                        ? AppColor.accentTorquise
                                        : AppColor.greyBlue),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/transparent.jpg"))),
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
