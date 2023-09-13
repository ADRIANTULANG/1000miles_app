import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/modules/product_tab_view/view/product_description_view.dart';
import 'package:yoooto/modules/product_tab_view/view/product_variant_listview.dart';
import 'package:yoooto/modules/sampledragable/view/reorderable_view.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/product_tab_controller.dart';

class ProductTabView extends GetView<ProductTabController> {
  const ProductTabView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductTabController());
    return Scaffold(
      body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Container(
                height: 12.h,
                width: 100.w,
                padding: EdgeInsets.only(top: 4.h, left: 8.5.w, right: 8.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            CustomIcons.arrowback,
                            color: AppColor.black,
                          ),
                        ),
                        SizedBox(
                          width: 4.5.w,
                        ),
                        Text(
                          "Nike",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              letterSpacing: .5),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => DragableViews());
                      },
                      child: SvgPicture.asset(
                        CustomIcons.addnew,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverFillRemaining(
                        child: Scaffold(
                          appBar: TabBar(
                              padding: EdgeInsets.only(left: 4.w),
                              // indicator: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(5),
                              //     color: Color.fromARGB(255, 206, 223, 231)),
                              indicatorColor: Colors.black,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              isScrollable: false,
                              automaticIndicatorColorAdjustment: true,
                              tabs: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 4.h,
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.w500),
                                    )),
                                Container(
                                    alignment: Alignment.center,
                                    height: 4.h,
                                    child: Text(
                                      "Variants",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ]),
                          body: TabBarView(
                              children: List<Widget>.generate(2, (int index) {
                            if (index == 0) {
                              return ProductDescriptionView();
                            } else if (index == 1) {
                              return ProductVariantsScreen();
                            } else {
                              return Container();
                            }
                          })),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
