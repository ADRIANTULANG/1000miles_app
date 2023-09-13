import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../services/storage_services.dart';
import '../model/temporary_product_gallery_model.dart';

class ProjectsProductApi {
  static var client = http.Client();

//<List<DeceasedModel>>
  static Future getProjects_ProductsAndGroups(
      {required String projectID}) async {
    print(projectID);
    try {
      var response = await client.get(
          Uri.parse('${AppEndpoint.endPointDomain}/product/$projectID'),
          headers: {
            "Cookie":
                "csrftoken=${Get.find<StorageServices>().storage.read('cookie')}; sessionid=${Get.find<StorageServices>().storage.read('sessionID')}",
            "X-CSRFToken":
                Get.find<StorageServices>().storage.read('cookie').toString(),
          });

      if (response.statusCode == 200) {
        return temporaryProductGalleryModelFromJson(
            jsonEncode(jsonDecode(response.body)));
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return [];
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get Projects Products and Groups Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get Projects Products and Groups Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } catch (e) {
      Get.snackbar(
        "Get Projects Products and Groups Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }
}
