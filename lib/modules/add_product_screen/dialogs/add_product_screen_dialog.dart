import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/modules/add_product_screen/model/add_product_model.dart';

import '../../../constant/colors_class.dart';
import '../controller/add_product_controller.dart';

class AddProductDialog {
  static showDialogForColorPicker(
      {required AddProductController controller}) async {
    Get.dialog(
      AlertDialog(
        contentPadding:
            EdgeInsets.only(left: 3.w, right: 3.w, top: 2.h, bottom: 0.h),
        content: Container(
          height: 72.h,
          width: 80.w,
          child: Column(
            children: [
              ColorPicker(
                pickerColor: controller.pickedColor,
                onColorChanged: (value) {
                  controller.pickedColor = value;
                  print(value);
                  print(value.red.toString() +
                      " " +
                      value.green.toString() +
                      "  " +
                      value.blue.toString() +
                      "  " +
                      value.alpha.toString());
                },
              ),
              InkWell(
                onTap: () {
                  controller.colorList.add(ColorModels(
                      colorPick: controller.pickedColor,
                      colorName: controller.pickedColor.toString()));
                  Get.back();
                },
                child: Container(
                    height: 6.5.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                        color: Colors.white,
                        border: Border.all(color: AppColor.black),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "DONE",
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                          fontSize: 13.sp),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showDialogPasteLink({required AddProductController controller}) async {
    Get.dialog(
      AlertDialog(
        content: Container(
          height: 18.h,
          width: 90.w,
          child: Column(
            children: [
              SizedBox(
                height: .5.h,
              ),
              Container(
                height: 7.h,
                width: 100.w,
                child: TextField(
                  controller: controller.pasteLinkEditior,
                  obscureText: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      letterSpacing: 2),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    labelText: 'Url/Link',
                    hintText: 'https://images-link.com',
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  if (controller.pasteLinkEditior.text.isNotEmpty) {
                    controller.addImages_from_network(
                        urlLink: controller.pasteLinkEditior.text);

                    Get.back();
                  } else {
                    Get.back();
                    Get.snackbar(
                      "Message",
                      "Please provide link",
                      colorText: Colors.white,
                      backgroundColor: AppColor.redAccent,
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                },
                child: Container(
                    height: 6.5.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                        color: Colors.white,
                        border: Border.all(color: AppColor.black),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "DONE",
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black,
                          fontSize: 13.sp),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
