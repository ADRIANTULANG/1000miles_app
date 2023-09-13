import 'package:cached_network_image/cached_network_image.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/feed_screen_controller.dart';

class FeedScreen extends GetView<FeedScreenController> {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Container(
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
                                    "Feed",
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
                                    "Feed",
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
              Expanded(
                child: Container(
                  child: ListView.builder(
                    controller: controller.scrollController,
                    padding: EdgeInsets.all(0),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  "Today, 11 October 2022",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color.fromARGB(255, 204, 202, 202)),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 5.w,
                                        backgroundColor:
                                            AppColor.accentTorquise,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Adrian Benedict Tulang",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5.w),
                                              child: Container(
                                                child: Text(
                                                  "Uploaded a new idea Knitted toys to project Project Name number 11",
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromARGB(
                                                          255, 196, 193, 193)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://img.freepik.com/free-photo/knitted-children-s-clothing-light-background-with-accessories_169016-3186.jpg",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 45.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                    height: 45.h,
                                    width: 100.w,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) => Container(
                                  height: 45.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Icon(Icons.error),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Container(
                                      width: 70.w,
                                      height: 5.h,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        children: [
                                          for (var index = 0;
                                              index < 4;
                                              index++) ...[
                                            Positioned(
                                              left: index == 0
                                                  ? 0.w
                                                  : (index * 5.w),
                                              child: CircleAvatar(
                                                radius: 5.w,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 4.5.w,
                                                  backgroundImage: NetworkImage(
                                                      "https://i0.wp.com/thatrandomagency.com/wp-content/uploads/2021/06/headshot.png?resize=618%2C617&ssl=1"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(
                                          CustomIcons.comments,
                                          color: AppColor.black,
                                        ),
                                        SvgPicture.asset(
                                          CustomIcons.likes,
                                          color: AppColor.black,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: .5.h,
                              ),
                              index == 2 ? SizedBox() : Divider()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
