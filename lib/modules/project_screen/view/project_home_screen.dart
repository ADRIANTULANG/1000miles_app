import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/modules/account_screen/view/accounts_view.dart';
import 'package:yoooto/services/storage_services.dart';
import '../../../constant/icons_class.dart';
import '../../search_screen/view/search_screen_view.dart';
import '../controller/projects_controller.dart';
import 'package:entry/entry.dart';
import '../widgets/in_progress_projects_widget.dart';
import '../widgets/is_archived_projects_widget.dart';
import '../widgets/is_completed_project_widget.dart';
import '../widgets/recently_viewed_projects_widgets.dart';

class ProjectHomeScreenView extends GetView<ProjectsScreenController> {
  const ProjectHomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: AppColor.white,
        child: Column(
          children: [
            Container(
                height: 9.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: InkWell(
                          onTap: () {
                            // controller.getProjects();
                            Get.to(() => AccountScreen());
                          },
                          child: CircleAvatar(
                            radius: 6.w,
                            backgroundColor: AppColor.white,
                            child: CircleAvatar(
                              backgroundColor: AppColor.accentTorquise,
                              radius: 5.5.w,
                              // backgroundImage: NetworkImage(
                              //     "https://scontent.fcgy2-1.fna.fbcdn.net/v/t1.6435-9/118594597_1687550621409761_245719506126445685_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFcWOYhbJwJ83v2m7mwKF4-FDT4litr3bcUNPiWK2vdt4h3kcsCBeTwCU61Sl7uSPW9g7XFuBn6kpiQQ07lk83y&_nc_ohc=Gb649clnp0YAX_ZZYEP&_nc_oc=AQkZtUi-Tx8IxvRbGuuqXNTwraXSnHj48AL1LhaTLb8xalaZJvXjiGYNNnBxIlf3psY&_nc_ht=scontent.fcgy2-1.fna&oh=00_AfD2TGLUKkwprEF7Km7MiDdElt-irVKZwh5z6hG6i64zQA&oe=63896180"),
                              child: Text(
                                Get.find<StorageServices>()
                                    .storage
                                    .read("email")[0]
                                    .toString()
                                    .capitalizeFirst
                                    .toString(),
                                style: TextStyle(
                                  fontFamily: FontFamily.maloryBold,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        )),
                    // Obx(
                    //   () => controller.scrollPosition_recently_viewed.value !=
                    //               0.0 ||
                    //           controller.scrollPosition_is_archived.value !=
                    //               0.0 ||
                    //           controller.scrollPosition_in_progress.value !=
                    //               0.0 ||
                    //           controller.scrollPosition_is_completed.value !=
                    //               0.0 ||
                    //           controller.scrollPosition_idea.value != 0.0 ||
                    //           controller.scrollPosition_products.value != 0.0
                    //       ? Entry.all(
                    //           duration: Duration(milliseconds: 350),
                    //           child: Container(
                    //             width: 70.w,
                    //             alignment: Platform.isIOS
                    //                 ? Alignment.center
                    //                 : Alignment.centerLeft,
                    //             child: Padding(
                    //               padding: EdgeInsets.only(right: 4.w),
                    //               child: Obx(
                    //                 () => Text(
                    //                   controller.selectedTopTabBar.value,
                    //                   style: TextStyle(
                    //                       fontSize: 15.sp,
                    //                       letterSpacing: .5,
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //       : SizedBox(),
                    // ),
                    Entry.all(
                      duration: Duration(milliseconds: 350),
                      child: Container(
                        width: 70.w,
                        alignment: Platform.isIOS
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Obx(
                            () => Text(
                              controller.selectedTopTabBar.value,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.5.w),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => SearchScreenView());
                        },
                        child: SvgPicture.asset(
                          CustomIcons.search,
                          height: 2.5.h,
                          color: AppColor.darkBlue,
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(5.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                    border: controller
                                                    .scrollPosition_recently_viewed
                                                    .value !=
                                                0.0 ||
                                            controller
                                                    .scrollPosition_in_progress
                                                    .value !=
                                                0.0 ||
                                            controller
                                                    .scrollPosition_is_archived
                                                    .value !=
                                                0.0 ||
                                            controller
                                                    .scrollPosition_is_completed !=
                                                0.0
                                        ? Border(
                                            bottom: BorderSide(
                                                color: AppColor.greyBlue,
                                                width: 0.2.w))
                                        : null),
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: TabBar(
                                    controller: controller.tabController,
                                    padding: EdgeInsets.only(left: 4.w),
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColor.accentLightblue),
                                    labelColor: AppColor.darkBlue,
                                    unselectedLabelColor: AppColor.grey,
                                    isScrollable: true,
                                    automaticIndicatorColorAdjustment: true,
                                    labelStyle: TextStyle(
                                        color: AppColor.darkBlue,
                                        fontFamily: FontFamily.maloryLight,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700),
                                    unselectedLabelStyle: TextStyle(
                                        color: AppColor.grey,
                                        fontFamily: FontFamily.maloryBold,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700),
                                    tabs: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: 3.5.h,
                                          child: Text(
                                            "Recently Updated",
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 3.5.h,
                                          child: Text(
                                            "In progress",
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 3.5.h,
                                          child: Obx(
                                            () => Text(
                                              "Completed (${controller.isCompletedProjectList.length})",
                                            ),
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          height: 3.5.h,
                                          child: Text(
                                            "Archived",
                                          )),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        body: TabBarView(
                            controller: controller.tabController,
                            children: List<Widget>.generate(4, (int index) {
                              if (index == 0) {
                                return RecentlyViewedProjects();
                              } else if (index == 1) {
                                return InProgressProjects();
                              } else if (index == 2) {
                                return IsCompletedProjects();
                              } else if (index == 3) {
                                return IsArchivedProjects();
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
        ),
      ),
    );
  }
}
