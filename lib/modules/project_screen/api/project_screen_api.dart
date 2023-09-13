import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoooto/services/headers_services.dart';
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import 'package:http_parser/http_parser.dart';

import '../../../services/storage_services.dart';
import '../controller/projects_controller.dart';

class ProjectApi {
  static var client = http.Client();

//<List<DeceasedModel>>

  static Future getRecentlyViewedProjects() async {
    print("refreshToken: " +
        Get.find<StorageServices>().storage.read('refreshToken').toString());
    print("access: " +
        Get.find<StorageServices>().storage.read('authorization').toString());
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      var response = await client.get(
          Uri.parse('${AppEndpoint.endPointDomain}/project'),
          headers: newheaders);
      print("getRecentlyViewedProjects ${response.statusCode}");
      Get.find<ProjectsScreenController>().statuscode.value =
          response.statusCode.toString();
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        // return recentlyViewedModelFromJson(
        //     jsonEncode(jsonDecode(response.body)['projects']));

        return jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return [];
    } on SocketException catch (_) {
      print(_);

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future duplicateProject({required String projectID}) async {
    try {
      // print(Get.find<StorageServices>().storage.read('cookie').toString());
      // print(Get.find<StorageServices>().storage.read('sessionID').toString());
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/project/duplicate/'),
          body: jsonEncode({"projectId": projectID}),
          headers: newheaders);
      print(response.statusCode);
      log(response.headers.toString());
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        // return recentlyViewedModelFromJson(
        //     jsonEncode(jsonDecode(response.body)['projects']));

        return jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Duplicate Projects Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Duplicate Projects Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      print("error" + e.toString());
      Get.snackbar(
        "Duplicate Projects Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future archivedProject(
      {required String projectID, required bool isArchived}) async {
    try {
      // print(Get.find<StorageServices>().storage.read('cookie').toString());
      // print(Get.find<StorageServices>().storage.read('sessionID').toString());

      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var jsonBody =
          jsonEncode({"projectId": projectID, "isArchived": isArchived});
      var response = await client.put(
          Uri.parse('${AppEndpoint.endPointDomain}/project'),
          body: jsonBody,
          headers: newheaders);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        // return recentlyViewedModelFromJson(
        //     jsonEncode(jsonDecode(response.body)['projects']));
        return jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Archived Projects Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Archived Projects Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      print(e);
      Get.snackbar(
        "Archived Projects Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future updateProjectDetails(
      {required String imagePath,
      required String projectID,
      required List tags,
      required String projectname,
      required String description}) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        // Uri.parse("${AppEndpoint.endPointDomain}/idea/items/"),
        Uri.parse("${AppEndpoint.endPointDomain}/project"),
      );
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'multipart/form-data';
      request.headers.addAll(newheaders);

      request.fields['projectId'] = projectID;

      if (tags.isNotEmpty || tags.length != 0) {
        request.fields['tags'] = jsonEncode(tags);
      }
      if (projectname.isNotEmpty || projectname != "") {
        request.fields['name'] = projectname;
      }
      request.fields['description'] = description;

      if (imagePath.isNotEmpty || imagePath != "") {
        List<http.MultipartFile> files = [];
        var f = await http.MultipartFile.fromBytes(
            'files', File(imagePath).readAsBytesSync(),
            filename: imagePath.split('/').last,
            // filename: listfile[i].path.split('/').last,
            contentType: MediaType('image', 'png'));
        files.add(f);
        request.files.addAll(files);
      }
      http.Response response =
          await http.Response.fromStream(await request.send());
      print(response.statusCode);
      if (response.statusCode == 202 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return jsonDecode(response.body);
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);

      Get.snackbar(
        "Message",
        "Oops.. Please try again later!",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future deleteProject({required String projectID}) async {
    try {
      // print(Get.find<StorageServices>().storage.read('cookie').toString());
      // print(Get.find<StorageServices>().storage.read('sessionID').toString());

      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var jsonBody = jsonEncode({"projectId": projectID});
      var response = await client.delete(
          Uri.parse('${AppEndpoint.endPointDomain}/project'),
          body: jsonBody,
          headers: newheaders);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        // return recentlyViewedModelFromJson(
        //     jsonEncode(jsonDecode(response.body)['projects']));
        print(response.body);
        return true;
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Delete Projects Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Delete Projects Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      print(e);
      Get.snackbar(
        "Delete Projects Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
