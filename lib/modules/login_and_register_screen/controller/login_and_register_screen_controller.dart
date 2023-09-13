import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoooto/modules/login_and_register_screen/api/login_api.dart';

import '../../../constant/colors_class.dart';
import '../../bottom_navigation_screen/view/bottomnav_view.dart';
import '../view/confirm_otp_screen.dart';

class LoginRegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController register_name = TextEditingController();
  TextEditingController register_company = TextEditingController();
  TextEditingController register_email = TextEditingController();
  TextEditingController register_password = TextEditingController();

  RxInt indexSelected = 0.obs;

  RxBool isGettingCredentials = false.obs;
  RxBool isGettingGoogleCredentials = false.obs;

  RxBool isCreatingAccount = false.obs;
  RxBool isConfirmingOtp = false.obs;

  RxBool isLoading = true.obs;

  RxBool isSignInSelected = true.obs;
  RxBool isSignUpSelected = false.obs;

  RxBool isObscurePassword = true.obs;
  RxBool isCheckValue = true.obs;

  RxBool optClear = false.obs;

  // RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  String numbers = "1234567890";
  String capitalLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  CarouselController carouselController = CarouselController();

  RxInt initialPage = 0.obs;

  RxBool isYournameTextEmpty = true.obs;
  RxBool isCompanyTextEmpty = true.obs;
  RxBool isEmailAddressTextEmpty = true.obs;
  RxBool isPasswordTextEmpty = true.obs;

  RxBool isLogiUsernameEmpty = true.obs;
  RxBool isLoginPasswordEmpty = true.obs;

  RxString hasCapitalLetter = "".obs;
  RxString hasNumber = "".obs;
  RxString eightcharactersLong = "".obs;

  RxBool showPasswordInstructions = false.obs;

  RxString isPasswordCorrect = "".obs;

  RxBool isSigninPress = false.obs;
  RxBool isSignupPress = false.obs;
  RxBool isSigninPress_preScreen = false.obs;
  RxBool isSignupPress_preScreen = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  login() async {
    var isSuccess =
        await LoginApi.login(email: email.text, password: password.text);
    if (isSuccess == true) {
      Future.delayed(Duration(milliseconds: 600), () {
        isGettingCredentials(false);
        isSigninPress.value = false;
      });
      Get.offAll(() => BottomNavigationBarView());
    } else if (isSuccess == "Wrong password") {
      isPasswordCorrect.value = "false";
      Future.delayed(Duration(milliseconds: 600), () {
        isGettingCredentials(false);
        isSigninPress.value = false;
      });
    } else {
      isPasswordCorrect.value = "false";
      Future.delayed(Duration(milliseconds: 600), () {
        isGettingCredentials(false);
        isSigninPress.value = false;
      });
    }
  }

  registerToGetOtp() async {
    isCreatingAccount(true);
    var isSuccess = await LoginApi.register_to_get_otp(
        name: register_name.text,
        company: register_company.text,
        email: register_email.text,
        password: register_password.text);
    if (isSuccess == true) {
      Get.to(() => ConfirmOTPvIEW());
    } else {
      Get.snackbar(
        "Message",
        "Email already taken",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.TOP,
      );
    }
    isCreatingAccount(false);
  }

  checkIfContains({required String password}) {
    hasCapitalLetter.value = "false";
    hasNumber.value = "false";
    eightcharactersLong.value = "false";

    for (var i = 0; i < capitalLetters.length; i++) {
      for (var x = 0; x < password.length; x++) {
        if (capitalLetters[i] == password[x]) {
          hasCapitalLetter.value = "true";
        }
      }
    }
    print("has capital letter? ${hasCapitalLetter.value}");
    for (var i = 0; i < numbers.length; i++) {
      for (var x = 0; x < password.length; x++) {
        if (numbers[i] == password[x]) {
          hasNumber.value = "true";
        }
      }
    }
    print("has number ? ${hasNumber.value}");

    if (password.length >= 8) {
      eightcharactersLong.value = "true";
    } else {
      eightcharactersLong.value = "false";
    }
    print("8 characters? ${eightcharactersLong.value}");
  }

  confirm_otp({required String code}) async {
    isConfirmingOtp(true);
    var isSuccess =
        await LoginApi.cofirm_email(email: register_email.text, code: code);
    if (isSuccess == true) {
      isSignInSelected.value = true;
      isSignUpSelected.value = false;
      Get.back();
      Get.back();
      Get.snackbar(
        "Message",
        "Account succesfully created.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      isConfirmingOtp(false);
    }
    isConfirmingOtp(false);
  }
}
