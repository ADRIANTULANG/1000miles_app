import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../services/storage_services.dart';
import '../model/project_space_model.dart';

class ProjectSpaceController extends GetxController {
  RxString projectName = "".obs;
  RxString projectID = "".obs;
  RxBool isLoading = true.obs;

  List data = [
    {"option_name": "Products", "asset_count": 0, "icon": "Products"},
    {"option_name": "Ideas", "asset_count": 0, "icon": "Ideas"}
    // {"option_name": "Moodboard", "asset_count": 0, "icon": "Moodboard"},
    // {"option_name": "Suppliers", "asset_count": 0, "icon": "Suppliers"}
  ];

  RxList<ProjectSpace> projectOptions = <ProjectSpace>[].obs;

  RxBool isEditing = false.obs;

  final GlobalKey ideaButtonShowcase = GlobalKey();

  @override
  void onInit() async {
    projectOptions.assignAll(ProjectSpaceFromJson(jsonEncode(data)));
    projectName.value = await Get.arguments['projectName'];
    projectID.value = await Get.arguments['projectID'];
    await getProductCount();
    await getIdeasCount();
    print(projectName.value);
    print("ProjectID: " + projectID.value);
    isLoading(false);
    if (Get.find<StorageServices>().storage.read("showcaseProjectSpace") ==
        null) {
      Timer(Duration(seconds: 1), () {
        ShowCaseWidget.of(Get.context!).startShowCase([
          ideaButtonShowcase,
        ]);
        Get.find<StorageServices>().showcaseProjectSpace(isDone: "done");
      });
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getProductCount() async {
    int productCount = 0;
    if (Get.find<StorageServices>().storage.read('data') != null) {
      var data = Get.find<StorageServices>().storage.read('data');
      for (var i = 0; i < data.length; i++) {
        if (data[i]["id"] == projectID.value) {
          if (data[i]['products'] != null) {
            for (var x = 0; x < data[i]['products'].length; x++) {
              productCount = productCount + 1;
            }
          }
        }
      }

      for (var i = 0; i < projectOptions.length; i++) {
        if (projectOptions[i].optionName == "Products") {
          projectOptions[i].assetCount.value = productCount;
        }
      }
    }
  }

  getIdeasCount() async {
    int productIdeas = 0;
    if (Get.find<StorageServices>().storage.read('data') != null) {
      var data = Get.find<StorageServices>().storage.read('data');
      for (var i = 0; i < data.length; i++) {
        if (data[i]["id"] == projectID.value) {
          if (data[i]['ideas'] != null) {
            for (var x = 0; x < data[i]['ideas'].length; x++) {
              if (data[i]['ideas'][x]['isArchived'] == false) {
                productIdeas = productIdeas + 1;
              }
            }
          }
          if (data[i]['ideaGroups'] != null) {
            for (var z = 0; z < data[i]['ideaGroups'].length; z++) {
              for (var v = 0;
                  v < data[i]['ideaGroups'][z]['ideas'].length;
                  v++) {
                if (data[i]['ideaGroups'][z]['ideas'][v]['isArchived'] ==
                    false) {
                  productIdeas = productIdeas + 1;
                }
              }
            }
          }
        }
      }

      for (var i = 0; i < projectOptions.length; i++) {
        if (projectOptions[i].optionName == "Ideas") {
          projectOptions[i].assetCount.value = productIdeas;
        }
      }
    }
  }
}
