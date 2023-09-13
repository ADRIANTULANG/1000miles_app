import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/services/storage_services.dart';
import '../../../config/endpoints.dart';
import '../../../services/headers_services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginApi {
  static var client = http.Client();
//<List<CemeteryList>>
  static Future login({required String email, required String password}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('${AppEndpoint.endPointDomain}/user/sign-in'),
        body: {"email": email, "password": password},
      );

      // print(response.body);
      print(response.statusCode);

      if (response.statusCode == 202 || response.statusCode == 200) {
        await Get.find<HeadersServices>().updateCookie(response);
        var user = await jsonDecode(response.body);
        Get.find<StorageServices>()
            .saveLocalDataMyIdeasForCaching(data: user['userIdeas']);
        Get.find<StorageServices>()
            .saveLocalDataSharedWithMeForCaching(data: user['sharedIdeas']);
        await Get.find<StorageServices>().saveCredentials(
            user: email,
            pass: password,
            name: user["name"].toString(),
            id: user["id"].toString(),
            dateJoined: user["createdAt"].toString(),
            email: user["email"].toString(),
            company: user["company"]["name"] ?? "",
            occupation: user["role"]["name"] ?? "",
            phone: user["phone"] == null ? "" : user["phone"],
            mobile: user["mobile"] == null ? "" : user["mobile"],
            active: user["isDeactivated"] == false
                ? true.toString()
                : false.toString(),
            firstLogin: user["firstLogin"].toString(),
            streetAddress1: user["streetAddress1"] ?? "",
            streetAddress2: user["streetAddress2"] ?? "",
            city: user["city"] ?? "",
            isRegistered: user["isRegistered"].toString());
        // DateTime expirationDate = JwtDecoder.getExpirationDate(
        //     Get.find<StorageServices>().storage.read("refreshToken"));
        var dataDecode = JwtDecoder.decode(
            Get.find<StorageServices>().storage.read("refreshToken"));
        DateTime expirationDate =
            DateTime.fromMillisecondsSinceEpoch(dataDecode['dbExp'] * 1000)
                .toLocal();
        print("Database Expiration Date:" +
            DateFormat.yMMMd().format(expirationDate) +
            " " +
            DateFormat.jm().format(expirationDate));
        Get.find<StorageServices>()
            .saveExpirationDate(expirationDate: expirationDate.toString());
        // return false;
        return true;
      } else if (response.statusCode == 403) {
        return "Wrong password";
      } else if (response.statusCode == 400) {
        return "Wrong password";
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "login Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "login Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      print(e);
      Get.snackbar(
        "login Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

//<List<DeceasedModel>>
  static Future register_to_get_otp({
    required String name,
    required String company,
    required String email,
    required String password,
  }) async {
    try {
      var response = await client.post(
        Uri.parse('${AppEndpoint.endPointDomain}/user/sign-up'),
        body: {
          "name": name,
          "company": company,
          "email": email,
          "password": password
        },
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 202 || response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Register to Get OTP Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Register to Get OTP Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Register to Get OTP Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future cofirm_email({
    required String email,
    required String code,
  }) async {
    try {
      var response = await client.post(
        Uri.parse('${AppEndpoint.endPointDomain}/user/confirm-email'),
        body: {"email": email, "otp": code},
      );
      print(response.statusCode);
      print(response.body);
      print(response.reasonPhrase);
      if (response.statusCode == 202 || response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 406) {
        Get.snackbar(
          "Message",
          "Oops, That code wasn't valid. Give it another go!",
          colorText: Colors.white,
          backgroundColor: AppColor.accentTorquise,
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Confirm OTP Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Confirm OTP Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Confirm OTP Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
