import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';

import '../controller/login_and_register_screen_controller.dart';

class ConfirmOTPvIEW extends GetView<LoginRegisterController> {
  const ConfirmOTPvIEW({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 100.h,
          width: 100.w,
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 100.w, child: Image.asset("assets/images/1.5x.png")),
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: 100.w,
                child: Text(
                  "Check your email for a code",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                width: 100.w,
                child: Text(
                  "We've sent 6-character code to \n${controller.register_email.text}. \nThe code expires shortly,so please eneter it soon",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 180, 179, 179),
                    fontSize: 11.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Obx(
                () => controller.isConfirmingOtp.value == false
                    ? OtpTextField(
                        clearText: controller.optClear.value,
                        numberOfFields: 6,
                        borderColor: AppColor.accentTorquise,
                        fillColor: AppColor.accentTorquise,
                        focusedBorderColor: AppColor.accentTorquise,
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) async {
                          controller.optClear.value = true;
                          await controller.confirm_otp(code: verificationCode);
                          controller.optClear.value = false;
                          // controller.optClear.value = false;
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return AlertDialog(
                          //         title: Text("Verification Code"),
                          //         content: Text('Code entered is $verificationCode'),
                          //       );
                          //     });
                        }, // end onSubmit
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              SizedBox(
                height: 6.h,
              ),
            ],
          )),
    );
  }
}
