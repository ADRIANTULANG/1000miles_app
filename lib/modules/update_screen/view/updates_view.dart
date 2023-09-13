import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/updates_controller.dart';

class UpdatesView extends GetView<UpdatesViewController> {
  const UpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Obx(
              () => Container(
                height: 7.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: controller.scrollPosition.value == 0.0
                        ? []
                        : [
                            BoxShadow(
                              spreadRadius: .1,
                              blurRadius: 5,
                              color: Color.fromARGB(255, 218, 214, 214),
                              offset: Offset(0, 3),
                            )
                          ]),
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => controller.scrollPosition.value == 0.0
                          ? Expanded(
                              child: Container(
                                child: Entry.all(
                                  child: Text(
                                    "Updates",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        letterSpacing: .5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 3.w),
                                alignment: Alignment.center,
                                child: Entry.all(
                                  child: Text(
                                    "Updates",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        letterSpacing: .5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    SvgPicture.asset(
                      CustomIcons.search,
                      color: AppColor.black,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(0),
                  itemCount: 11,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 2.h, left: 5.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: CircleAvatar(
                              radius: 1.w,
                              backgroundColor: AppColor.redAccent,
                            ),
                          ),
                          SizedBox(
                            width: 1.5.w,
                          ),
                          CircleAvatar(
                            radius: 5.w,
                            backgroundColor: AppColor.accentTorquise,
                            child: CircleAvatar(
                              radius: 4.5.w,
                              backgroundImage: NetworkImage(
                                  "https://scontent.fcgy2-1.fna.fbcdn.net/v/t1.6435-9/118594597_1687550621409761_245719506126445685_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFcWOYhbJwJ83v2m7mwKF4-FDT4litr3bcUNPiWK2vdt4h3kcsCBeTwCU61Sl7uSPW9g7XFuBn6kpiQQ07lk83y&_nc_ohc=Gb649clnp0YAX_ZZYEP&_nc_oc=AQkZtUi-Tx8IxvRbGuuqXNTwraXSnHj48AL1LhaTLb8xalaZJvXjiGYNNnBxIlf3psY&_nc_ht=scontent.fcgy2-1.fna&oh=00_AfD2TGLUKkwprEF7Km7MiDdElt-irVKZwh5z6hG6i64zQA&oe=63896180"),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: .1.h,
                                  ),
                                  Text(
                                    "Adrian Benedict S. Tulang",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: .5.h,
                                  ),
                                  Text(
                                    "Mentioned you in the comment for Product Name Number 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp,
                                        color:
                                            Color.fromARGB(255, 196, 193, 193)),
                                  ),
                                  index == 8 ||
                                          index == 3 ||
                                          index == 7 ||
                                          index == 1
                                      ? Container(
                                          width: 100.w,
                                          padding: EdgeInsets.only(right: 4.w),
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 5.h,
                                            width: 26.w,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 183, 201, 231),
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Reply",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 15.sp,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
