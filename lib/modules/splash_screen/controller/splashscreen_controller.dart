import 'dart:async';

import 'package:get/get.dart';
import 'package:yoooto/services/storage_services.dart';

import '../../bottom_navigation_screen/view/bottomnav_view.dart';
import '../../login_and_register_screen/view/pre_login_and_register_view.dart';

// import '../api/splashscreen_api.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    timerNavigate();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  timerNavigate() async {
    Timer(Duration(seconds: 3), () async {
      if (Get.find<StorageServices>().storage.read('id') == null) {
        Get.offAll(() => PreLoginView());
        print(
            "here age null ang id it means null ang token and authentication");
      } else {
        // await SplashscreenApi.relogin();
        var expirationDate = DateTime.parse(
            Get.find<StorageServices>().storage.read('expirationDate'));
        if (expirationDate.isBefore(DateTime.now()) == true) {
          print("here age expire na");
          Get.find<StorageServices>().removeStorageCredentials();
          Get.offAll(() => PreLoginView());
        } else {
          print("here dli pa expire");
          Get.offAll(() => BottomNavigationBarView());
        }
      }
    });
  }
}
