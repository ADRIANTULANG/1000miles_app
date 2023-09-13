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
import '../model/project_ideas_gallery_model.dart';

class ProjectIdeasApi {
  static var client = http.Client();

//<List<DeceasedModel>>
  static Future getProjectIdeasApi({required String projectID}) async {
    try {
      var response = await client.get(
          Uri.parse('${AppEndpoint.endPointDomain}/idea?project=$projectID'),
          headers: {
            "Cookie":
                "csrftoken=${Get.find<StorageServices>().storage.read('cookie')}; sessionid=${Get.find<StorageServices>().storage.read('sessionID')}",
            "X-CSRFToken":
                Get.find<StorageServices>().storage.read('cookie').toString(),
          });

      if (response.statusCode == 200) {
        // print(response.body);
        return projectGalleryModelFromJson(
            jsonEncode(jsonDecode(response.body)));
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return [];
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get Projects Ideas Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get Projects Ideas Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } catch (e) {
      Get.snackbar(
        "Get Projects Ideas Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  static Future createGroup({
    required String projectId,
    required List ideas,
    required String name,
  }) async {
    try {
      Map body = {};
      if (name == "") {
        body = {"projectId": projectId, "ideas": ideas};
      } else {
        body = {"projectId": projectId, "ideas": ideas, "name": name};
      }
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var bodypass = json.encode(body);
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/idea-group/idea'),
          body: bodypass,
          headers: newheaders);
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Create Group Idea Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Create Group Idea Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Create Group Idea Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future archivedIdea({
    required String ideaID,
  }) async {
    try {
      print(ideaID);
      Map body = {"ideaId": ideaID, "isArchived": true};
      var bodypass = json.encode(body);
      print(bodypass);
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var response = await client.put(
          Uri.parse('${AppEndpoint.endPointDomain}/idea'),
          body: bodypass,
          headers: newheaders);
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Archive Idea Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Archive Idea Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Archive Idea Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future archiveGroup({
    required List listOfID,
  }) async {
    try {
      Map body = {"ideaGroups": listOfID};
      var bodypass = json.encode(body);
      print(bodypass);
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/archive'),
          body: bodypass,
          headers: newheaders);
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Archive Group Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Archive Group Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Archive Group Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future renameGroupIdea({
    required String groupIdea,
    required String newname,
  }) async {
    try {
      Map body = {"ideaGroupId": groupIdea, "name": newname};
      var bodypass = json.encode(body);
      print(bodypass);
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var response = await client.put(
          Uri.parse('${AppEndpoint.endPointDomain}/idea-group/'),
          body: bodypass,
          headers: newheaders);
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "rename group Idea Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "rename group Idea Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "rename group Idea Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future copyIdea(
      {required String groupID,
      required String projectID,
      required List ideaList}) async {
    try {
      Map body = {"ideas": ideaList};
      if (projectID != "") {
        var data = {"projectId": projectID};
        body.addAll(data);
      }
      if (groupID != "") {
        var data = {"groupId": groupID};
        body.addAll(data);
      }
      var bodypass = json.encode(body);
      print(bodypass);

      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/mobile/idea/copy'),
          body: bodypass,
          headers: newheaders);
      print(response.statusCode);

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "copy Idea Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "copy Idea Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "copy Idea Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future moveidea(
      {required String groupID,
      required String projectID,
      required String previousGroupID,
      required String previousProjectID,
      required List ideaList}) async {
    print("groupID: $groupID");
    print("projectID: $projectID");
    print("previousGroupID: $previousGroupID");
    print("previousProjectID: $previousProjectID");

    try {
      Map body = {"ideas": ideaList};
      print(previousGroupID);
      if (previousGroupID == "") {
        var data = {"prevProjectId": previousProjectID};
        body.addAll(data);
      } else {
        var data = {"prevGroupId": previousGroupID};
        body.addAll(data);
      }

      if (projectID != "") {
        var data = {"projectId": projectID};
        body.addAll(data);
      }
      if (groupID != "") {
        var data = {"groupId": groupID};
        body.addAll(data);
      }
      var bodypass = json.encode(body);
      print(bodypass);

      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      var response = await client.post(
          Uri.parse('${AppEndpoint.endPointDomain}/mobile/idea/move'),
          body: bodypass,
          headers: newheaders);
      print(response.statusCode);

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<HeadersServices>().updateCookie(response);
        return true;
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return false;
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "move Idea Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "move Idea Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "move Idea Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  static Future createBoardsFromMoveorCopyScreen({
    required String projectId,
    required String name,
  }) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      Map body = {"projectId": projectId};
      if (name != "") {
        body.addAll({"name": name});
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

  static Future recoverIdeas(
      {required List ideaIdList, required List groupIdList}) async {
    try {
      Map<String, String> newheaders = Map<String, String>();
      newheaders['cookie'] =
          Get.find<StorageServices>().storage.read("refreshToken").toString();

      newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'application/json; charset=utf-8';
      Map body = {"ideas": ideaIdList, "ideaGroups": groupIdList};
      var bodypass = json.encode(body);
      var response = await client.put(
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
        "Recover ideas Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Recover ideas  Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        "Recover ideas  Error",
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
