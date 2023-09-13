import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/services/headers_services.dart';
import '../../../config/endpoints.dart';
import '../../../services/storage_services.dart';
import '../model/idea_images_model.dart';
import 'package:http_parser/http_parser.dart';

class SaveIdeaAndDetailsApi {
  static var client = http.Client();

  static Future uploadImageIdea(
      {required List<IdeaImagesModel> listfile,
      required String saveTo,
      required String projectID,
      required String groupID}) async {
    try {
      print(
          "cookie: ${Get.find<StorageServices>().storage.read('refreshToken').toString()}");
      print(
          "session: ${Get.find<StorageServices>().storage.read('authorization').toString()}");
      print(saveTo);
      print("project_id: ${projectID}");
      print("groupID: ${groupID}");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppEndpoint.endPointDomain}/mobile/idea"),
      );
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'multipart/form-data';
      request.headers.addAll(newheaders);
      if (saveTo == "SAVE TO GROUP") {
        request.fields['groupIdeaId'] = groupID;
      } else if (saveTo == "SAVE TO PROJECT") {
        request.fields['projectId'] = projectID;
      }
      List<http.MultipartFile> files = [];
      for (var i = 0; i < listfile.length; i++) {
        String fileType = listfile[i].path.split('/').last;
        var f = await http.MultipartFile.fromBytes(
            'files', File(listfile[i].path).readAsBytesSync(),
            filename: i.toString() +
                DateTime.now().microsecondsSinceEpoch.toString() +
                "=" +
                listfile[i].imageTitle +
                "." +
                fileType,
            // filename: listfile[i].path.split('/').last,
            contentType: MediaType('image', 'png'));

        files.add(f);
      }
      request.files.addAll(files);
      http.Response response =
          await http.Response.fromStream(await request.send());
      print(response.statusCode);
      print(response.reasonPhrase);
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

  static Future uploadImage_from_group_folder(
      {required List<IdeaImagesModel> listfile,
      required String groupID,
      required String projectID}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        // Uri.parse("${AppEndpoint.endPointDomain}/idea/items/"),
        Uri.parse("${AppEndpoint.endPointDomain}/mobile/idea"),
      );
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'multipart/form-data';
      request.headers.addAll(newheaders);

      request.fields['groupIdeaId'] = groupID;
      request.fields['projectId'] = projectID;

      List<http.MultipartFile> files = [];

      for (var i = 0; i < listfile.length; i++) {
        String fileType = listfile[i].path.split('/').last;
        var f = await http.MultipartFile.fromBytes(
            'files', File(listfile[i].path).readAsBytesSync(),
            filename: i.toString() +
                DateTime.now().microsecondsSinceEpoch.toString() +
                "=" +
                listfile[i].imageTitle +
                "." +
                fileType,
            // filename: listfile[i].path.split('/').last,
            contentType: MediaType('image', 'png'));

        files.add(f);
      }
      request.files.addAll(files);
      http.Response response =
          await http.Response.fromStream(await request.send());
      print(response.statusCode);
      print(response.reasonPhrase);
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

  static Future saveToMyIdeas({
    required List<IdeaImagesModel> listfile,
    required String groupID,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        // Uri.parse("${AppEndpoint.endPointDomain}/idea/items/"),
        Uri.parse("${AppEndpoint.endPointDomain}/mobile/user-idea"),
      );
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'multipart/form-data';
      request.headers.addAll(newheaders);

      if (groupID != "") {
        request.fields['ideaBoardId'] = groupID;
      }

      List<http.MultipartFile> files = [];

      for (var i = 0; i < listfile.length; i++) {
        String fileType = listfile[i].path.split('/').last;
        var f = await http.MultipartFile.fromBytes(
            'files', File(listfile[i].path).readAsBytesSync(),
            filename: i.toString() +
                DateTime.now().microsecondsSinceEpoch.toString() +
                "=" +
                listfile[i].imageTitle +
                "." +
                fileType,
            // filename: listfile[i].path.split('/').last,
            contentType: MediaType('image', 'png'));

        files.add(f);
      }
      request.files.addAll(files);
      http.Response response =
          await http.Response.fromStream(await request.send());
      print(response.statusCode);
      print(response.reasonPhrase);
      if (response.statusCode == 202 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        // log(response.body);
        return true;
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

  static Future createBoard_my_ideas({
    required String boardname,
  }) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      Map body = {};
      if (boardname != "") {
        body = {"name": boardname};
      }
      var bodypass = json.encode(body);
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/user-idea/board'),
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
        "Create Board Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Create Board  Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Create Board  Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future createBoard_projects(
      {required String boardname, required String projectID}) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      Map body = {"projectId": projectID};
      if (boardname != "") {
        body.addAll({"name": boardname});
      }
      var bodypass = json.encode(body);
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/idea-group/'),
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
        "Create Board Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Create Board  Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Create Board  Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
