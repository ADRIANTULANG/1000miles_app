import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/product_variants_and_details_screen_controller.dart';

class IncotermsTermsAndTraspoView
    extends GetView<ProductVariantsAndDetailsController> {
  const IncotermsTermsAndTraspoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: InkWell(
              onTap: () {
                if (controller.isShowIncoterms.value == false) {
                  controller.isShowIncoterms.value = true;
                } else {
                  controller.isShowIncoterms.value = false;
                }
              },
              child: Obx(
                () => Container(
                  height: 8.h,
                  width: 100.w,
                  padding: EdgeInsets.only(
                      left: controller.isShowIncoterms.value == false ? 3.w : 0,
                      right: 4.w),
                  decoration: BoxDecoration(
                      color: controller.isShowIncoterms.value == false
                          ? Color.fromARGB(255, 204, 224, 223)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          "Terms & transportation",
                          style: TextStyle(
                              fontWeight:
                                  controller.isShowIncoterms.value == false
                                      ? FontWeight.w400
                                      : FontWeight.bold,
                              fontSize: 12.sp),
                        ),
                      ),
                      Obx(
                        () => controller.isShowIncoterms.value == false
                            ? SvgPicture.asset(
                                CustomIcons.arrowdown,
                                color: AppColor.black,
                                height: 1.4.h,
                              )
                            : SvgPicture.asset(
                                CustomIcons.arrowup,
                                color: AppColor.black,
                                height: 1.4.h,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Obx(
            () => controller.isShowIncoterms.value == false
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Container(
                      height: 32.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.greyBlue),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Container(
                            height: 6.5.h,
                            width: 100.w,
                            padding: EdgeInsets.only(
                              left: 3.w,
                            ),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: AppColor.greyBlue))),
                            child: Text(
                              "Incoterms",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                          ),
                          Container(
                            width: 100.w,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColor.greyBlue),
                                            right: BorderSide(
                                                color: AppColor.greyBlue))),
                                    alignment: Alignment.center,
                                    child: Obx(
                                      () => Text(
                                        controller.incotermsName.value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom:
                                          BorderSide(color: AppColor.greyBlue),
                                    )),
                                    height: 6.h,
                                    alignment: Alignment.center,
                                    child: Obx(
                                      () => Text(
                                        controller.incotermsPlace.value
                                            .capitalizeFirst
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 6.5.h,
                            width: 100.w,
                            padding: EdgeInsets.only(
                              left: 3.w,
                            ),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: AppColor.greyBlue))),
                            child: Row(
                              children: [
                                Text(
                                  "Master carton size ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  "I",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22.sp),
                                ),
                                Text(
                                  " Quantity per carton",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 6.5.h,
                            width: 100.w,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColor.greyBlue),
                                            right: BorderSide(
                                                color: AppColor.greyBlue))),
                                    alignment: Alignment.center,
                                    child: Obx(
                                      () => Text(
                                        controller.incotermsLength.value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColor.greyBlue),
                                            right: BorderSide(
                                                color: AppColor.greyBlue))),
                                    alignment: Alignment.center,
                                    child: Obx(
                                      () => Text(
                                        controller.incotermsWidth.value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColor.greyBlue),
                                            right: BorderSide(
                                                color: AppColor.greyBlue))),
                                    alignment: Alignment.center,
                                    child: Obx(
                                      () => Text(
                                        controller.incotermsHeight.value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom:
                                          BorderSide(color: AppColor.greyBlue),
                                    )),
                                    alignment: Alignment.center,
                                    child: Obx(
                                      () => Text(
                                        controller.incotermsMetric.value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Obx(
                                () => Text(
                                  controller.incotermsQuantity.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
