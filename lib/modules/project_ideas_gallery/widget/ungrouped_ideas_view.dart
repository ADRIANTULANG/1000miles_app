import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant/colors_class.dart';
import '../../../constant/font_family_class.dart';
import '../../../constant/icons_class.dart';
import '../controller/project_ideas_gallery_controller.dart';
import '../items/ungroup_item.dart';

class UngroupedIdeasView extends GetView<ProjectIdeasGalleryController> {
  const UngroupedIdeasView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.ungrouped_list.length == 0
          ? Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    CustomIcons.projectbigsize,
                    color: AppColor.greyBlue,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Lets add content to your\nproject via tool below",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: FontFamily.maloryLight,
                        fontWeight: FontWeight.w400,
                        color: AppColor.greyBlue,
                        fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Obx(
                () => GridView.builder(
                  controller: controller.scrollController_ungrouped,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2.5.h,
                      crossAxisSpacing: 2.w),
                  itemCount: controller.ungrouped_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UngroupedItem(
                      groupID: "",
                      ideaID: controller.ungrouped_list[index].groupIdOrIdeaId,
                      index: index,
                      image: controller.ungrouped_list[index].ideaFileImage,
                      name: controller
                          .ungrouped_list[index].ideaNameOrIdeaGroupname,
                    );
                  },
                ),
              ),
            ),
    );
  }
}
