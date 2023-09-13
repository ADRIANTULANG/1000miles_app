import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/product_variants_and_details_screen_controller.dart';
import '../widgets/button_view.dart';
import '../widgets/cellValues_view.dart';
import '../widgets/incoterms_terms_transpo_view.dart';
import '../widgets/listview_verticalList_view.dart';
import '../widgets/variant_carousel_view.dart';

class ProductVariantsAndDetailsView
    extends GetView<ProductVariantsAndDetailsController> {
  const ProductVariantsAndDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductVariantsAndDetailsController());
    return Obx(
      () => controller.isLoading.value == true
          ? Scaffold(
              drawerEnableOpenDragGesture: false,
              body: Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 25.w, right: 25.w, bottom: 15.h),
                  child: Lottie.asset("assets/loading/animation.json"),
                ),
              ),
            )
          : Scaffold(
              body: SafeArea(
                child: Container(
                    height: 100.h,
                    width: 100.w,
                    child: Column(
                      children: [
                        Container(
                          height: 7.h,
                          width: 100.w,
                          padding: EdgeInsets.only(right: 5.w, left: 5.w),
                          decoration:
                              BoxDecoration(color: AppColor.white, boxShadow: [
                            BoxShadow(
                              spreadRadius: .1,
                              blurRadius: 5,
                              color: Color.fromARGB(255, 218, 214, 214),
                              offset: Offset(0, 3),
                            )
                          ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                CustomIcons.arrowbackios,
                                height: 2.h,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Obx(
                                    () => Text(
                                      controller.productName.value,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                CustomIcons.morehorizontal,
                                color: AppColor.black,
                              ),
                            ],
                          ),
                        ),
                        //asdasdasdasd
                        Expanded(
                          child: Container(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  VariantCarouselView(),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ListViewVerticalListView(),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 5.w, right: 5.w),
                                    width: 100.w,
                                    child: Obx(
                                      () => Wrap(
                                        alignment: WrapAlignment.start,
                                        children: List.generate(
                                            controller.tagsList.length,
                                            (index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(right: 1.w),
                                            child: Container(
                                              child: Text(
                                                "#" +
                                                    controller
                                                        .tagsList[index].name!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp,
                                                    color: AppColor
                                                        .accentTorquise),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 5.w, right: 5.w),
                                    width: 100.w,
                                    child: Text(
                                      controller.variantName.value,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 5.w, right: 5.w),
                                    width: 100.w,
                                    child: Text(
                                      controller.productDescription.value,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  IncotermsTermsAndTraspoView(),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  CellValuesView(),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ButtonView(),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              bottomNavigationBar: Container(
                height: 6.5.h,
                width: 100.w,
                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    spreadRadius: .1,
                    blurRadius: 5,
                    color: Color.fromARGB(255, 236, 235, 235),
                    offset: Offset(0, -2.5),
                  )
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          CustomIcons.comments,
                          color: AppColor.black,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        SvgPicture.asset(
                          CustomIcons.likes,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      CustomIcons.addnew,
                      color: AppColor.black,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
