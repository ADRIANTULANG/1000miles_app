import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/microsoft_signin_screen_model.dart';

class MicroSoftSignInApi {
  static var client = http.Client();
//
  static Future getProfiledata({required String token}) async {
    try {
      var response = await client
          .get(Uri.parse('https://graph.microsoft.com/v1.0/me'), headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      // print(response.body);
      print(response.statusCode);
      print(response.body);
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get Profile Data Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get Profile Data Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Get Profile Data Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  static Future getUsersData({required String token}) async {
    try {
      var response = await client
          .get(Uri.parse('https://graph.microsoft.com/v1.0/users'), headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      });
      // print(response.body);
      print(response.statusCode);
      print(jsonEncode(jsonDecode(response.body)['value']));
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get  Users Data Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get  Users Data  Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Get  Users Data  Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  static Future<List<MicroSoftUsers>> getUsersFiles(
      {required String token}) async {
    try {
      var response = await client.get(
          // Uri.parse('https://graph.microsoft.com/v1.0/me/drives'),
          // Uri.parse(
          //     'https://graph.microsoft.com/v1.0/sites?select=siteCollection,webUrl&filter=siteCollection/root%20ne%20null'),
          // Uri.parse('https://graph.microsoft.com/v1.0/sites?search=*'),
          Uri.parse('https://graph.microsoft.com/v1.0/me/drive/sharedWithMe'),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          });
      // print(response.body);
      // print(response.statusCode);
      // print(jsonEncode(jsonDecode(response.body)['value']));
      List data = jsonDecode(response.body)['value'];
      for (var i = 0; i < data.length; i++) {
        print(data[i]['name']);
        print(data[i]['webUrl']);
      }
      return microSoftUsersFromJson(
          jsonEncode(jsonDecode(response.body)['value']));
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get Users Files Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get Users Files Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } catch (e) {
      Get.snackbar(
        "Get Users Files Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

//

}
