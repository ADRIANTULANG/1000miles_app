import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../services/headers_services.dart';
import '../../../services/storage_services.dart';

class BottomNavigationScreenApi {
  static var client = http.Client();

//<List<DeceasedModel>>
  static Future getUsersTeam() async {
    try {
      //572
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var response = await client.get(
          Uri.parse('${AppEndpoint.endPointDomain}/team'),
          headers: newheaders);
      print("getUsersTeam ${response.statusCode}");
      if (response.statusCode == 200) {
        await Get.find<HeadersServices>().updateCookie(response);
        return jsonDecode(response.body);
        // return teamModelFromJson(jsonEncode(jsonDecode(response.body)));
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return [];
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get Team Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get Team Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } catch (e) {
      // Get.snackbar(
      //   "Get Team Error",
      //   "Oops, something went wrong. Please try again later.",
      //   colorText: Colors.white,
      //   backgroundColor: AppColor.accentTorquise,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      return [];
    }
  }

  static Future createProject(
      {required String projectName,
      required List tags,
      required String team}) async {
    try {
      Map body = {"name": projectName};
      if (team != "") {
        body.addAll({"teamId": team});
      }

      if (tags.isNotEmpty) {
        body.addAll({"tags": tags});
      }
      print(
          " ${Get.find<StorageServices>().storage.read("refreshToken").toString()}");
      print(
          "authorization ${Get.find<StorageServices>().storage.read("authorization").toString()}");
      var bodypass = json.encode(body);
      print(bodypass);
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders.addAll(
          {'Content-Type': 'application/json', 'Accept': 'application/json'});
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/project/'),
          body: bodypass,
          headers: newheaders);

      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        List data = [];
        if (Get.find<StorageServices>().storage.read('data') != null) {
          List oldData = Get.find<StorageServices>().storage.read('data');
          print(oldData.length);
          oldData.insert(0, jsonDecode(response.body));
          await Get.find<StorageServices>()
              .saveLocalDataForCaching(data: oldData);
        } else {
          List list = [];
          list.insert(0, jsonDecode(response.body));
          await Get.find<StorageServices>().saveLocalDataForCaching(data: list);
        }

        data.add(jsonDecode(response.body)['id']);
        data.add(jsonDecode(response.body)['name']);
        print(Get.find<StorageServices>().storage.read('data').length);
        return data;
        // return variantDetailsModelFromJson(
        //     jsonEncode(jsonDecode(response.body)));
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Create Project Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Create Project Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Create Project Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future getUserDetails() async {
    try {
      var response = await client.get(
          Uri.parse('${AppEndpoint.endPointDomain}/user/account'),
          headers: {
            "Cookie":
                "csrftoken=${Get.find<StorageServices>().storage.read('cookie')}; sessionid=${Get.find<StorageServices>().storage.read('sessionID')}",
            "X-CSRFToken":
                Get.find<StorageServices>().storage.read('cookie').toString(),
          });

      if (response.statusCode == 200) {
        print(response.body);
        // return userDetailsFromJson(response.body);
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get User Details Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get User Details Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      print(e);
      Get.snackbar(
        "Get User Details Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
