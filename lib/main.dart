import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/services/headers_services.dart';
import 'package:yoooto/services/storage_services.dart';
import 'modules/splash_screen/view/splashscreen_view.dart';
// import 'package:firebase_core/firebase_core.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.put(StorageServices());

  // await Firebase.initializeApp();
  await Get.put(HeadersServices());

  int currentindex = 0;
  runApp(
    ShowCaseWidget(
      autoPlay: false,
      builder: Builder(
        builder: (context) => MyApp(),
      ),
      onStart: (index, key) {
        print('onStart: $index, $key');
      },
      onComplete: (index, key) {
        if (currentindex == 0) {
        } else if (currentindex == 1) {}
        currentindex++;
        print('onComplete: $index, $key');
      },
      onFinish: () {},
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Portal(
        child: GetMaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'yooox',
            theme: ThemeData(
              primarySwatch: AppColor.blueAccent,
            ),
            home: SplashscreenView()),
      );
    });
  }
}
