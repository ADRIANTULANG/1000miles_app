import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/modules/project_ideas_gallery/model/final_project_ideas_gallery_model.dart';
import 'package:yoooto/services/storage_services.dart';

import '../../project_screen/controller/projects_controller.dart';
import '../../project_space_screen/controller/project_space_controller.dart';
import '../api/project_ideas_gallery_api.dart';
import '../model/project_and_group_model.dart';
import '../model/project_gallery_Create_model.dart';
import '../model/project_gallery_display_group_items_model.dart';
import '../model/project_ideas_gallery_model.dart';

class ProjectIdeasGalleryController extends GetxController {
  RxString projectID = "".obs;
  RxString projectName = "".obs;
  RxList<ProjectGalleryModel> temporary_project_gallery_list =
      <ProjectGalleryModel>[].obs;

  // main list
  RxList<FinalProjectGalleryModel> archived_ideas_list =
      <FinalProjectGalleryModel>[].obs;
  RxList<FinalProjectGalleryModel> ungrouped_list =
      <FinalProjectGalleryModel>[].obs;
  RxList<FinalProjectGalleryModel> grouped_list =
      <FinalProjectGalleryModel>[].obs;
  //
  RxList<ProjectAndGroupModel> project_and_group_master_list =
      <ProjectAndGroupModel>[].obs;
  RxList<ProjectAndGroupModel> project_and_group_list =
      <ProjectAndGroupModel>[].obs;
  RxList<ProjectAndGroupModel> current_project_and_group_list =
      <ProjectAndGroupModel>[].obs;

  RxList<ProjectCreateGroupModel> createGroupIdeaList =
      <ProjectCreateGroupModel>[].obs;

  RxList<ProjectDisplayGroupItemsModel> displayGroupItemsList =
      <ProjectDisplayGroupItemsModel>[].obs;

  ScrollController scrollController_archived = ScrollController();
  RxDouble scrollPosition_archived = 0.0.obs;

  ScrollController scrollController_idea_groups = ScrollController();
  RxDouble scrollPosition_idea_groups = 0.0.obs;

  ScrollController scrollController_ungrouped = ScrollController();
  RxDouble scrollPosition_ungrouped = 0.0.obs;

  ScrollController scrollController_groupitems = ScrollController();
  RxDouble scrollPosition_groupitems = 0.0.obs;

  TextEditingController groupName = TextEditingController();

  RxBool isLoading = true.obs;

  RxBool isEditing_for_bottomsheet = false.obs;
  RxBool isEditing_for_homescreen = false.obs;

  RxBool selectAll = false.obs;

  RxString selectedNameoftheGroupBottomSheet = "".obs;
  RxString selectedGroupIDBottomSheet = "".obs;
  RxString selectedProjectNameBottomSheet = "".obs;

  CarouselController carouselController = CarouselController();
  RxInt selectedCarouselIndex = 0.obs;

  late StreamSubscription<bool> keyboardSubscription;
  RxBool isKeyboardOpen = false.obs;
  FocusNode createnameTextFocusNode = FocusNode();

  final GlobalKey addIdeaShocaseKey = GlobalKey();

  RxString selected_project_id = "".obs;
  RxString selected_group_id = "".obs;

  RxString selected_previous_groupid_for_moving = "".obs;

  @override
  void onInit() async {
    projectID.value = await Get.arguments['projectID'];
    projectName.value = await Get.arguments['projectName'];
    await getProjectsIdea();
    await getProjectsArchivedIdea();
    scrollController_archived.addListener(() {
      scrollPosition_archived.value = scrollController_archived.position.pixels;
    });

    scrollController_idea_groups.addListener(() {
      scrollPosition_idea_groups.value =
          scrollController_idea_groups.position.pixels;
    });

    scrollController_ungrouped.addListener(() {
      scrollPosition_ungrouped.value =
          scrollController_ungrouped.position.pixels;
    });

    scrollController_groupitems.addListener(() {
      scrollPosition_groupitems.value =
          scrollController_groupitems.position.pixels;
    });
    isLoading(false);
    if (Get.find<StorageServices>().storage.read("showcaseIdeasGallery") ==
        null) {
      Timer(Duration(seconds: 1), () {
        ShowCaseWidget.of(Get.context!).startShowCase([
          addIdeaShocaseKey,
        ]);
        Get.find<StorageServices>().showcaseIdeasGallery(isDone: "done");
      });
    }
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible == true) {
        isKeyboardOpen.value = true;
      } else {
        isKeyboardOpen.value = false;
        createnameTextFocusNode.unfocus();
      }
      print(isKeyboardOpen.value);
    });

    super.onInit();
  }

  @override
  void onClose() {
    scrollController_archived.dispose();
    scrollController_idea_groups.dispose();
    scrollController_ungrouped.dispose();
    keyboardSubscription.cancel();
    scrollController_groupitems.dispose();
    super.onClose();
  }

  getProjectsIdea() async {
    // RxList<FinalProjectGalleryModel> see_all_listPlaceHolder =
    //     <FinalProjectGalleryModel>[].obs;
    RxList<FinalProjectGalleryModel> ungrouped_listPlaceHolder =
        <FinalProjectGalleryModel>[].obs;
    RxList<FinalProjectGalleryModel> grouped_listPlaceHolder =
        <FinalProjectGalleryModel>[].obs;
    // var result =
    //     await ProjectIdeasApi.getProjectIdeasApi(projectID: projectID.value);

    List data = Get.find<StorageServices>().storage.read("data");

    for (var i = 0; i < data.length; i++) {
      if (data[i]["id"] == projectID.value) {
        for (var x = 0; x < data[i]["ideas"].length; x++) {
          if (data[i]["ideas"][x]['isArchived'] == false) {
            ungrouped_listPlaceHolder.add(FinalProjectGalleryModel(
                ideaNameOrIdeaGroupname: data[i]["ideas"][x]['label'] == null
                    ? ""
                    : data[i]["ideas"][x]['label'],
                isGroup: false,
                groupIdOrIdeaId: data[i]["ideas"][x]['_id'],
                ideaFileImage: data[i]["ideas"][x]['file']['filename'],
                groupIdeaImage: [],
                numberorideas: "",
                dateCreated:
                    DateTime.parse(data[i]["ideas"][x]['createdAt'].toString()),
                isSelected: false.obs));
          }
        }

        for (var x = 0; x < data[i]["ideaGroups"].length; x++) {
          if (data[i]["ideaGroups"][x]['isArchived'] == false) {
            List<GroupIdeaImage> images = [];
            for (var z = 0; z < data[i]["ideaGroups"][x]["ideas"].length; z++) {
              if (data[i]["ideaGroups"][x]["ideas"][z]['isArchived'] == false) {
                images.add(GroupIdeaImage(
                  fileImage: data[i]["ideaGroups"][x]["ideas"][z]['file']
                              ['filename'] ==
                          null
                      ? ""
                      : data[i]["ideaGroups"][x]["ideas"][z]['file']
                          ['filename'],
                  ideaImageId: data[i]["ideaGroups"][x]["ideas"][z]['_id'],
                ));
              }
            }

            grouped_listPlaceHolder.add(FinalProjectGalleryModel(
                ideaNameOrIdeaGroupname:
                    data[i]["ideaGroups"][x]["name"] == null
                        ? ""
                        : data[i]["ideaGroups"][x]["name"],
                isGroup: true,
                groupIdOrIdeaId: data[i]["ideaGroups"][x]["_id"],
                ideaFileImage: "",
                groupIdeaImage: images,
                numberorideas:
                    data[i]["ideaGroups"][x]["ideas"].length.toString(),
                dateCreated: DateTime.parse(
                    data[i]["ideaGroups"][x]["createdAt"].toString()),
                isSelected: false.obs));
          }
        }
      }
    }
    // see_all_listPlaceHolder.addAll(ungrouped_listPlaceHolder);
    // see_all_listPlaceHolder.addAll(grouped_listPlaceHolder);

    // see_all_listPlaceHolder
    //     .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    // see_all_list.assignAll(see_all_listPlaceHolder.reversed.toList());

    ungrouped_listPlaceHolder
        .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    ungrouped_list.assignAll(ungrouped_listPlaceHolder.reversed.toList());

    grouped_listPlaceHolder
        .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    grouped_list.assignAll(grouped_listPlaceHolder.reversed.toList());

    print(grouped_list.length);
  }

  getProjectsArchivedIdea() async {
    RxList<FinalProjectGalleryModel> archived_list_placeHolder =
        <FinalProjectGalleryModel>[].obs;
    RxList<FinalProjectGalleryModel> ungrouped_listPlaceHolder =
        <FinalProjectGalleryModel>[].obs;
    RxList<FinalProjectGalleryModel> grouped_listPlaceHolder =
        <FinalProjectGalleryModel>[].obs;

    List data = Get.find<StorageServices>().storage.read("data");

    for (var i = 0; i < data.length; i++) {
      if (data[i]["id"] == projectID.value) {
        for (var x = 0; x < data[i]["ideas"].length; x++) {
          if (data[i]["ideas"][x]['isArchived'] == true) {
            ungrouped_listPlaceHolder.add(FinalProjectGalleryModel(
                ideaNameOrIdeaGroupname: data[i]["ideas"][x]['label'] == null
                    ? ""
                    : data[i]["ideas"][x]['label'],
                isGroup: false,
                groupIdOrIdeaId: data[i]["ideas"][x]['_id'],
                ideaFileImage: data[i]["ideas"][x]['file']['filename'],
                groupIdeaImage: [],
                numberorideas: "",
                dateCreated:
                    DateTime.parse(data[i]["ideas"][x]['createdAt'].toString()),
                isSelected: false.obs));
          }
        }

        for (var x = 0; x < data[i]["ideaGroups"].length; x++) {
          if (data[i]["ideaGroups"][x]['isArchived'] == true) {
            List<GroupIdeaImage> images = [];
            for (var z = 0; z < data[i]["ideaGroups"][x]["ideas"].length; z++) {
              // if (data[i]["ideaGroups"][x]["ideas"][z]['isArchived'] == false) {
              images.add(GroupIdeaImage(
                fileImage: data[i]["ideaGroups"][x]["ideas"][z]['file']
                            ['filename'] ==
                        null
                    ? ""
                    : data[i]["ideaGroups"][x]["ideas"][z]['file']['filename'],
                ideaImageId: data[i]["ideaGroups"][x]["ideas"][z]['_id'],
              ));
              // }
            }

            grouped_listPlaceHolder.add(FinalProjectGalleryModel(
                ideaNameOrIdeaGroupname:
                    data[i]["ideaGroups"][x]["name"] == null
                        ? ""
                        : data[i]["ideaGroups"][x]["name"],
                isGroup: true,
                groupIdOrIdeaId: data[i]["ideaGroups"][x]["_id"],
                ideaFileImage: "",
                groupIdeaImage: images,
                numberorideas:
                    data[i]["ideaGroups"][x]["ideas"].length.toString(),
                dateCreated: DateTime.parse(
                    data[i]["ideaGroups"][x]["createdAt"].toString()),
                isSelected: false.obs));
          }
        }
      }
    }
    archived_list_placeHolder.addAll(ungrouped_listPlaceHolder);
    archived_list_placeHolder.addAll(grouped_listPlaceHolder);

    archived_list_placeHolder
        .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    archived_ideas_list.assignAll(archived_list_placeHolder.reversed.toList());
  }

  getAllIdeass() async {
    createGroupIdeaList.clear();
    for (var i = 0; i < ungrouped_list.length; i++) {
      createGroupIdeaList.add(ProjectCreateGroupModel(
          ideaId: ungrouped_list[i].groupIdOrIdeaId,
          label: ungrouped_list[i].ideaNameOrIdeaGroupname,
          file: ungrouped_list[i].ideaFileImage,
          isSelected: false.obs));
    }
  }

  createGroup() async {
    List ideasSelected = [];
    for (var i = 0; i < createGroupIdeaList.length; i++) {
      if (createGroupIdeaList[i].isSelected.value == true) {
        ideasSelected.add(createGroupIdeaList[i].ideaId);
      }
    }

    var result = await ProjectIdeasApi.createGroup(
        name: groupName.text, projectId: projectID.value, ideas: ideasSelected);
    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      List data = Get.find<StorageServices>().storage.read("data");
      for (var i = 0; i < data.length; i++) {
        if (data[i]['id'] == projectID.value) {
          data[i]['ideaGroups'].insert(0, result);
        }
      }
      await Get.find<StorageServices>().saveLocalDataForCaching(data: data);
      await getProjectsIdea();
    }

    for (var i = 0; i < ideasSelected.length; i++) {
      ungrouped_list.removeWhere(
          (element) => element.groupIdOrIdeaId == ideasSelected[i]);
    }

    Get.back();
    Get.back();
    Get.find<ProjectSpaceController>().getIdeasCount();

    carouselController.jumpToPage(0);
  }

  selectItemsOfGroup({required String groupID}) async {
    displayGroupItemsList.clear();
    List data = Get.find<StorageServices>().storage.read("data");
    for (var i = 0; i < data.length; i++) {
      if (data[i]['id'] == projectID.value) {
        for (var x = 0; x < data[i]['ideaGroups'].length; x++) {
          if (data[i]['ideaGroups'][x]['_id'] == groupID) {
            for (var z = 0; z < data[i]['ideaGroups'][x]['ideas'].length; z++) {
              if (data[i]['ideaGroups'][x]['ideas'][z]['isArchived'] == false) {
                ProjectDisplayGroupItemsModel item =
                    ProjectDisplayGroupItemsModel(
                        dateCreated: DateTime.parse(data[i]['ideaGroups'][x]
                                ['ideas'][z]['createdAt']
                            .toString()),
                        ideaId: data[i]['ideaGroups'][x]['ideas'][z]['_id'],
                        label:
                            data[i]['ideaGroups'][x]['ideas'][z]['label'] ==
                                    null
                                ? ""
                                : data[i]['ideaGroups'][x]['ideas'][z]['label'],
                        file: data[i]['ideaGroups'][x]['ideas'][z]['file']
                            ["filename"],
                        isSelected: false.obs);
                displayGroupItemsList.add(item);
                displayGroupItemsList
                    .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
                displayGroupItemsList
                    .assignAll(displayGroupItemsList.reversed.toList());
              }
            }
          }
        }
      }
    }
  }

  selectAllAndDeSelectAll() {
    if (selectAll.value == false) {
      for (var i = 0; i < displayGroupItemsList.length; i++) {
        displayGroupItemsList[i].isSelected.value = false;
      }
    }
    if (selectAll.value == true) {
      for (var i = 0; i < displayGroupItemsList.length; i++) {
        displayGroupItemsList[i].isSelected.value = true;
      }
    } else {}
  }

  RxBool check_if_there_is_true_group_items() {
    bool thereisTrue = false;
    for (var i = 0; i < displayGroupItemsList.length; i++) {
      if (displayGroupItemsList[i].isSelected.value == true) {
        thereisTrue = true;
      }
    }
    return thereisTrue.obs;
  }

  RxBool check_if_there_is_true_in_ungroup_items() {
    bool thereisTrue = false;
    for (var i = 0; i < ungrouped_list.length; i++) {
      if (ungrouped_list[i].isSelected.value == true) {
        thereisTrue = true;
      }
    }
    return thereisTrue.obs;
  }

  RxBool check_if_there_is_true_in_group_boards() {
    bool thereisTrue = false;
    for (var i = 0; i < grouped_list.length; i++) {
      if (grouped_list[i].isSelected.value == true) {
        thereisTrue = true;
      }
    }
    return thereisTrue.obs;
  }

  RxBool check_if_there_is_true_in_archived_items() {
    bool thereisTrue = false;
    for (var i = 0; i < archived_ideas_list.length; i++) {
      if (archived_ideas_list[i].isSelected.value == true) {
        thereisTrue = true;
      }
    }
    return thereisTrue.obs;
  }

  archiveIdeasFromGroup(
      {required RxList<ProjectDisplayGroupItemsModel> list,
      required String groupID}) async {
    Get.back();
    RxList<ProjectDisplayGroupItemsModel> data =
        <ProjectDisplayGroupItemsModel>[].obs;
    data.assignAll(list);
    data.removeWhere((element) => element.isSelected == false);
    for (var i = 0; i < data.length; i++) {
      await ProjectIdeasApi.archivedIdea(ideaID: data[i].ideaId);

      for (var x = 0; x < grouped_list.length; x++) {
        grouped_list[x]
            .groupIdeaImage
            .removeWhere((element) => element.ideaImageId == data[i].ideaId);
      }
      List localdata = Get.find<StorageServices>().storage.read("data");

      for (var x = 0; x < localdata.length; x++) {
        if (localdata[x]['id'] == projectID.value) {
          for (var z = 0; z < localdata[x]['ideaGroups'].length; z++) {
            if (localdata[x]['ideaGroups'][z]['_id'] == groupID) {
              for (var v = 0;
                  v < localdata[x]['ideaGroups'][z]['ideas'].length;
                  v++) {
                if (localdata[x]['ideaGroups'][z]['ideas'][v]['_id'] ==
                    data[i].ideaId) {
                  localdata[x]['ideaGroups'][z]['ideas'][v]['isArchived'] =
                      true;
                }
              }
            }
          }
        }
      }
      list.removeWhere((element) => element.isSelected == true);
      await Get.find<StorageServices>()
          .saveLocalDataForCaching(data: localdata);
    }
    getProjectsIdea();
    if (Get.isRegistered<ProjectSpaceController>() == true) {
      Get.find<ProjectSpaceController>().getIdeasCount();
    }
    getProjectsArchivedIdea();
    isEditing_for_bottomsheet.value = false;
    isEditing_for_homescreen.value = false;
  }

  archivedIdeas() async {
    Get.back();
    RxList<FinalProjectGalleryModel> temporaryList =
        <FinalProjectGalleryModel>[].obs;
    temporaryList.assignAll(ungrouped_list);
    for (var i = 0; i < temporaryList.length; i++) {
      if (temporaryList[i].isSelected.value == true) {
        await ProjectIdeasApi.archivedIdea(
            ideaID: temporaryList[i].groupIdOrIdeaId);
        ungrouped_list.removeWhere((element) =>
            element.groupIdOrIdeaId == temporaryList[i].groupIdOrIdeaId);
        List data = Get.find<StorageServices>().storage.read("data");

        for (var z = 0; z < data.length; z++) {
          if (data[z]['_id'] == projectID.value) {
            for (var x = 0; x < data[z]['ideas'].length; x++) {
              if (data[z]['ideas'][x]['_id'] ==
                  temporaryList[i].groupIdOrIdeaId) {
                data[z]['ideas'][x]['isArchived'] = true;
              }
            }
          }
        }
        Get.find<StorageServices>().saveLocalDataForCaching(data: data);
      }
    }
    getProjectsIdea();
    if (Get.isRegistered<ProjectSpaceController>() == true) {
      Get.find<ProjectSpaceController>().getIdeasCount();
    }
    if (Get.isRegistered<ProjectsScreenController>() == true) {}
    getProjectsArchivedIdea();
    isEditing_for_bottomsheet.value = false;
    isEditing_for_homescreen.value = false;
  }

  archivedGroupIdeas() async {
    Get.back();

    List listOfID = [];
    for (var element in grouped_list) {
      if (element.isSelected.value == true) {
        listOfID.add(element.groupIdOrIdeaId);
      }
    }
    var result = await ProjectIdeasApi.archiveGroup(listOfID: listOfID);
    if (result == true) {
      for (var ids in listOfID) {
        grouped_list
            .removeWhere((element) => element.ideaNameOrIdeaGroupname == ids);
      }
      if (Get.isRegistered<ProjectsScreenController>() == true) {
        await Get.find<ProjectsScreenController>().getProjectsAll();
      }
      getProjectsIdea();
      getProjectsArchivedIdea();
      if (Get.isRegistered<ProjectSpaceController>() == true) {
        Get.find<ProjectSpaceController>().getIdeasCount();
      }
      Get.snackbar("Message", "Successfully archived.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }

    isEditing_for_bottomsheet.value = false;
    isEditing_for_homescreen.value = false;
  }

  renameGroupName({required String groupIdea, required String newname}) async {
    var result = await ProjectIdeasApi.renameGroupIdea(
        groupIdea: groupIdea, newname: newname);
    if (result == true) {
      selectedNameoftheGroupBottomSheet.value = newname;
      List data = Get.find<StorageServices>().storage.read("data");
      for (var i = 0; i < data.length; i++) {
        if (data[i]['id'] == projectID.value) {
          for (var x = 0; x < data[i]['ideaGroups'].length; x++) {
            if (data[i]['ideaGroups'][x]['_id'] == groupIdea) {
              data[i]['ideaGroups'][x]['name'] = newname;
            }
          }
        }
      }
      await Get.find<StorageServices>().saveLocalDataForCaching(data: data);
      getProjectsIdea();
      Get.find<ProjectSpaceController>().getIdeasCount();
      if (Get.isRegistered<ProjectsScreenController>() == true) {}
    }
  }

  getProjectsAndIdeaGroups() async {
    project_and_group_list.clear();
    project_and_group_master_list.clear();
    current_project_and_group_list.clear();
    RxList<ProjectAndGroupModel> tempList = <ProjectAndGroupModel>[].obs;
    if (Get.find<StorageServices>().storage.read('data') != null) {
      List data = await Get.find<StorageServices>().storage.read('data');
      // projectAndIdeaGroupList.assignAll(result);
      for (var i = 0; i < data.length; i++) {
        if (data[i]['isArchived'] == false) {
          List<GroupList> ideaGroupList = [];

          ideaGroupList.add(GroupList(
              id: "Ungrouped ideas",
              name: "Ungrouped ideas",
              projectId: "",
              isSelected: false.obs));

          for (var x = 0; x < data[i]['ideaGroups'].length; x++) {
            ideaGroupList.add(GroupList(
                id: data[i]['ideaGroups'][x]["id"],
                name: data[i]['ideaGroups'][x]["name"] == null ||
                        data[i]['ideaGroups'][x]["name"] == ""
                    ? "Unnamed group"
                    : data[i]['ideaGroups'][x]["name"],
                projectId: projectID.value,
                isSelected: false.obs));
          }

          ideaGroupList.add(GroupList(
              id: "Create board",
              name: "Create board",
              projectId: "",
              isSelected: false.obs));

          tempList.add(ProjectAndGroupModel(
              id: data[i]["id"],
              dateCreated: DateTime.parse(data[i]["createdAt"].toString()),
              name: data[i]["name"] == "" || data[i]["name"] == null
                  ? "Unnamed"
                  : data[i]["name"],
              groupLists: ideaGroupList,
              isShown: false.obs));
        }
      }
      tempList.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
      project_and_group_list.assignAll(tempList.reversed.toList());
      project_and_group_master_list.assignAll(project_and_group_list);

      for (var i = 0; i < project_and_group_list.length; i++) {
        if (project_and_group_list[i].id == projectID.value) {
          current_project_and_group_list.add(project_and_group_list[i]);
        }
      }
      print("length: ${current_project_and_group_list.length}");

      project_and_group_list.removeWhere((element) {
        if (element.id != projectID.value) {
          return false;
        } else {
          element.isShown.value = false;
          return true;
        }
      });
    }
  }

  checkRadioButton_for_group_not_current_projects(
      {required String projectid, required String groupidID}) {
    for (var i = 0; i < project_and_group_list.length; i++) {
      if (projectid == project_and_group_list[i].id) {
        for (var z = 0; z < project_and_group_list[i].groupLists.length; z++) {
          if (project_and_group_list[i].groupLists[z].id == groupidID) {
            project_and_group_list[i].groupLists[z].isSelected.value = true;
          } else {
            project_and_group_list[i].groupLists[z].isSelected.value = false;
          }
        }
      } else {
        for (var x = 0; x < project_and_group_list[i].groupLists.length; x++) {
          project_and_group_list[i].groupLists[x].isSelected.value = false;
        }
      }
    }

    for (var i = 0; i < current_project_and_group_list.length; i++) {
      for (var x = 0;
          x < current_project_and_group_list[i].groupLists.length;
          x++) {
        current_project_and_group_list[i].groupLists[x].isSelected.value =
            false;
      }
    }
    if (groupidID == "Ungrouped ideas") {
      selected_group_id.value = "";
    } else {
      selected_group_id.value = groupidID;
    }

    selected_project_id.value = projectid;
    print("project_id ${selected_project_id.value}");
    print("group_id ${selected_group_id.value}");
  }

  checkRadioButton_for_group_current_project(
      {required String projectid, required String groupidID}) {
    for (var i = 0; i < current_project_and_group_list.length; i++) {
      if (projectid == current_project_and_group_list[i].id) {
        for (var z = 0;
            z < current_project_and_group_list[i].groupLists.length;
            z++) {
          if (current_project_and_group_list[i].groupLists[z].id == groupidID) {
            current_project_and_group_list[i].groupLists[z].isSelected.value =
                true;
          } else {
            current_project_and_group_list[i].groupLists[z].isSelected.value =
                false;
          }
        }
      } else {
        for (var x = 0;
            x < current_project_and_group_list[i].groupLists.length;
            x++) {
          current_project_and_group_list[i].groupLists[x].isSelected.value =
              false;
        }
      }
    }

    for (var i = 0; i < project_and_group_list.length; i++) {
      for (var x = 0; x < project_and_group_list[i].groupLists.length; x++) {
        project_and_group_list[i].groupLists[x].isSelected.value = false;
      }
    }
    if (groupidID == "Ungrouped ideas") {
      selected_group_id.value = "";
    } else {
      selected_group_id.value = groupidID;
    }
    selected_project_id.value = projectid;
    print("project_id ${selected_project_id.value}");
    print("group_id ${selected_group_id.value}");
  }

  un_checkRadioButton() {
    for (var i = 0; i < project_and_group_list.length; i++) {
      for (var x = 0; x < project_and_group_list[i].groupLists.length; x++) {
        project_and_group_list[i].groupLists[x].isSelected.value = false;
      }
    }

    for (var i = 0; i < current_project_and_group_list.length; i++) {
      for (var x = 0;
          x < current_project_and_group_list[i].groupLists.length;
          x++) {
        current_project_and_group_list[i].groupLists[x].isSelected.value =
            false;
      }
    }

    selected_group_id.value = "";
    selected_project_id.value = "";
  }

  copyTo({required List<FinalProjectGalleryModel> imageList}) async {
    List imagesIDs = [];
    for (var i = 0; i < imageList.length; i++) {
      imagesIDs.add(imageList[i].groupIdOrIdeaId);
    }
    var result = await ProjectIdeasApi.copyIdea(
        groupID: selected_group_id.value,
        projectID: selected_project_id.value,
        ideaList: imagesIDs);

    if (result == false) {
    } else if (result == "Session Expired") {
    } else {
      // Get.back();
      Get.back();
      Get.snackbar(
        "Message",
        "Ideas successfully copied.",
        colorText: AppColor.white,
        backgroundColor: AppColor.darkBlue,
        snackPosition: SnackPosition.TOP,
      );
      isEditing_for_homescreen.value = false;
      for (var i = 0; i < ungrouped_list.length; i++) {
        ungrouped_list[i].isSelected.value = false;
      }
      if (Get.isRegistered<ProjectsScreenController>() == true) {
        await Get.find<ProjectsScreenController>().getProjectsAll();
        getProjectsIdea();
      }
    }
  }

  moveTo(
      {required List<FinalProjectGalleryModel> imageList,
      required String from}) async {
    List imagesIDs = [];
    for (var i = 0; i < imageList.length; i++) {
      imagesIDs.add(imageList[i].groupIdOrIdeaId);
    }
    print(selected_previous_groupid_for_moving.value);
    var result = await ProjectIdeasApi.moveidea(
        previousGroupID: selected_previous_groupid_for_moving.value,
        previousProjectID: projectID.value,
        groupID: selected_group_id.value,
        projectID: selected_project_id.value,
        ideaList: imagesIDs);
    if (result == false || result == null) {
    } else {
      print(from);
      if (from == "Group") {
        Get.back();
      }
      // Get.back();
      Get.back();

      selected_previous_groupid_for_moving.value = "";

      isEditing_for_homescreen.value = false;
      for (var i = 0; i < ungrouped_list.length; i++) {
        ungrouped_list[i].isSelected.value = false;
      }
      if (Get.isRegistered<ProjectsScreenController>() == true) {
        await Get.find<ProjectsScreenController>().getProjectsAll();
        getProjectsIdea();
      }
      Get.snackbar(
        "Message",
        "Ideas successfully moved.",
        colorText: AppColor.white,
        backgroundColor: AppColor.darkBlue,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  createNewBoardFromMoveOrCopyScreen(
      {required String projectID, required String projectName}) async {
    var result = await ProjectIdeasApi.createBoardsFromMoveorCopyScreen(
        projectId: projectID, name: projectName);
    if (result == true) {
      await Get.find<ProjectsScreenController>().getProjectsAll();
      await getProjectsAndIdeaGroups();
      for (var element in current_project_and_group_list) {
        if (projectID == element.id) {
          element.isShown.value = true;
        }
      }
      for (var element in project_and_group_list) {
        if (projectID == element.id) {
          element.isShown.value = true;
        }
      }
    }
  }

  recoverIdeas() async {
    List ideaIdList = [];
    List groupList = [];
    for (var element in archived_ideas_list) {
      if (element.isSelected.value == true) {
        if (element.isGroup == true) {
          groupList.add(element.groupIdOrIdeaId);
        } else {
          ideaIdList.add(element.groupIdOrIdeaId);
        }
      }
    }
    var result = await ProjectIdeasApi.recoverIdeas(
        ideaIdList: ideaIdList, groupIdList: groupList);
    if (result == true) {
      await Get.find<ProjectsScreenController>().getProjectsAll();
      getProjectsIdea();
      getProjectsArchivedIdea();
      if (Get.isRegistered<ProjectSpaceController>() == true) {
        Get.find<ProjectSpaceController>().getIdeasCount();
      }
      isEditing_for_homescreen.value = false;
      for (var element in archived_ideas_list) {
        element.isSelected.value = false;
      }
      Get.snackbar(
        "Message",
        "Ideas successfully restored.",
        colorText: AppColor.white,
        backgroundColor: AppColor.darkBlue,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  deleteGroup(
      {required List ideaIdList,
      required List groupIdList,
      required String groupID}) async {
    var result = await ProjectIdeasApi.deleteGroupIdeasOrIdeas(
        ideaIdList: ideaIdList, groupIdList: groupIdList);
    if (result == true) {
      await Get.find<ProjectsScreenController>().getProjectsAll();
      getProjectsIdea();
      getProjectsArchivedIdea();
      if (Get.isRegistered<ProjectSpaceController>() == true) {
        Get.find<ProjectSpaceController>().getIdeasCount();
      }
      isEditing_for_homescreen.value = false;
      for (var element in ungrouped_list) {
        element.isSelected.value = false;
      }
      for (var element in grouped_list) {
        element.isSelected.value = false;
      }
      if (groupID != "") {
        selectItemsOfGroup(groupID: groupID);
        for (var element in displayGroupItemsList) {
          element.isSelected.value = false;
        }
        isEditing_for_bottomsheet.value = false;
      }
      Get.snackbar("Message", "Successfully deleted.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }
}
