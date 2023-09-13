import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/modules/account_screen/controller/account_controller.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../../../services/storage_services.dart';

class AccountBottomSheets {
  static showShareCardBottomSheet(
      {required BuildContext context,
      required AccountScreenScreenController controller}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 96.h,
        padding: EdgeInsets.only(
          top: 3.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Platform.isIOS
                        ? SvgPicture.asset(
                            CustomIcons.clear,
                          )
                        : SvgPicture.asset(
                            CustomIcons.arrowback,
                          ),
                  ),
                  Expanded(
                      child: Container(
                    alignment: Platform.isIOS
                        ? Alignment.center
                        : Alignment.centerLeft,
                    child: Text(
                      Platform.isIOS ? "Share card" : "    Share Card",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColor.darkBlue,
                          fontFamily: FontFamily.maloryBold,
                          fontSize: 16.sp),
                    ),
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Platform.isAndroid
                ? Divider(
                    color: AppColor.grey,
                  )
                : SizedBox(),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Screenshot(
                controller: controller.screenshotController,
                child: Container(
                  height: 70.h,
                  width: 100.w,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                          height: 60.h,
                          width: 100.w,
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: .5,
                                  blurRadius: 3,
                                  color: AppColor.boxShadow,
                                  offset: Offset(0, 3),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 0.5, color: AppColor.greyBlue)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 4.h,
                                ),
                                Obx(
                                  () => Container(
                                    width: 100.w,
                                    alignment: Alignment.center,
                                    child: Text(
                                      controller.users_name.value,
                                      style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontFamily: FontFamily.maloryBold,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Obx(
                                  () => Text(
                                    controller.users_company.value,
                                    style: TextStyle(
                                      color: AppColor.darkBlue,
                                      fontFamily: FontFamily.maloryBold,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Obx(
                                  () => Text(
                                    controller.users_position.value,
                                    style: TextStyle(
                                      color: AppColor.darkBlue,
                                      fontFamily: FontFamily.maloryLight,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 7.w,
                                        height: 3.h,
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          CustomIcons.email,
                                          color: Color.fromARGB(
                                              255, 187, 184, 184),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.users_email.value,
                                        style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontFamily: FontFamily.maloryLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 7.w,
                                        height: 3.h,
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          CustomIcons.telephone,
                                          color: Color.fromARGB(
                                              255, 187, 184, 184),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.users_phone_number.value,
                                        style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontFamily: FontFamily.maloryLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 7.w,
                                        height: 3.h,
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          CustomIcons.location,
                                          color: Color.fromARGB(
                                              255, 187, 184, 184),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.h,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.users_location.value,
                                        style: TextStyle(
                                          color: AppColor.darkBlue,
                                          fontFamily: FontFamily.maloryLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Obx(
                                  () => Container(
                                    height: 25.h,
                                    width: 100.w,
                                    alignment: Alignment.center,
                                    child: QrImage(
                                      data: controller.users_id.value,
                                      version: QrVersions.auto,
                                      size: 50.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                              ]),
                        ),
                        Positioned(
                          bottom: 55.h,
                          child: CircleAvatar(
                            radius: 10.w,
                            backgroundColor: Color.fromARGB(255, 226, 221, 221),
                            child: CircleAvatar(
                              radius: 9.3.w,
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
                                  color: AppColor.darkBlue,
                                  fontFamily: FontFamily.maloryLight,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Container(
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isImageSaveSelected.value = true;
                          controller.isWhatsAppSelected.value = false;
                          controller.isEmailSelected.value = false;
                          controller.takeScreenShot();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Container(
                                height: 6.h,
                                width: 13.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: controller.isImageSaveSelected
                                                    .value ==
                                                true
                                            ? .5
                                            : 1.0,
                                        color: controller.isImageSaveSelected
                                                    .value ==
                                                true
                                            ? AppColor.accentTorquise
                                            : Color.fromARGB(
                                                255, 177, 174, 174))),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  CustomIcons.upload,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "Save image",
                              style: TextStyle(
                                color: AppColor.darkBlue,
                                fontFamily: FontFamily.maloryLight,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isImageSaveSelected.value = false;
                          controller.isWhatsAppSelected.value = true;
                          controller.isEmailSelected.value = false;
                          controller.openWhatsapp(
                              context: context,
                              text: "hi hello",
                              number: "+639770997057");
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Container(
                                height: 6.h,
                                width: 13.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: controller
                                                    .isWhatsAppSelected.value ==
                                                true
                                            ? .8.w
                                            : 1.0,
                                        color: controller
                                                    .isWhatsAppSelected.value ==
                                                true
                                            ? AppColor.accentTorquise
                                            : Color.fromARGB(
                                                255, 177, 174, 174))),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  CustomIcons.whatsapp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "Whatsapp",
                              style: TextStyle(
                                color: AppColor.darkBlue,
                                fontFamily: FontFamily.maloryLight,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isImageSaveSelected.value = false;
                          controller.isWhatsAppSelected.value = false;
                          controller.isEmailSelected.value = true;
                          controller.sendEmail();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Container(
                                height: 6.h,
                                width: 13.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width:
                                        controller.isEmailSelected.value == true
                                            ? .8.w
                                            : 1.0,
                                    color: controller.isEmailSelected.value ==
                                            true
                                        ? AppColor.accentTorquise
                                        : Color.fromARGB(255, 177, 174, 174),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  CustomIcons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              "Email",
                              style: TextStyle(
                                color: AppColor.darkBlue,
                                fontFamily: FontFamily.maloryLight,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }

  static showEditProfileBottomSheet(
      {required BuildContext context,
      required AccountScreenScreenController controller}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              height: 94.h,
              padding: EdgeInsets.only(left: 0.w, top: 5.w, right: 0.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Obx(
                () => Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios_new_rounded)),
                    elevation: controller.scrollPosition.value > 90 ? 1.5 : 0.0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      )
                    ],
                  ),
                  body: Container(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 7.w,
                                backgroundColor: Colors.grey,
                                child: CircleAvatar(
                                  radius: 6.5.w,
                                  backgroundImage: NetworkImage(
                                      "https://i0.wp.com/thatrandomagency.com/wp-content/uploads/2021/06/headshot.png?resize=618%2C617&ssl=1"),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Ellen Degeneres",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp),
                                      ),
                                      SizedBox(
                                        height: .3.h,
                                      ),
                                      Text(
                                        "address@gmail.com",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 9.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "Your name",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: .5.h,
                          ),
                          Container(
                            height: 7.h,
                            width: 100.w,
                            child: TextField(
                              obscureText: false,
                              controller: controller.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  letterSpacing: 2),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                // hintText: 'Ellen Degeneres',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Position",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: .5.h,
                          ),
                          Container(
                            height: 7.h,
                            width: 100.w,
                            child: TextField(
                              obscureText: false,
                              controller: controller.position,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  letterSpacing: 2),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                // hintText: 'Ellen Degeneres',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Company",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: .5.h,
                          ),
                          Container(
                            height: 7.h,
                            width: 100.w,
                            child: TextField(
                              obscureText: false,
                              controller: controller.company,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  letterSpacing: 2),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                // hintText: 'Ellen Degeneres',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: .5.h,
                          ),
                          Container(
                            height: 7.h,
                            width: 100.w,
                            child: TextField(
                              obscureText: false,
                              controller: controller.emailaddress,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  letterSpacing: 2),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                // hintText: 'Ellen Degeneres',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price unit",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: .5.h,
                                  ),
                                  Container(
                                    height: 7.h,
                                    width: 30.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.accentTorquise,
                                            width: .5.w),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Obx(
                                      () => DropdownButton<String>(
                                        value: controller.dropdownValue.value,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 15.sp,
                                        elevation: 16,
                                        isExpanded: true,
                                        style: TextStyle(
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.black,
                                            fontSize: 9.sp),
                                        underline: SizedBox(),
                                        onChanged: (String? value) {
                                          controller.dropdownValue.value =
                                              value!;
                                        },
                                        items: <String>['+123', '+163']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Telephone",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: .5.h,
                                  ),
                                  Container(
                                    height: 7.h,
                                    width: 56.w,
                                    child: TextField(
                                      // controller: controller.username,
                                      controller: controller.telephone,
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[11234567890]'))
                                      ],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9.sp,
                                          letterSpacing: 2),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.accentTorquise,
                                                width: .5.w),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.accentTorquise,
                                                width: .5.w),
                                            borderRadius:
                                                BorderRadius.circular(6)),

                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.accentTorquise,
                                                width: .5.w),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        // hintText: 'Ellen Degeneres',
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Country",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13.sp),
                          ),
                          SizedBox(
                            height: .5.h,
                          ),
                          Container(
                            height: 7.h,
                            width: 100.w,
                            child: TextField(
                              obscureText: false,
                              controller: controller.country,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  letterSpacing: 2),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.accentTorquise,
                                        width: .5.w),
                                    borderRadius: BorderRadius.circular(6)),
                                // hintText: 'Ellen Degeneres',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 8.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: AppColor.accentTorquise,
                                borderRadius: BorderRadius.circular(13),
                                // border: Border.all(color: Colors.black54),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Save changes",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
