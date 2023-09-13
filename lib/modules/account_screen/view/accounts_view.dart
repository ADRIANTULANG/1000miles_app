import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';

import '../../../constant/icons_class.dart';
import '../bottomsheet/account_bottom_sheet.dart';
import '../controller/account_controller.dart';
import '../dialog/account_screen_dialog.dart';

class AccountScreen extends GetView<AccountScreenScreenController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AccountScreenScreenController());
    return Obx(
      () => controller.isLoading.value == true
          ? Scaffold(
              body: Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 25.w, right: 25.w, bottom: 15.h),
                  child: Lottie.asset("assets/loading/animation.json"),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Platform.isIOS
                        ? Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 23.sp,
                            color: AppColor.darkBlue,
                          )
                        : Icon(
                            Icons.arrow_back,
                            size: 23.sp,
                            color: AppColor.darkBlue,
                          )),
                elevation: Platform.isIOS ? 0 : 1,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: Text(
                  'Account',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.maloryBold,
                      color: AppColor.darkBlue,
                      fontSize: 16.sp),
                ),
                centerTitle: Platform.isIOS ? true : false,
                actions: [
                  InkWell(
                    onTap: () async {
                      if (Platform.isIOS) {
                        AccountScreenDialog
                            .showAccountScreenSignoutDialogForIos(
                                controller: controller);
                      } else {
                        AccountScreenDialog
                            .showAccountScreenSignoutDialogForAndroid(
                                controller: controller);
                      }

                      // Get.to(() => AddProductsView());
                    },
                    child: SvgPicture.asset(
                      CustomIcons.uploadarrowforward,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: SizedBox(),
                  )
                ],
              ),
              body: Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  height: 90.h,
                  width: 100.w,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          // CircleAvatar(
                          //   radius: 7.w,
                          //   backgroundColor: Colors.grey,
                          //   child: CircleAvatar(
                          //     radius: 6.5.w,
                          //     backgroundImage: NetworkImage(
                          //         "https://scontent.fcgy2-1.fna.fbcdn.net/v/t1.6435-9/118594597_1687550621409761_245719506126445685_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFcWOYhbJwJ83v2m7mwKF4-FDT4litr3bcUNPiWK2vdt4h3kcsCBeTwCU61Sl7uSPW9g7XFuBn6kpiQQ07lk83y&_nc_ohc=Gb649clnp0YAX_ZZYEP&_nc_oc=AQkZtUi-Tx8IxvRbGuuqXNTwraXSnHj48AL1LhaTLb8xalaZJvXjiGYNNnBxIlf3psY&_nc_ht=scontent.fcgy2-1.fna&oh=00_AfD2TGLUKkwprEF7Km7MiDdElt-irVKZwh5z6hG6i64zQA&oe=63896180"),
                          //   ),
                          // ),
                          CircleAvatar(
                            radius: 7.w,
                            backgroundColor: AppColor.white,
                            child: CircleAvatar(
                              radius: 6.5.w,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.accentTorquise),
                                child: Obx(() => Text(
                                      controller
                                          .users_email.value[0].capitalizeFirst
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.white,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      controller.users_name.value,
                                      style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontFamily: FontFamily.maloryBold,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: .3.h,
                                  ),
                                  Obx(
                                    () => Text(
                                      controller.users_email.value,
                                      style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontFamily: FontFamily.maloryLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     // Get.to(() => AddProductsView());
                          //     controller.scrollPosition.value = 0.0;
                          //     AccountBottomSheets.showEditProfileBottomSheet(
                          //         context: context, controller: controller);
                          //   },
                          //   child: SvgPicture.asset(
                          //     CustomIcons.editwithbox,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: InkWell(
                          onTap: () {
                            controller.isWhatsAppSelected.value = false;
                            controller.isEmailSelected.value = false;
                            AccountBottomSheets.showShareCardBottomSheet(
                                context: context, controller: controller);
                          },
                          child: Container(
                            height: 7.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.greyBlue, width: .5.w),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  CustomIcons.share,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  "Share contact",
                                  style: TextStyle(
                                      color: AppColor.darkBlue,
                                      fontFamily: FontFamily.maloryBold,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   // child: SizedBox(),
                      //   child: Obx(
                      //     () => controller.filePath.value == ""
                      //         ? SizedBox()
                      //         : Container(
                      //             decoration: BoxDecoration(
                      //                 image: DecorationImage(
                      //                     image: MemoryImage(
                      //                         controller.imageFile!))),
                      //           ),
                      //   ),
                      // ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            CustomIcons.information,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          Text(
                            "Support and info",
                            style: TextStyle(
                                color: AppColor.darkBlue,
                                fontFamily: FontFamily.maloryBold,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Report issue",
                              style: TextStyle(
                                  color: AppColor.darkBlue,
                                  fontFamily: FontFamily.maloryLight,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: .5,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "About this app",
                            style: TextStyle(
                                color: AppColor.darkBlue,
                                fontFamily: FontFamily.maloryLight,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: .5,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      // Row(
                      //   children: [
                      //     SvgPicture.asset(
                      //       CustomIcons.deleteaccount,
                      //     ),
                      //     SizedBox(
                      //       width: 2.w,
                      //     ),
                      //     Text(
                      //       "Delete account",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w500, fontSize: 13.sp),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 3.h,
                      // ),
                    ],
                  )),
            ),
    );
  }
}
