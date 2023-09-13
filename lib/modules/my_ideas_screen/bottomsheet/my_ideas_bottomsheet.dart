import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../../select_photo_for_idea_screen/controller/select_photo_for_idea_controller.dart';
import '../../select_photo_for_idea_screen/view/select_photo_for_idea_camera_view.dart';
import '../../select_photo_for_idea_screen/model/select_photo_for_idea_model.dart';
import '../controller/my_ideas_controller.dart';
import '../model/my_ideas_move_copy_images_model.dart';
import '../view/my_ideas_move_or_copy.dart';

class MyIdeasBottomSheet {
  static showBottomSheetButtonAndroid(
      {required MyIdeasController controller, required String groupID}) {
    Get.bottomSheet(Container(
      height: 15.h,
      width: 100.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final List<XFile>? images = await picker.pickMultiImage();
              if (images == null) {
                Get.back();
              } else if (images.length == 0) {
                Get.back();
              } else {
                Get.back();
                Get.to(() => CameraIdeaScreenView(), arguments: {
                  "isSavetoMyIdeas": true,
                  "isFromHomescreen": false,
                  "projectID": "",
                  "projectName": "",
                  "groupID": groupID
                });
                Future.delayed(Duration(seconds: 1), () async {
                  for (var i = 0; i < images.length; i++) {
                    File file = await File(images[i].path);

                    int quality = 70;
                    int percentage = 70;
                    final bytes = file.readAsBytesSync().lengthInBytes;
                    final kb = bytes / 1024;

                    if (kb > 900) {
                      quality = 30;
                      percentage = 30;
                    } else if (kb < 900 && kb > 300) {
                      quality = 50;
                      percentage = 50;
                    }

                    print(quality.toString() + "  " + percentage.toString());

                    File compressedFile =
                        await FlutterNativeImage.compressImage(file.path,
                            quality: quality, percentage: percentage);

                    final kbnew =
                        compressedFile.readAsBytesSync().lengthInBytes / 1024;
                    print("image size is $kbnew KB");

                    PicturesIdeaModel map = PicturesIdeaModel(
                        path: compressedFile.path,
                        isFirst: false,
                        isLast: false,
                        isSelected: false.obs);

                    Get.find<SelectIdeaPhotoController>()
                        .storageImages
                        .add(map);
                  }
                });
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.addimages,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Choose from Library",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.darkBlue,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          InkWell(
            onTap: () {
              Get.back();
              Get.to(() => CameraIdeaScreenView(), arguments: {
                "isSavetoMyIdeas": true,
                "isFromHomescreen": false,
                "projectID": "",
                "projectName": "",
                "groupID": groupID
              });
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  CustomIcons.camera,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Take a photo",
                  style: TextStyle(
                    fontFamily: FontFamily.maloryBold,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColor.darkBlue,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  static moveBottomSheet(
      {required MyIdeasController controller,
      required List<ImagesModel> imageList,
      required String previousBoardID}) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 20.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  await controller.getMyIdeasGroups();
                  await controller.getProjectsAndIdeaBoards();
                  controller.isShowProjects.value = false;
                  controller.isMyIdeasBoards.value = false;
                  Get.to(() => MyIdeasMoveOrCopyIdeas(
                        previousBoardID: previousBoardID,
                        imagesList: imageList,
                        moveOrCopy: "copy",
                      ));
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Save a copy to..",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await controller.getMyIdeasGroups();
                  await controller.getProjectsAndIdeaBoards();
                  controller.isShowProjects.value = false;
                  controller.isMyIdeasBoards.value = false;
                  Get.to(() => MyIdeasMoveOrCopyIdeas(
                        previousBoardID: previousBoardID,
                        imagesList: imageList,
                        moveOrCopy: "move",
                      ));
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Move to..",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100.w,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: FontFamily.maloryBold,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.darkBlue,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
