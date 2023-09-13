// import 'dart:async';

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:yoooto/services/storage_services.dart';
// import 'package:showcaseview/showcaseview.dart';
import '../../../config/endpoints.dart';
import '../../../constant/colors_class.dart';
import '../../bottom_navigation_screen/controller/bottomnav_controller.dart';
import '../api/project_screen_api.dart';
import '../model/ideas_final_model.dart';
import '../model/products_tab_model.dart';
import '../model/recently_view_model.dart';

class ProjectsScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxList<RecentlyViewedModel> recentlyViewedProjectList =
      <RecentlyViewedModel>[].obs;
  RxList<RecentlyViewedModel> recentlyViewedProjectList_master =
      <RecentlyViewedModel>[].obs;

  RxList<RecentlyViewedModel> inProgressProjectList =
      <RecentlyViewedModel>[].obs;

  RxList<RecentlyViewedModel> isCompletedProjectList =
      <RecentlyViewedModel>[].obs;

  RxList<RecentlyViewedModel> isArchivedProjectList =
      <RecentlyViewedModel>[].obs;

  RxList<ProductsTabModel> productTab = <ProductsTabModel>[].obs;

  RxList<TopWidgetModel> project_ideasList = <TopWidgetModel>[].obs;

  ScrollController scrollController_recently_viewed = ScrollController();
  RxDouble scrollPosition_recently_viewed = 0.0.obs;

  ScrollController scrollController_in_progress = ScrollController();
  RxDouble scrollPosition_in_progress = 0.0.obs;

  ScrollController scrollController_is_completed = ScrollController();
  RxDouble scrollPosition_is_completed = 0.0.obs;

  ScrollController scrollController_is_archived = ScrollController();
  RxDouble scrollPosition_is_archived = 0.0.obs;

  ScrollController scrollController_idea = ScrollController();
  RxDouble scrollPosition_idea = 0.0.obs;

  ScrollController scrollController_products = ScrollController();
  RxDouble scrollPosition_products = 0.0.obs;

  RxString selectedTopTabBar = "Projects".obs;

  RxBool isLoading = true.obs;

  TabController? tabController;

  TextEditingController newProjectName = TextEditingController();
  TextEditingController newDescription = TextEditingController();
  TextEditingController newTags = TextEditingController();
  RxString newImagePath = "".obs;

  RxBool isFocusTag = true.obs;
  FocusNode projectTagFocusNode = FocusNode();
  RxString tagValues = "".obs;

  Timer? debounce;

  RxString statuscode = "".obs;

  @override
  void onClose() {
    scrollController_idea.dispose();
    scrollController_products.dispose();
    scrollController_recently_viewed.dispose();
    scrollController_in_progress.dispose();
    scrollController_is_completed.dispose();
    scrollController_is_archived.dispose();
    debounce?.cancel();
    projectTagFocusNode.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    // getDimensions();
    // var ideasDta = await ideasSampleModelFromJson(jsonEncode(ideasRawData));
    // ideasList.assignAll(ideasDta);

    tabController = TabController(vsync: this, length: 4);
    await getProjectsAll();
    // await getAllIdeasTopWidget();
    scrollController_recently_viewed.addListener(() {
      scrollPosition_recently_viewed.value =
          scrollController_recently_viewed.position.pixels;
    });
    scrollController_in_progress.addListener(() {
      scrollPosition_in_progress.value =
          scrollController_in_progress.position.pixels;
    });
    scrollController_is_completed.addListener(() {
      scrollPosition_is_completed.value =
          scrollController_is_completed.position.pixels;
    });
    scrollController_is_archived.addListener(() {
      scrollPosition_is_archived.value =
          scrollController_is_archived.position.pixels;
    });
    scrollController_idea.addListener(() {
      scrollPosition_idea.value = scrollController_idea.position.pixels;
    });
    scrollController_products.addListener(() {
      scrollPosition_products.value = scrollController_products.position.pixels;
    });
    tabController!.addListener(() {
      if (tabController!.index == 0) {
        if (scrollController_recently_viewed.hasClients) {
          scrollController_recently_viewed.jumpTo(0.0);
        }
      } else if (tabController!.index == 1) {
        if (scrollController_in_progress.hasClients) {
          scrollController_in_progress.jumpTo(0.0);
        }
      } else if (tabController!.index == 2) {
        if (scrollController_is_completed.hasClients) {
          scrollController_is_completed.jumpTo(0.0);
        }
      } else if (tabController!.index == 3) {
        if (scrollController_is_archived.hasClients) {
          scrollController_is_archived.jumpTo(0.0);
        }
      }

      scrollPosition_in_progress.value = 0.0;
      scrollPosition_is_archived.value = 0.0;
      scrollPosition_is_completed.value = 0.0;
      scrollPosition_recently_viewed.value = 0.0;
    });

    if (Get.find<StorageServices>().storage.read("showcaseStateHomeScreen") ==
        null) {
      Timer(Duration(seconds: 1), () {
        ShowCaseWidget.of(
                Get.find<BottomNavigationController>().bottomNavContext!)
            .startShowCase([
          Get.find<BottomNavigationController>().floatingButtonKey,
        ]);
        Get.find<StorageServices>().showcaseStateHomeScreen(isDone: "done");
      });
    }

    if (Get.isRegistered<BottomNavigationController>() == true) {
      Get.find<BottomNavigationController>().isLoading(false);
    }

    projectTagFocusNode.addListener(() {
      if (projectTagFocusNode.hasFocus == true) {
        isFocusTag.value = true;
        print("project tag has focus");
      } else {
        print("project tag no focus");
        isFocusTag.value = false;
      }
    });

    // log(Get.find<StorageServices>().storage.read('data').toString());
    super.onInit();
  }

  TextEditingController search = TextEditingController();

  getProjectsAll() async {
    if (Get.find<StorageServices>().storage.read('data') != null) {
      var data = Get.find<StorageServices>().storage.read('data');
      List<RecentlyViewedModel> resultdata_for_recentlyUpdated = [];
      for (int i = 0; i < data.length; i++) {
        if (data[i]["isArchived"] == false) {
          resultdata_for_recentlyUpdated.add(RecentlyViewedModel(
            id: data[i]["id"].toString(),
            name: data[i]["name"] == null ? "Unnamed" : data[i]["name"],
            dateWrite: DateTime.parse(data[i]['createdAt'].toString()),
            file: data[i]["file"] == null
                ? FileClass()
                : FileClass(
                    file: data[i]["file"]['filename'].toString(),
                    name: data[i]["file"]['filename'].toString(),
                    fileType: "",
                  ),
          ));
        }
      }
      resultdata_for_recentlyUpdated
          .sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
      recentlyViewedProjectList
          .assignAll(resultdata_for_recentlyUpdated.reversed.toList());

      List<RecentlyViewedModel> resultdata_for_isCompleted = [];
      for (int i = 0; i < data.length; i++) {
        if (data[i]['isComplete'] == true) {
          resultdata_for_isCompleted.add(RecentlyViewedModel(
            id: data[i]["id"].toString(),
            name: data[i]["name"] == null ? "Unnamed" : data[i]["name"],
            dateWrite: DateTime.parse(data[i]['createdAt'].toString()),
            file: data[i]["file"] == null
                ? FileClass()
                : FileClass(
                    file: data[i]["file"]['filename'].toString(),
                    name: data[i]["file"]['filename'].toString(),
                    fileType: "",
                  ),
          ));
        }
      }

      resultdata_for_isCompleted
          .sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
      isCompletedProjectList
          .assignAll(resultdata_for_isCompleted.reversed.toList());

      List<RecentlyViewedModel> resultdata_for_inprogress = [];
      for (int i = 0; i < data.length; i++) {
        if (data[i]['isComplete'] == false) {
          resultdata_for_inprogress.add(RecentlyViewedModel(
            id: data[i]["id"].toString(),
            name: data[i]["name"] == null ? "Unnamed" : data[i]["name"],
            dateWrite: DateTime.parse(data[i]['createdAt'].toString()),
            file: data[i]["file"] == null
                ? FileClass()
                : FileClass(
                    file: data[i]["file"]['filename'].toString(),
                    name: data[i]["file"]['filename'].toString(),
                    fileType: "",
                  ),
          ));
        }
      }

      resultdata_for_inprogress
          .sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
      inProgressProjectList
          .assignAll(resultdata_for_inprogress.reversed.toList());

      List<RecentlyViewedModel> resultdata_for_isArchived = [];
      for (int i = 0; i < data.length; i++) {
        if (data[i]['isArchived'] == true) {
          resultdata_for_isArchived.add(RecentlyViewedModel(
            id: data[i]["id"].toString(),
            name: data[i]["name"] == null ? "Unnamed" : data[i]["name"],
            dateWrite: DateTime.parse(data[i]['createdAt'].toString()),
            file: data[i]["file"] == null
                ? FileClass()
                : FileClass(
                    file: data[i]["file"]['filename'].toString(),
                    name: data[i]["file"]['filename'].toString(),
                    fileType: "",
                  ),
          ));
        }
      }

      resultdata_for_isArchived
          .sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
      isArchivedProjectList
          .assignAll(resultdata_for_isArchived.reversed.toList());
    }

    var result = await ProjectApi.getRecentlyViewedProjects();

    if (result == "Session Expired" || result == false) {
    } else {
      if (result.isNotEmpty) {
        // recentlyViewedProjectList_master.assignAll(result);
        Get.find<StorageServices>().saveLocalDataForCaching(data: result);

        List<RecentlyViewedModel> resultdata_for_recentlyUpdated = [];
        for (var i = 0; i < result.length; i++) {
          if (result[i]['isArchived'] == false) {
            resultdata_for_recentlyUpdated.add(RecentlyViewedModel(
              id: result[i]["id"].toString(),
              name: result[i]["name"] == null ? "Unnamed" : result[i]["name"],
              dateWrite: DateTime.parse(result[i]['createdAt'].toString()),
              file: result[i]["file"] == null
                  ? FileClass()
                  : FileClass(
                      file: result[i]["file"]['filename'],
                      name: result[i]["file"]['filename'],
                      fileType: "",
                    ),
            ));
          }
        }
        resultdata_for_recentlyUpdated
            .sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
        recentlyViewedProjectList
            .assignAll(resultdata_for_recentlyUpdated.reversed.toList());

        List<RecentlyViewedModel> resultdata_for_isCompleted = [];
        for (var i = 0; i < result.length; i++) {
          if (result[i]['isComplete'] == true) {
            resultdata_for_isCompleted.add(RecentlyViewedModel(
              id: result[i]["id"].toString(),
              name: result[i]["name"] == null ? "Unnamed" : result[i]["name"],
              dateWrite: DateTime.parse(result[i]['createdAt'].toString()),
              file: result[i]["file"] == null
                  ? FileClass()
                  : FileClass(
                      file: result[i]["file"]['filename'],
                      name: result[i]["file"]['filename'],
                      fileType: "",
                    ),
            ));
          }
        }
        resultdata_for_isCompleted
            .sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
        isCompletedProjectList
            .assignAll(resultdata_for_isCompleted.reversed.toList());

        List<RecentlyViewedModel> resultdata_for_inProgress = [];
        for (var i = 0; i < result.length; i++) {
          if (result[i]['isComplete'] == false) {
            resultdata_for_inProgress.add(RecentlyViewedModel(
              id: result[i]["id"].toString(),
              name: result[i]["name"] == null ? "Unnamed" : result[i]["name"],
              dateWrite: DateTime.parse(result[i]['createdAt'].toString()),
              file: result[i]["file"] == null
                  ? FileClass()
                  : FileClass(
                      file: result[i]["file"]['filename'],
                      name: result[i]["file"]['filename'],
                      fileType: "",
                    ),
            ));
          }
        }
        resultdata_for_inProgress
            .sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
        inProgressProjectList
            .assignAll(resultdata_for_inProgress.reversed.toList());

        List<RecentlyViewedModel> resultdata_for_isArchived = [];
        for (var i = 0; i < result.length; i++) {
          if (result[i]['isArchived'] == true) {
            resultdata_for_isArchived.add(RecentlyViewedModel(
              id: result[i]["id"].toString(),
              name: result[i]["name"] == null ? "Unnamed" : result[i]["name"],
              dateWrite: DateTime.parse(result[i]['createdAt'].toString()),
              file: result[i]["file"] == null
                  ? FileClass()
                  : FileClass(
                      file: result[i]["file"]['filename'],
                      name: result[i]["file"]['filename'],
                      fileType: "",
                    ),
            ));
          }
        }
        resultdata_for_isArchived
            .sort((a, b) => a.dateWrite!.compareTo(b.dateWrite!));
        isArchivedProjectList
            .assignAll(resultdata_for_isArchived.reversed.toList());
      }
    }
  }

  String mainUrlImage(
      {required String name, required List<FileElement> fileList}) {
    String toberuturned = "";
    for (var i = 0; i < fileList.length; i++) {
      if (fileList[i].main == true) {
        toberuturned = fileList[i].file.toString();
      }
    }
    print(AppEndpoint.endPointDomain + toberuturned + "         " + name);
    return toberuturned;
  }

  duplicateProject({required String projectID}) async {
    var result = await ProjectApi.duplicateProject(projectID: projectID);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      await getProjectsAll();
      Get.snackbar("Message", "Successfully Duplicated Project.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  archivedProjects({required String projectID}) async {
    var result = await ProjectApi.archivedProject(
        projectID: projectID, isArchived: true);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      await getProjectsAll();
      Get.snackbar("Message", "Successfully Archived Project.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  un_archivedProjects({required String projectID}) async {
    var result = await ProjectApi.archivedProject(
        projectID: projectID, isArchived: false);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      await getProjectsAll();
      Get.snackbar("Message", "Successfully Recovered Project.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
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
    var result = await ProjectApi.updateProjectDetails(
        imagePath: newImagePath.value,
        projectID: projectID,
        projectname: projectname,
        tags: tagList,
        description: newDescription.text);
    if (result == false) {
    } else {
      await getProjectsAll();
      Get.snackbar("Message", "Successfully Updated Project.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  deleteProject({required String projectID}) async {
    var result = await ProjectApi.deleteProject(projectID: projectID);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      recentlyViewedProjectList
          .removeWhere((element) => element.id == projectID);
      recentlyViewedProjectList_master
          .removeWhere((element) => element.id == projectID);
      isCompletedProjectList.removeWhere((element) => element.id == projectID);
      isArchivedProjectList.removeWhere((element) => element.id == projectID);
      inProgressProjectList.removeWhere((element) => element.id == projectID);
      await getProjectsAll();
      Get.snackbar("Message", "Project Deleted.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }
}
