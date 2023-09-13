import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/product_variants_and_details_screen_controller.dart';

class CellValuesView extends GetView<ProductVariantsAndDetailsController> {
  const CellValuesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.greyBlue)),
        child: Column(
          children: [
            Container(
              height: 8.h,
              width: 100.w,
              padding: EdgeInsets.only(left: 3.w, right: 3.w),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 204, 224, 223),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      controller.productName.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.sp),
                    ),
                  ),
                  SvgPicture.asset(
                    CustomIcons.editwithbox,
                    color: AppColor.black,
                  ),
                ],
              ),
            ),
            Container(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.cellList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 6.h,
                            padding: EdgeInsets.only(left: 3.w),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: index ==
                                            (controller.cellList.length - 1)
                                        ? BorderSide.none
                                        : BorderSide(color: AppColor.greyBlue),
                                    right:
                                        BorderSide(color: AppColor.greyBlue))),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.cellList[index].variantRow.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: index == (controller.cellList.length - 1)
                                  ? BorderSide.none
                                  : BorderSide(color: AppColor.greyBlue),
                            )),
                            alignment: Alignment.center,
                            child: Text(
                              controller.cellList[index].value,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.greyBlue,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
