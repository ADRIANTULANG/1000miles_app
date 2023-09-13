import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoooto/services/headers_services.dart';
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../services/storage_services.dart';

class IdeaDetailsApi {
  static var client = http.Client();

  static Future createComment({
    required String ideaID,
    required String comment,
  }) async {
    try {
      Map body = {"sourceId": ideaID, "source": "idea", "comment": comment};
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var bodypass = json.encode(body);
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/comment/'),
          body: bodypass,
          headers: newheaders);
      print("createComment ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Create Comment Idea Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Create Comment Idea Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Create Comment Idea Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future voteIdea({required String ideaId}) async {
    try {
      Map body = {"ideaId": ideaId};
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var bodypass = json.encode(body);
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/vote/idea'),
          body: bodypass,
          headers: newheaders);
      print("renameIdea ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Vote  Idea Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Vote Idea Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Vote Idea Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future renameIdea(
      {required String label, required String ideaId}) async {
    try {
      Map body = {"label": label, "ideaId": ideaId};
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var bodypass = json.encode(body);
      var response = await client.put(
          Uri.parse('${AppEndpoint.endPointDomain}/idea'),
          body: bodypass,
          headers: newheaders);
      print("renameIdea ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Rename  Idea Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Rename Idea Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Rename Idea Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future deleteGroupIdeasOrIdeas(
      {required List ideaIdList, required List groupIdList}) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      Map body = {"ideas": ideaIdList, "ideaGroups": groupIdList};
      var bodypass = json.encode(body);
      var response = await client.delete(
          Uri.parse('${AppEndpoint.endPointDomain}/archive'),
          body: bodypass,
          headers: newheaders);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Delete group ideas or ideas Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Delete group ideas or ideas  Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Delete group ideas or ideas  Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
