import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../../services/storage_services.dart';
import '../model/product_Details_model.dart';
import '../model/variant_details_model.dart';

class ProductDetailsAndVariantsApi {
  static var client = http.Client();

//<List<DeceasedModel>>
  static Future getProductVariantsAndDetails(
      {required String productID}) async {
    try {
      //572
      print("productID: $productID");

      var response = await client.get(
          Uri.parse('${AppEndpoint.endPointDomain}/product?id=$productID'),
          headers: {
            "Cookie":
                "csrftoken=${Get.find<StorageServices>().storage.read('cookie')}; sessionid=${Get.find<StorageServices>().storage.read('sessionID')}",
            "X-CSRFToken":
                Get.find<StorageServices>().storage.read('cookie').toString(),
          });

      if (response.statusCode == 200) {
        return productDetailsModelFromJson(
            jsonEncode(jsonDecode(response.body)));
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return [];
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get Products variants and details Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get Products variants and details Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } catch (e) {
      Get.snackbar(
        "Get Products variants and details Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }

  static Future getVariantDetails({required String variantID}) async {
    try {
      //406
      print("variantID: $variantID");
      var response = await client.get(
          Uri.parse(
              '${AppEndpoint.endPointDomain}/product/variant?id=$variantID'),
          headers: {
            "Cookie":
                "csrftoken=${Get.find<StorageServices>().storage.read('cookie')}; sessionid=${Get.find<StorageServices>().storage.read('sessionID')}",
            "X-CSRFToken":
                Get.find<StorageServices>().storage.read('cookie').toString(),
          });

      if (response.statusCode == 200) {
        return variantDetailsModelFromJson(
            jsonEncode(jsonDecode(response.body)));
      } else if (response.statusCode == 403) {
        return "Session Expired";
      } else {
        return [];
      }
    } on TimeoutException catch (_) {
      Get.snackbar(
        "Get Variants details Error: Timeout",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } on SocketException catch (_) {
      print(_);
      Get.snackbar(
        "Get Variants details Error: Socket",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    } catch (e) {
      Get.snackbar(
        "Get Variants details Error",
        "Oops, something went wrong. Please try again later.",
        colorText: Colors.white,
        backgroundColor: AppColor.accentTorquise,
        snackPosition: SnackPosition.BOTTOM,
      );
      return [];
    }
  }
}
