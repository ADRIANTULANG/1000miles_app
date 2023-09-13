import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/modules/add_product_screen/dialogs/add_product_screen_dialog.dart';

import '../../dropbox_screen/view/drop_box_screen_view.dart';
import '../controller/add_product_controller.dart';
import '../model/add_product_model.dart';

class AddProductsView extends GetView<AddProductController> {
  const AddProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddProductController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 7.h,
              ),
              Text(
                "Add Product",
                style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "Product name",
                style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                    fontSize: 9.sp),
              ),
              SizedBox(
                height: .5.h,
              ),
              Container(
                height: 7.h,
                width: 100.w,
                child: TextField(
                  // controller: controller.username,
                  obscureText: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 9.sp,
                      letterSpacing: 2),
                  decoration: InputDecoration(
                    hintText: "Enter name here",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Product price",
                style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                    fontSize: 9.sp),
              ),
              SizedBox(
                height: .5.h,
              ),
              Container(
                height: 7.h,
                width: 100.w,
                child: TextField(
                  // controller: controller.username,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[11234567890.]'))
                  ],
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 9.sp,
                      letterSpacing: 2),
                  decoration: InputDecoration(
                    hintText: "Enter amount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
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
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                            fontSize: 9.sp),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Container(
                        height: 7.h,
                        width: 43.w,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
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
                              controller.dropdownValue.value = value!;
                            },
                            items: <String>['USD', 'PHP']
                                .map<DropdownMenuItem<String>>((String value) {
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
                        "Type of price",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                            fontSize: 9.sp),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Container(
                        height: 7.h,
                        width: 43.w,
                        child: TextField(
                          // controller: controller.username,
                          obscureText: false,
                          // keyboardType: TextInputType.number,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(
                          //       RegExp('[11234567890.]'))
                          // ],
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 9.sp,
                              letterSpacing: 2),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              hintText: "E.g retail / purchase"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Pick Category",
                style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                    fontSize: 9.sp),
              ),
              SizedBox(
                height: .5.h,
              ),
              Container(
                height: 7.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6)),
                child: Obx(
                  () => DropdownButton(
                    value: controller.defaultCategoryValue.value,
                    iconSize: 15.sp,
                    elevation: 16,
                    isExpanded: true,
                    style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                        fontSize: 9.sp),
                    underline: SizedBox(),
                    items: controller.categoryList
                        .map((ProductCategoryModel value) {
                      return DropdownMenuItem(
                        value: value.categoryName,
                        child: Row(
                          children: [
                            value.categoryIcon,
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              value.categoryName.value,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      controller.defaultCategoryValue.value = value.toString();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Radio(
                            value: "F",
                            groupValue: controller.radioGroupValue.value,
                            onChanged: (value) {
                              controller.radioGroupValue.value = value!;
                            }),
                      ),
                      Text(
                        "F",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                            fontSize: 9.sp),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Radio(
                            value: "M",
                            groupValue: controller.radioGroupValue.value,
                            onChanged: (value) {
                              controller.radioGroupValue.value = value!;
                            }),
                      ),
                      Text(
                        "M",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                            fontSize: 9.sp),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Radio(
                            value: "Child",
                            groupValue: controller.radioGroupValue.value,
                            onChanged: (value) {
                              controller.radioGroupValue.value = value!;
                            }),
                      ),
                      Text(
                        "Child",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                            fontSize: 9.sp),
                      ),
                      SizedBox(
                        width: 1.w,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                child: Obx(
                  () => controller.imagesList.length == 0
                      ? DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 1,
                          dashPattern: [3],
                          child: Container(
                            height: 25.h,
                            width: 100.w,
                            child: Icon(
                              Icons.image,
                              size: 40.sp,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.only(top: 1.h),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 2.w,
                                  mainAxisSpacing: 1.h),
                          itemCount: controller.imagesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                controller.imagesList[index].isLink == true
                                    ? Container(
                                        width: 20.w,
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(controller
                                              .imagesList[index].imagePath),
                                          errorBuilder: (context, exception,
                                                  stackTrack) =>
                                              Icon(
                                            Icons.error,
                                            color: AppColor.redAccent,
                                          ),
                                        ))
                                    : Container(
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(controller
                                                    .imagesList[index]
                                                    .imagePath)))),
                                      ),
                                Positioned(
                                    right: 1.w,
                                    top: .05.h,
                                    child: InkWell(
                                      onTap: () {
                                        controller.imagesList.removeAt(index);
                                      },
                                      child: Container(
                                        height: 3.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                        child: Icon(
                                          Icons.clear_outlined,
                                          size: 13.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ))
                              ],
                            );
                          },
                        ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.addImages_from_gallery();
                      },
                      child: Container(
                        height: 6.5.h,
                        width: 26.w,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 8.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    0.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open_outlined,
                              color: AppColor.white,
                              size: 13.sp,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              "Browse files",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white,
                                  fontSize: 7.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.addImages_camera();
                      },
                      child: Container(
                        height: 6.5.h,
                        width: 29.w,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 8.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    0.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              color: AppColor.white,
                              size: 13.sp,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              "Open Camera",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white,
                                  fontSize: 7.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.pasteLinkEditior.clear();
                        FocusScope.of(context).unfocus();
                        AddProductDialog.showDialogPasteLink(
                            controller: controller);
                      },
                      child: Container(
                        height: 6.5.h,
                        width: 29.w,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 8.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    0.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.link_outlined,
                              color: AppColor.white,
                              size: 13.sp,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              "Paste link",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white,
                                  fontSize: 8.sp),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => DropBox());
                    },
                    child: Container(
                      height: 6.5.h,
                      width: 43.w,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  0.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.square,
                            color: AppColor.white,
                            size: 13.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Drop box",
                            style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                                fontSize: 7.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Get.to(() => GoogleDriveView());
                    },
                    child: Container(
                      height: 6.5.h,
                      width: 43.w,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  0.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.storage,
                            color: AppColor.white,
                            size: 13.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "GDrive",
                            style: TextStyle(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                                fontSize: 7.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.colorList.length == 0
                    ? SizedBox()
                    : Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 5.h,
                            child: Obx(
                              () => ListView.builder(
                                itemCount: controller.colorList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 1.w),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: controller
                                              .colorList[index].colorPick,
                                        ),
                                        Positioned(
                                            child: Container(
                                          height: 3.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black),
                                          child: Icon(
                                            Icons.clear_outlined,
                                            size: 11.sp,
                                            color: Colors.white,
                                          ),
                                        ))
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
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  AddProductDialog.showDialogForColorPicker(
                      controller: controller);
                },
                child: Container(
                  height: 6.5.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 8.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              0.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: AppColor.white,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "Pick Color",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white,
                            fontSize: 11.sp),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 6.5.h,
                        width: 30.w,
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
                          "Exit",
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: AppColor.black,
                              fontSize: 13.sp),
                        )),
                    Container(
                        height: 6.5.h,
                        width: 56.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 8.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    0.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                            color: AppColor.blueAccent,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          "Save product card",
                          style: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                              fontSize: 13.sp),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
