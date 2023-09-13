import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yoooto/services/storage_services.dart';
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../services/headers_services.dart';

class MyIdeasApi {
  static var client = http.Client();

  static Future getUserMyIdeasAndSharedIdeas() async {
    try {
      // print(Get.find<StorageServices>().storage.read('cookie').toString());
      // print(Get.find<StorageServices>().storage.read('sessionID').toString());

      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var response = await client.get(
          Uri.parse('${AppEndpoint.endPointDomain}/user/'),
          headers: newheaders);
      print("getUserMyIdeasAndSharedIdeas ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);

        return jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        return false;
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

  static Future archivedIdeas(
      {required List imagestoarchive, required List groupToArchive}) async {
    try {
      // print(Get.find<StorageServices>().storage.read('cookie').toString());
      // print(Get.find<StorageServices>().storage.read('sessionID').toString());

      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var body = {"ideas": imagestoarchive, "ideaGroups": groupToArchive};
      print(jsonEncode(body));
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/archive/'),
          body: jsonEncode(body),
          headers: newheaders);

      print("archivedIdeas ${response.statusCode}");

      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return false;
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

  static Future renameGroup(
      {required String groupID, required String groupName}) async {
    try {
      // print(Get.find<StorageServices>().storage.read('cookie').toString());
      // print(Get.find<StorageServices>().storage.read('sessionID').toString());

      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();
      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var body = {"ideaGroupId": groupID, "name": groupName};

      var response = await client.put(
          Uri.parse('${AppEndpoint.endPointDomain}/idea-group/'),
          body: jsonEncode(body),
          headers: newheaders);
      print("renameGroup " + response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return false;
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      print(_);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future moveIdeas(
      {required String previousBoardID,
      required String destinationProjectID,
      required String destinationBoardID,
      required List imageIdList}) async {
    try {
      // print(Get.find<StorageServices>().storage.read('cookie').toString());
      // print(Get.find<StorageServices>().storage.read('sessionID').toString());
      print("destinationProjectID ${destinationProjectID}");
      print("destinationBoardID ${destinationBoardID}");
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var body = {
        "prevId": previousBoardID,
        "boardId": destinationBoardID,
        "projectId": destinationProjectID,
        "ideas": imageIdList
      };
      print(jsonEncode(body));

      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/user-idea/move-idea'),
          body: jsonEncode(body),
          headers: newheaders);
      print("moveIdeas " + response.statusCode.toString());
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return false;
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      print(_);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future copyIdeas(
      {required String destinationProjectID,
      required String destinationBoardID,
      required List imageIdList}) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var body = {
        "boardId": destinationBoardID,
        "projectId": destinationProjectID,
        "ideas": imageIdList
      };
      print(jsonEncode(body));
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/user-idea/copy-idea'),
          body: jsonEncode(body),
          headers: newheaders);
      print("copyIdeas " + response.statusCode.toString());
      print(response.reasonPhrase);
      print(response.request);
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return false;
      } else if (response.statusCode == 500) {
        return false;
      } else if (response.statusCode == 401) {
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      print(_);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future createBoardWithIdeas(
      {required String boardName, required List imageIdList}) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var body = {"ideas": imageIdList, "name": boardName};
      print(jsonEncode(body));
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/user-idea/board-idea'),
          body: jsonEncode(body),
          headers: newheaders);
      print("createBoardWithIdeas " + response.statusCode.toString());

      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return false;
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      print(_);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future restoreMyIdeas(
      {required List imageIdList, required List groupsToRecover}) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var body = {"ideas": imageIdList, "ideaGroups": groupsToRecover};
      print(jsonEncode(body));
      var response = await client.put(
          Uri.parse('${AppEndpoint.endPointDomain}/archive'),
          body: jsonEncode(body),
          headers: newheaders);
      print("restoreMyIdeas " + response.statusCode.toString());

      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return false;
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      print(_);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future sharedIdeas(
      {required List ideaIDList,
      required String email,
      required String teamID}) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var body = {"ideas": ideaIDList, "email": email, "teamId": teamID};
      print(jsonEncode(body));
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/user-idea/share-idea'),
          body: jsonEncode(body),
          headers: newheaders);
      print("sharedIdeas " + response.statusCode.toString());

      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return false;
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      print(_);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future sharedGroup(
      {required List groupIdList,
      required String email,
      required String teamID}) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var body = {"ideaBoards": groupIdList, "email": email, "teamId": teamID};
      print(jsonEncode(body));
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/user-idea/share-board'),
          body: jsonEncode(body),
          headers: newheaders);
      print("sharedGroup " + response.statusCode.toString());
      print(response.reasonPhrase);
      if (response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return false;
      } else if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      print(_);
      return false;
    } catch (e) {
      print(e);
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
