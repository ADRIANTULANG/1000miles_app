import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../services/storage_services.dart';
import '../../select_photo_for_product_screen/model/select_photo_for_product_model.dart';
import '../model/products_projects_and_group.dart';
// import 'package:http_parser/http_parser.dart';

class ProductsProjectsAndGroups {
  static var client = http.Client();

//<List<DeceasedModel>>
  static Future getProjectsAndGroup() async {
    try {
      //572
      var response = await client.get(
          Uri.parse('${AppEndpoint.endPointDomain}/project/all/'),
          headers: {
            "Cookie":
                "csrftoken=${Get.find<StorageServices>().storage.read('cookie')}; sessionid=${Get.find<StorageServices>().storage.read('sessionID')}",
            "X-CSRFToken":
                Get.find<StorageServices>().storage.read('cookie').toString(),
          });
      if (response.statusCode == 200) {
        return projectGroupAndProductsFromJson(
            jsonEncode(jsonDecode(response.body)));
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return [];
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get Project and Groups Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get Project and Groups Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } catch (e) {
      Get.snackbar(
        "Get Project and Groups Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  static Future createProductWithUploadImage({
    required String productname,
    required String productdescription,
    required String productcategory,
    required List<PicturesProductModel> listfile,
    required String projectid,
    required String groupid,
    required String incoterms,
    required String height,
    required String length,
    required String width,
    required String metric,
    required String place,
    required String quantity,
  }) async {
    try {
      // print("productname ${productname}");
      // print("productdescription $productdescription");
      // print("productcategory $productcategory");
      // print("projectid $projectid");
      // print("groupid $groupid");
      // print("incoterms $incoterms");
      // print("height $height");
      // print("length $length");
      // print("width $width");
      // print("metric $metric");
      // print("place $place");
      // print("quantity $quantity");

      var request = http.MultipartRequest(
        'POST',
        // Uri.parse("${AppEndpoint.endPointDomain}/idea/items/"),
        Uri.parse("${AppEndpoint.endPointDomain}/product/mobile"),
      );
      Map<String, String> newheaders = {
        "Cookie":
            "csrftoken=${Get.find<StorageServices>().storage.read('cookie')}; sessionid=${Get.find<StorageServices>().storage.read('sessionID')}",
        "X-CSRFToken":
            Get.find<StorageServices>().storage.read('cookie').toString(),
      };
      // newheaders['Accept'] = 'application/json';
      newheaders['Content-type'] = 'multipart/form-data';
      request.headers.addAll(newheaders);

      if (groupid != "") {
        request.fields['group_id'] = groupid;
      }
      if (projectid != "") {
        request.fields['project_id'] = projectid;
      }
      if (quantity != "") {
        request.fields['quantity'] = quantity;
      }
      if (place != "") {
        request.fields['place'] = place;
      }
      if (metric != "") {
        request.fields['metric'] = metric;
      }
      if (width != "") {
        request.fields['width'] = width;
      }
      if (length != "") {
        request.fields['length'] = length;
      }
      if (height != "") {
        request.fields['height'] = height;
      }
      if (incoterms != "") {
        request.fields['incoterms'] = incoterms;
      }

      request.fields['category'] = productcategory;
      request.fields['description'] = productdescription;
      request.fields['name'] = productname;

      List<http.MultipartFile> files = [];

      for (var i = 0; i < listfile.length; i++) {
        var f = await http.MultipartFile.fromPath('files', listfile[i].path);
        files.add(f);
      }
      // for (var i = 0; i < listfile.length; i++) {
      //   var f = await http.MultipartFile.fromBytes(
      //       'files', File(listfile[i].path).readAsBytesSync(),
      //       filename: "image${DateTime.now()}",
      //       contentType: MediaType('image', 'png'));

      //   files.add(f);
      // }
      request.files.addAll(files);
      var response = await request.send();
      if (response.statusCode == 202 || response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseToString = String.fromCharCodes(responseData);
        var jsonBody = jsonDecode(responseToString);
        List data = [];
        String projectID = jsonBody['data']['project']['id'].toString();
        String projectName = jsonBody['data']['project']['name'].toString();

        data.add(projectID);
        data.add(projectName);
        return data;
        // return responseUploadIdeaImageFromJson(jsonEncode(jsonBody));
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
      Get.snackbar(
        "Message",
        "Oops.. Please try again later!",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
