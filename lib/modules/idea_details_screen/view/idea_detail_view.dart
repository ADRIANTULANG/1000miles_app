import 'package:cached_network_image/cached_network_image.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/config/endpoints.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/services/storage_services.dart';
import '../../../constant/colors_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/idea_details_controller.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

import '../dialog/idea_detail_dialog.dart';

class IdeaDetailView extends GetView<IdeaDetailController> {
  const IdeaDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(IdeaDetailController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Container(
                height: 7.h,
                width: 100.w,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 10.w,
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          CustomIcons.arrowback,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 3.w),
                        alignment: Alignment.center,
                        child: Entry.all(
                          child: Obx(
                            () => Text(
                              controller.ideaName.value == ""
                                  ? "Unnamed idea"
                                  : controller.ideaName.value,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColor.darkBlue,
                                  fontFamily: FontFamily.maloryBold,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 10.w,
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton(
                        offset: Offset(-20, 0),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: AppColor.grey, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              padding: EdgeInsets.zero,
                              enabled: false, // DISABLED THIS ITEM
                              child: Container(
                                height: 11.h,
                                width: 32.w,
                                // padding:
                                //     EdgeInsets.only(
                                //         top: 2.h),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        MyIdeasDialog.showEditIdeaName(
                                            ideaname: controller.ideaName.value,
                                            controller: controller);
                                      },
                                      child: Container(
                                        width: 100.w,
                                        padding: EdgeInsets.only(
                                          left: 5.w,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              CustomIcons.editwithbox,
                                              color: AppColor.darkBlue,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              "Rename",
                                              style: TextStyle(
                                                  color: AppColor.darkBlue,
                                                  fontFamily:
                                                      FontFamily.maloryBold,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        MyIdeasDialog.showDeleteConfirmation(
                                            ideaname: controller.ideaName.value,
                                            controller: controller);
                                      },
                                      child: Container(
                                        width: 100.w,
                                        padding: EdgeInsets.only(
                                          left: 5.w,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              CustomIcons.archived,
                                              color: AppColor.darkBlue,
                                            ),
                                            SizedBox(
                                              width: 3.5.w,
                                            ),
                                            Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: AppColor.darkBlue,
                                                  fontFamily:
                                                      FontFamily.maloryBold,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ];
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColor.darkBlue,
                              fontFamily: FontFamily.maloryLight,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        Obx(
                          () => controller.ideaFileImage.value == ""
                              ? Container(
                                  height: 45.h,
                                  width: 100.w,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 35.w, right: 35.w),
                                      child: Lottie.asset(
                                          "assets/loading/animation.json"),
                                    ),
                                  ),
                                )
                              : CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: AppEndpoint.endPointFile +
                                      "" +
                                      controller.ideaFileImage.value.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 45.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5.sp,
                                          color: AppColor.greyBlue),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    height: 45.h,
                                    width: 100.w,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 35.w, right: 35.w),
                                        child: Lottie.asset(
                                            "assets/loading/animation.json"),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: 45.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/images/transparent.jpg"))),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          width: 100.w,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                            ),
                            child: Entry.offset(
                              xOffset: -1000,
                              yOffset: 0,
                              child: Obx(
                                () => Text(
                                  controller.ideaName.value == ""
                                      ? "Unnamed idea"
                                      : controller.ideaName.value,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColor.darkBlue,
                                      fontFamily: FontFamily.maloryBold,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => controller.ideaVotes.length == 0
                                    ? Text(
                                        "0 votes.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: FontFamily.maloryBold,
                                            fontSize: 12.sp,
                                            color: AppColor.darkBlue),
                                      )
                                    : Container(
                                        width: controller.ideaVotes.length == 1
                                            ? 11.w
                                            : 27.w,
                                        height: 5.h,
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          children: [
                                            for (var stackindex = 0;
                                                stackindex <
                                                    (controller.ideaVotes
                                                                .length >
                                                            3
                                                        ? 4
                                                        : controller
                                                            .ideaVotes.length);
                                                stackindex++) ...[
                                              stackindex == 3 &&
                                                      controller.ideaVotes
                                                              .length >
                                                          3
                                                  ? Positioned(
                                                      left: stackindex == 0
                                                          ? 0.w
                                                          : (stackindex * 5.w),
                                                      child: CircleAvatar(
                                                        radius: 5.5.w,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: CircleAvatar(
                                                          radius: 5.w,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: Text(
                                                            (controller.ideaVotes
                                                                            .length -
                                                                        3)
                                                                    .toString() +
                                                                "+",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Positioned(
                                                      left: stackindex == 0
                                                          ? 0.w
                                                          : (stackindex * 5.w),
                                                      child: CircleAvatar(
                                                        radius: 5.5.w,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: CircleAvatar(
                                                          radius: 5.w,
                                                          // backgroundColor: controller.colorList[controller.getRandom()],
                                                          backgroundColor:
                                                              AppColor
                                                                  .accentTorquise,
                                                          child: Text(
                                                            controller
                                                                .ideaVotes[
                                                                    stackindex]
                                                                .createdBy
                                                                .email[0]
                                                                .capitalizeFirst
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ],
                                        ),
                                      ),
                              ),
                              Obx(
                                () => controller.isLike.value == false
                                    ? InkWell(
                                        onTap: () {
                                          controller.voteIdea();
                                        },
                                        child: SvgPicture.asset(
                                          CustomIcons.likes,
                                          color: AppColor.grey,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          controller.voteIdea();
                                        },
                                        child: SvgPicture.asset(
                                          CustomIcons.likes,
                                          color: AppColor.accentTorquise,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Obx(
                            () => controller.ideaComments.length == 0
                                ? Container(
                                    width: 100.w,
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        SvgPicture.asset(
                                          CustomIcons.comments,
                                          color: AppColor.greyBlue,
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "No comments yet.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: FontFamily.maloryBold,
                                              fontSize: 16.sp,
                                              color: AppColor.greyBlue),
                                        ),
                                        Text(
                                          "Be the first to comment.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: FontFamily.maloryBold,
                                              fontSize: 12.sp,
                                              color: AppColor.greyBlue),
                                        ),
                                      ],
                                    )),
                                  )
                                : Obx(
                                    () => ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.ideaComments.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        controller.globalKeys.add(
                                            GlobalKey<FlutterMentionsState>());
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 2.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: CircleAvatar(
                                                  radius: 6.w,
                                                  backgroundColor:
                                                      AppColor.white,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        AppColor.accentTorquise,
                                                    radius: 5.5.w,
                                                    child: Text(
                                                      controller
                                                          .ideaComments[index]
                                                          .createdBy
                                                          .email[0]
                                                          .toString()
                                                          .capitalizeFirst
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .maloryBold,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColor.white,
                                                      ),
                                                    ),
                                                  ),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 1.h),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: controller.setMentionCollored(
                                                              comment: controller.commentIdentifier(
                                                                  comment: controller
                                                                      .ideaComments[
                                                                          index]
                                                                      .comment)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: 100.w,
                                                      child: Text(
                                                        DateFormat.jm()
                                                            .format(controller
                                                                .ideaComments[
                                                                    index]
                                                                .createdAt)
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                FontFamily
                                                                    .maloryLight,
                                                            fontSize: 10.sp,
                                                            color:
                                                                AppColor.grey),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                height: 9.h,
                width: 100.w,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: AppColor.greyBlue,
                ))),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 6.w,
                      backgroundColor: AppColor.white,
                      child: CircleAvatar(
                        backgroundColor: AppColor.accentTorquise,
                        radius: 5.5.w,
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
                    SizedBox(
                      width: 2.w,
                    ),
                    // Container(
                    //   height: 6.5.h,
                    //   width: 65.w,
                    //   child: TextField(
                    //     obscureText: false,
                    //     style: TextStyle(
                    //       color: AppColor.darkBlue,
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 14.sp,
                    //       fontFamily: FontFamily.maloryLight,
                    //     ),

                    //   ),
                    // ),
                    Container(
                      height: 10.h,
                      width: 65.w,
                      alignment: Alignment.center,
                      child: Obx(
                        () => FlutterMentions(
                          onChanged: (value) {
                            controller.isMatchedAll.value = true;
                            print(controller.mention_key.currentState!
                                .controller!.markupText
                                .toString());
                            Future.delayed(Duration(seconds: 1), () {
                              controller.isMatchedAll.value = false;
                            });
                          },
                          key: controller.mention_key,
                          suggestionPosition: SuggestionPosition.Top,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: .5.h, bottom: .5.h, left: 4.w),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: AppColor.grey),
                                borderRadius: BorderRadius.circular(8)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: AppColor.accentTorquise),
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Write a comment',
                            hintStyle: TextStyle(
                                color: AppColor.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                fontFamily: FontFamily.maloryLight),
                          ),
                          mentions: [
                            Mention(
                                markupBuilder: (trigger, mention, value) {
                                  return trigger + "~" + mention + "~";
                                },
                                trigger: '@',
                                style:
                                    TextStyle(color: AppColor.accentTorquise),
                                data: controller.mentions,
                                matchAll: controller.isMatchedAll.value,
                                suggestionBuilder: (data) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 2.h, top: 2.h),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: 3.5.w,
                                        right: 5.w,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundColor:
                                                AppColor.accentTorquise,
                                            child: Text(
                                              data['full_name'][0],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                  color: AppColor.white,
                                                  fontFamily:
                                                      FontFamily.maloryBold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                data['display'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp,
                                                    color: AppColor.darkBlue,
                                                    fontFamily:
                                                        FontFamily.maloryBold),
                                              ),
                                              Text(
                                                data['email'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    color: AppColor.darkBlue,
                                                    fontFamily:
                                                        FontFamily.maloryLight),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          FocusScope.of(context).unfocus();

                          String stringtopass = controller
                              .mention_key.currentState!.controller!.markupText
                              .toString();
                          controller.mention_key.currentState!.controller!
                              .clear();

                          await controller.createComment(comment: stringtopass);
                          controller.scrollController.jumpTo(controller
                                  .scrollController.position.maxScrollExtent +
                              100);
                          // controller.setMentionColloredss();
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            CustomIcons.send,
                            color: AppColor.grey,
                            height: 3.5.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
