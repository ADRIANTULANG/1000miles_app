import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Dragable_model.dart';

class DragableController extends GetxController {
  List colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.black,
  ];

  RxList<DragableModel> listDragable = <DragableModel>[].obs;
  RxList<DragableModel> listDragable_tmp = <DragableModel>[].obs;
  var data = [
    {
      "group_product_name": "headphone",
      "group_product_image":
          "https://img.freepik.com/free-photo/pink-headphones-wireless-digital-device_53876-96804.jpg?w=2000"
    },
    {
      "group_product_name": "controller",
      "group_product_image":
          "https://eu.aimcontrollers.com/wp-content/uploads/2022/09/ps5-900px.jpg"
    },
    {
      "group_product_name": "camera",
      "group_product_image":
          "https://i.pcmag.com/imagery/roundups/018cwxjHcVMwiaDIpTnZJ8H-51..v1637092108.jpg"
    },
    {
      "group_product_name": "mouse",
      "group_product_image":
          "https://www.howtogeek.com/wp-content/uploads/2017/06/gaming-mouse-with-a-blue-glow.jpeg?height=200p&trim=2,2,2,2"
    },
    {
      "group_product_name": "phone",
      "group_product_image":
          "https://media.wired.com/photos/62d75d34ddaaa99a1df8e61d/master/pass/Phone-Camera-Webcam-Gear-GettyImages-1241495650.jpg"
    },
    {
      "group_product_name": "speakers",
      "group_product_image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnDSZ1mynt7b4I8lOi-xSSzPJui_W2nMDgLQ&usqp=CAU"
    },
    {
      "group_product_name": "laptop",
      "group_product_image":
          "https://i.pcmag.com/imagery/reviews/02lcg0Rt9G3gSqCpWhFG0o1-2..v1656623239.jpg"
    }
  ];

  @override
  void onInit() {
    listDragable.assignAll(dragableModelFromJson(jsonEncode(data)));
    listDragable_tmp.assignAll(dragableModelFromJson(jsonEncode(data)));
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
