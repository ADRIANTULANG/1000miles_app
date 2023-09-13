import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedScreenController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxDouble scrollPosition = 0.0.obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    scrollController.addListener(() {
      scrollPosition.value = scrollController.position.pixels;
      print(scrollPosition.value);
    });
    super.onInit();
  }
}
