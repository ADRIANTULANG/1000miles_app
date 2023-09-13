import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yoooto/modules/search_screen/api/search_api.dart';
import 'package:yoooto/services/storage_services.dart';
import '../../project_screen/controller/projects_controller.dart';
import '../../project_screen/model/recently_view_model.dart';

class SearchScreenController extends GetxController {
  FocusNode searchFocusNode = FocusNode();
  RxList<RecentlyViewedModel> projectListMaster = <RecentlyViewedModel>[].obs;
  RxList<RecentlyViewedModel> projectlist = <RecentlyViewedModel>[].obs;

  RxBool isFocus = false.obs;
  TextEditingController searchController = TextEditingController();

  ScrollController searchScrollController = ScrollController();
  RxDouble searchScrollPosition = 0.0.obs;

  TextEditingController newProjectName = TextEditingController();
  TextEditingController newDescription = TextEditingController();
  TextEditingController newTags = TextEditingController();
  RxString newImagePath = "".obs;

  RxBool isFocusTag = true.obs;
  FocusNode projectTagFocusNode = FocusNode();
  RxString tagValues = "".obs;

  Timer? debounce;

  @override
  void onInit() async {
    getAllProjects();
    searchScrollController.addListener(() {
      searchScrollPosition.value = searchScrollController.position.pixels;
    });
    searchFocusNode.requestFocus();
    searchFocusNode.addListener(() {
      isFocus.value = searchFocusNode.hasFocus;
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    super.onClose();
  }

  getAllProjects() {
    List data = Get.find<StorageServices>().storage.read("data");
    for (var i = 0; i < data.length; i++) {
      if (data[i]['isArchived'] == false) {
        projectListMaster.add(RecentlyViewedModel(
          id: data[i]['_id'],
          name: data[i]['name'] == null ? "Unnamed" : data[i]['name'],
          dateWrite: DateTime.parse(data[i]['updatedAt'].toString()),
          file: data[i]['file'] == null
              ? FileClass()
              : FileClass(
                  file: data[i]["file"]['filename'].toString(),
                  name: data[i]["file"]['filename'].toString(),
                  fileType: "",
                ),
        ));
      }
    }
    projectListMaster.sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
    projectListMaster.assignAll(projectListMaster.reversed.toList());
    projectlist.assignAll(projectListMaster);
  }

  searchFunction({required String projectname}) {
    if (projectname.toLowerCase().toString() == "unnamed") {
      projectname = '';
    }
    projectlist.clear();

    for (var i = 0; i < projectListMaster.length; i++) {
      projectlist.assignAll(projectListMaster
          .where((u) => (u.name
              .toString()
              .toLowerCase()
              .contains(projectname.toLowerCase())))
          .toList());
    }
  }

  duplicateProject({required String projectID}) async {
    var result = await SearchApi.duplicateProject(projectID: projectID);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      await Get.find<ProjectsScreenController>().getProjectsAll();
    }
  }

  archivedProjects({required String projectID}) async {
    var result =
        await SearchApi.archivedProject(projectID: projectID, isArchived: true);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      await Get.find<ProjectsScreenController>().getProjectsAll();
    }
  }

  un_archivedProjects({required String projectID}) async {
    var result = await SearchApi.archivedProject(
        projectID: projectID, isArchived: false);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      await Get.find<ProjectsScreenController>().getProjectsAll();
    }
  }

  tagsMaker({required String text}) {
    List tagList = text.split(',');
    print(tagList);
    for (var i = 0; i < tagList.length; i++) {
      String newItem = tagList[i].toString().replaceAll(RegExp('#'), "");
      tagList[i] = newItem.trim().removeAllWhitespace;
      print(tagList[i]);
    }
    String newText = "";
    for (var i = 0; i < tagList.length; i++) {
      if (tagList[i] == "") {
      } else {
        newText = newText + " #" + tagList[i];
      }
    }
    tagValues.value = newText.trim();
    tagValues.value;
    print(newText);
  }

  selectImage() async {
    final picker = ImagePicker();
    XFile? result = await picker.pickImage(source: ImageSource.gallery);
    if (result == null) {
    } else {
      File file = await File(result.path);
      int quality = 90;
      int percentage = 90;
      final bytes = file.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      if (kb > 1000) {
        quality = 25;
        percentage = 25;
      } else if (kb < 900 && kb > 300) {
        quality = 80;
        percentage = 80;
      }
      if (kb > 5000) {
        quality = 20;
        percentage = 20;
      }

      print(quality.toString() + "  " + percentage.toString());

      File compressedFile = await FlutterNativeImage.compressImage(file.path,
          quality: quality, percentage: percentage);

      final kbnew = compressedFile.readAsBytesSync().lengthInBytes / 1024;
      print("image size is $kbnew KB");
      newImagePath.value = compressedFile.path;
    }
  }

  updateProjectDetails(
      {required String projectID, required String projectname}) async {
    List tagList = newTags.text
        .replaceAll(RegExp('#'), "")
        .trim()
        .removeAllWhitespace
        .split(',');
    if (newTags.text.removeAllWhitespace.isEmpty) {
      tagList.removeAt(0);
    }
    // print(tagList);
    // print(tagList.length);
    var result = await SearchApi.updateProjectDetails(
        imagePath: newImagePath.value,
        projectID: projectID,
        projectname: projectname,
        tags: tagList,
        description: newDescription.text);
    if (result == false) {
    } else {
      await Get.find<ProjectsScreenController>().getProjectsAll();
    }
  }

  deleteProject({required String projectID}) async {
    var result = await SearchApi.deleteProject(projectID: projectID);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      Get.find<ProjectsScreenController>()
          .recentlyViewedProjectList
          .removeWhere((element) => element.id == projectID);
      Get.find<ProjectsScreenController>()
          .recentlyViewedProjectList_master
          .removeWhere((element) => element.id == projectID);
      Get.find<ProjectsScreenController>()
          .isCompletedProjectList
          .removeWhere((element) => element.id == projectID);
      Get.find<ProjectsScreenController>()
          .isArchivedProjectList
          .removeWhere((element) => element.id == projectID);
      Get.find<ProjectsScreenController>()
          .inProgressProjectList
          .removeWhere((element) => element.id == projectID);
      await Get.find<ProjectsScreenController>().getProjectsAll();
    }
  }
}
