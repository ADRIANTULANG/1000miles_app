import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashscreenController());
    return Scaffold(
      body: Container(
          height: 100.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/splashscreen.png"),
              // Image.asset("assets/images/1.5x.png"),
              // Image.asset("assets/images/barries.png"),
              // SizedBox(
              //   height: 5.h,
              // )
            ],
          )),
    );
  }
}
