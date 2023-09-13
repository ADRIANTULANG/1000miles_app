import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../constant/colors_class.dart';
import '../../../services/storage_services.dart';
import '../../project_screen/controller/projects_controller.dart';
import '../api/my_ideas_api.dart';
import '../model/my_ideas_model.dart';
import '../model/my_ideas_project_and_boards_model.dart';
import '../model/my_ideas_single_item_model.dart';

class MyIdeasController extends GetxController {
  CarouselController carouselController = CarouselController();
  RxInt selectedIndex = 0.obs;

  RxList<MyIdeasModel> myIdeas_ungrouped_list = <MyIdeasModel>[].obs;
  RxList<MyIdeasModel> myIdeas_grouped_list = <MyIdeasModel>[].obs;

  RxList<MyIdeasModel> sharedIdeas_ungrouped_list = <MyIdeasModel>[].obs;
  RxList<MyIdeasModel> sharedIdeas_grouped_list = <MyIdeasModel>[].obs;

  RxList<MyIdeasModel> archived_ideas = <MyIdeasModel>[].obs;

  RxList<MyIdeaSingleModel> ideas_List = <MyIdeaSingleModel>[].obs;

  ScrollController scrollController_recently_viewed = ScrollController();
  RxDouble scrollPosition_recently_viewed = 0.0.obs;

  ScrollController scrollController_shared = ScrollController();
  RxDouble scrollPosition_shared = 0.0.obs;

  ScrollController scrollController_archived = ScrollController();
  RxDouble scrollPosition_archived = 0.0.obs;

  RxList<ProjectBoardModel> project_List = <ProjectBoardModel>[].obs;
  RxList<BoardList> myideas_board_list = <BoardList>[].obs;

  AutoScrollController autoscroll_controller_boards = AutoScrollController();
  AutoScrollController autoscroll_controller_ideas = AutoScrollController();

  RxBool isShowProjects = false.obs;
  RxBool isMyIdeasBoards = false.obs;

  RxBool isEditing = false.obs;

  RxString selected_projectID = "".obs;
  RxString selected_boardID = "".obs;

  RxString selected_board_name_to_rename = "".obs;

  TextEditingController emailAddress = TextEditingController();

  @override
  void onInit() {
    getMyIdeas_ProjectsIdea();
    getSharedIdeas_ProjectsIdea();
    getArchived_ideas();
    getUserMyIdeasAndSharedIdeas_save_to_local();

    scrollController_recently_viewed.addListener(() {
      scrollPosition_recently_viewed.value =
          scrollController_recently_viewed.position.pixels;
    });

    scrollController_shared.addListener(() {
      scrollPosition_shared.value = scrollController_shared.position.pixels;
    });

    scrollController_archived.addListener(() {
      scrollPosition_archived.value = scrollController_archived.position.pixels;
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollController_recently_viewed.dispose();
    scrollController_shared.dispose();
    scrollController_archived.dispose();

    super.onClose();
  }

  getUserMyIdeasAndSharedIdeas_save_to_local() async {
    var result = await MyIdeasApi.getUserMyIdeasAndSharedIdeas();
    if (result == false) {
    } else {
      await Get.find<StorageServices>()
          .saveLocalDataMyIdeasForCaching(data: result['userIdeas']);
      await Get.find<StorageServices>()
          .saveLocalDataSharedWithMeForCaching(data: result['sharedIdeas']);
      getMyIdeas_ProjectsIdea();
      getSharedIdeas_ProjectsIdea();
      getArchived_ideas();
    }
  }

  getMyIdeas_ProjectsIdea() async {
    RxList<MyIdeasModel> ungrouped_listPlaceHolder = <MyIdeasModel>[].obs;
    RxList<MyIdeasModel> grouped_listPlaceHolder = <MyIdeasModel>[].obs;

    var myideas_data = Get.find<StorageServices>().storage.read("myideas");
    if (myideas_data != null) {
      List myideas_ungrouped = myideas_data['ideas'];

      for (var i = 0; i < myideas_ungrouped.length; i++) {
        if (myideas_ungrouped[i]['isArchived'] == false) {
          ungrouped_listPlaceHolder.add(MyIdeasModel(
              ideaNameOrIdeaGroupname: myideas_ungrouped[i]['label'] == null
                  ? ""
                  : myideas_ungrouped[i]['label'],
              isGroup: false,
              groupIdOrIdeaId: myideas_ungrouped[i]['_id'],
              ideaFileImage: myideas_ungrouped[i]['file']['filename'],
              groupIdeaImage: [],
              numberorideas: "",
              dateCreated:
                  DateTime.parse(myideas_ungrouped[i]['createdAt'].toString()),
              isSelected: false.obs));
        }
      }

      List myideas_group = myideas_data['ideaBoards'];

      for (var i = 0; i < myideas_group.length; i++) {
        if (myideas_group[i]['isArchived'] == false) {
          List<GroupIdeaImage> images = [];
          for (var z = 0; z < myideas_group[i]["ideas"].length; z++) {
            if (myideas_group[i]["ideas"][z]['isArchived'] == false) {
              images.add(GroupIdeaImage(
                fileImage:
                    myideas_group[i]["ideas"][z]['file']['filename'] == null
                        ? ""
                        : myideas_group[i]["ideas"][z]['file']['filename'],
                ideaImageId: myideas_group[i]["ideas"][z]['_id'],
              ));
            }
          }

          grouped_listPlaceHolder.add(MyIdeasModel(
              ideaNameOrIdeaGroupname: myideas_group[i]['name'] == null
                  ? ""
                  : myideas_group[i]['name'],
              isGroup: true,
              groupIdOrIdeaId: myideas_group[i]['_id'],
              ideaFileImage: "",
              groupIdeaImage: images,
              numberorideas: myideas_group[i]['ideas'].length.toString(),
              dateCreated:
                  DateTime.parse(myideas_group[i]["createdAt"].toString()),
              isSelected: false.obs));
        }
      }
    }

    ungrouped_listPlaceHolder
        .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    myIdeas_ungrouped_list
        .assignAll(ungrouped_listPlaceHolder.reversed.toList());

    grouped_listPlaceHolder
        .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    myIdeas_grouped_list.assignAll(grouped_listPlaceHolder.reversed.toList());
  }

  getSharedIdeas_ProjectsIdea() async {
    RxList<MyIdeasModel> ungrouped_listPlaceHolder = <MyIdeasModel>[].obs;
    RxList<MyIdeasModel> grouped_listPlaceHolder = <MyIdeasModel>[].obs;

    var sharedIdeas_data = Get.find<StorageServices>().storage.read("shared");
    if (sharedIdeas_data != null) {
      List sharedIdeas_ungrouped = sharedIdeas_data['ideas'];

      for (var i = 0; i < sharedIdeas_ungrouped.length; i++) {
        if (sharedIdeas_ungrouped[i]['isArchived'] == false) {
          ungrouped_listPlaceHolder.add(MyIdeasModel(
              ideaNameOrIdeaGroupname: sharedIdeas_ungrouped[i]['label'] == null
                  ? ""
                  : sharedIdeas_ungrouped[i]['label'],
              isGroup: false,
              groupIdOrIdeaId: sharedIdeas_ungrouped[i]['_id'],
              ideaFileImage: sharedIdeas_ungrouped[i]['file']['filename'],
              groupIdeaImage: [],
              numberorideas: "",
              dateCreated: DateTime.parse(
                  sharedIdeas_ungrouped[i]['createdAt'].toString()),
              isSelected: false.obs));
        }
      }

      List sharedIdeas_group = sharedIdeas_data['ideaBoards'];

      for (var i = 0; i < sharedIdeas_group.length; i++) {
        if (sharedIdeas_group[i]['isArchived'] == false) {
          List<GroupIdeaImage> images = [];
          for (var z = 0; z < sharedIdeas_group[i]["ideas"].length; z++) {
            if (sharedIdeas_group[i]["ideas"][z]['isArchived'] == false) {
              images.add(GroupIdeaImage(
                fileImage:
                    sharedIdeas_group[i]["ideas"][z]['file']['filename'] == null
                        ? ""
                        : sharedIdeas_group[i]["ideas"][z]['file']['filename'],
                ideaImageId: sharedIdeas_group[i]["ideas"][z]['_id'],
              ));
            }
          }

          grouped_listPlaceHolder.add(MyIdeasModel(
              ideaNameOrIdeaGroupname: sharedIdeas_group[i]['name'] == null
                  ? ""
                  : sharedIdeas_group[i]['name'],
              isGroup: true,
              groupIdOrIdeaId: sharedIdeas_group[i]['_id'],
              ideaFileImage: "",
              groupIdeaImage: images,
              numberorideas: sharedIdeas_group[i]['ideas'].length.toString(),
              dateCreated:
                  DateTime.parse(sharedIdeas_group[i]["createdAt"].toString()),
              isSelected: false.obs));
        }
      }
    }

    ungrouped_listPlaceHolder
        .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    sharedIdeas_ungrouped_list
        .assignAll(ungrouped_listPlaceHolder.reversed.toList());

    grouped_listPlaceHolder
        .sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    sharedIdeas_grouped_list
        .assignAll(grouped_listPlaceHolder.reversed.toList());
  }

  getArchived_ideas() async {
    RxList<MyIdeasModel> ungrouped_listPlaceHolder = <MyIdeasModel>[].obs;
    RxList<MyIdeasModel> grouped_listPlaceHolder = <MyIdeasModel>[].obs;
    archived_ideas.clear();
    var myideas_data = Get.find<StorageServices>().storage.read("myideas");
    if (myideas_data != null) {
      List myideas_ungrouped = myideas_data['ideas'];

      for (var i = 0; i < myideas_ungrouped.length; i++) {
        if (myideas_ungrouped[i]['isArchived'] == true) {
          ungrouped_listPlaceHolder.add(MyIdeasModel(
              ideaNameOrIdeaGroupname: myideas_ungrouped[i]['label'] == null
                  ? ""
                  : myideas_ungrouped[i]['label'],
              isGroup: false,
              groupIdOrIdeaId: myideas_ungrouped[i]['_id'],
              ideaFileImage: myideas_ungrouped[i]['file']['filename'],
              groupIdeaImage: [],
              numberorideas: "",
              dateCreated:
                  DateTime.parse(myideas_ungrouped[i]['createdAt'].toString()),
              isSelected: false.obs));
        }
      }

      List myideas_group = myideas_data['ideaBoards'];

      for (var i = 0; i < myideas_group.length; i++) {
        if (myideas_group[i]['isArchived'] == true) {
          List<GroupIdeaImage> images = [];
          for (var z = 0; z < myideas_group[i]["ideas"].length; z++) {
            // if (myideas_group[i]["ideas"][z]['isArchived'] == false) {
            images.add(GroupIdeaImage(
              fileImage:
                  myideas_group[i]["ideas"][z]['file']['filename'] == null
                      ? ""
                      : myideas_group[i]["ideas"][z]['file']['filename'],
              ideaImageId: myideas_group[i]["ideas"][z]['_id'],
            ));
            // }
          }

          grouped_listPlaceHolder.add(MyIdeasModel(
              ideaNameOrIdeaGroupname: myideas_group[i]['name'] == null
                  ? ""
                  : myideas_group[i]['name'],
              isGroup: true,
              groupIdOrIdeaId: myideas_group[i]['_id'],
              ideaFileImage: "",
              groupIdeaImage: images,
              numberorideas: myideas_group[i]['ideas'].length.toString(),
              dateCreated:
                  DateTime.parse(myideas_group[i]["createdAt"].toString()),
              isSelected: false.obs));
        }
      }
    }
    archived_ideas.addAll(ungrouped_listPlaceHolder);
    archived_ideas.addAll(grouped_listPlaceHolder);
    archived_ideas.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    archived_ideas.assignAll(archived_ideas.reversed.toList());
  }

  getAllUngroupedMyIdeasToDisplay() async {
    List<MyIdeaSingleModel> ideas_List_partial = <MyIdeaSingleModel>[];

    var myideas_data = Get.find<StorageServices>().storage.read("myideas");
    List myideas_ungrouped = myideas_data['ideas'];
    for (var x = 0; x < myideas_ungrouped.length; x++) {
      if (myideas_ungrouped[x]['isArchived'] == false) {
        ideas_List_partial.add(MyIdeaSingleModel(
          ideaId: myideas_ungrouped[x]['_id'],
          ideaName: myideas_ungrouped[x]['label'] == null
              ? ""
              : myideas_ungrouped[x]['label'],
          ideaFilename: myideas_ungrouped[x]['file']['filename'],
          isSelected: false.obs,
          createdAt: DateTime.parse(myideas_ungrouped[x]['createdAt']),
        ));
      }
    }

    ideas_List_partial.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    ideas_List.assignAll(ideas_List_partial.reversed.toList());
    print(ideas_List.length);
  }

  getAllgroupedMyIdeasToDisplay({required String groupId}) async {
    List<MyIdeaSingleModel> ideas_List_partial = <MyIdeaSingleModel>[];

    var myideas_data = Get.find<StorageServices>().storage.read("myideas");
    List myideas_grouped = myideas_data['ideaBoards'];
    for (var i = 0; i < myideas_grouped.length; i++) {
      if (myideas_grouped[i]['isArchived'] == false) {
        if (myideas_grouped[i]['_id'] == groupId) {
          for (var z = 0; z < myideas_grouped[i]['ideas'].length; z++) {
            if (myideas_grouped[i]["ideas"][z]['isArchived'] == false) {
              ideas_List_partial.add(MyIdeaSingleModel(
                ideaId: myideas_grouped[i]["ideas"][z]['_id'],
                ideaName: myideas_grouped[i]["ideas"][z]['label'] == null
                    ? ""
                    : myideas_grouped[i]["ideas"][z]['label'],
                ideaFilename: myideas_grouped[i]["ideas"][z]['file']
                    ['filename'],
                isSelected: false.obs,
                createdAt:
                    DateTime.parse(myideas_grouped[i]["ideas"][z]['createdAt']),
              ));
            }
          }
        }
      }
    }

    ideas_List_partial.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    ideas_List.assignAll(ideas_List_partial.reversed.toList());
    print(ideas_List.length);
  }

  getAllUngroupedSharedIdeasToDisplay() async {
    List<MyIdeaSingleModel> ideas_List_partial = <MyIdeaSingleModel>[];

    var myideas_data = Get.find<StorageServices>().storage.read("shared");
    List myideas_ungrouped = myideas_data['ideas'];
    for (var x = 0; x < myideas_ungrouped.length; x++) {
      if (myideas_ungrouped[x]['isArchived'] == false) {
        ideas_List_partial.add(MyIdeaSingleModel(
          ideaId: myideas_ungrouped[x]['_id'],
          ideaName: myideas_ungrouped[x]['label'] == null
              ? ""
              : myideas_ungrouped[x]['label'],
          ideaFilename: myideas_ungrouped[x]['file']['filename'],
          isSelected: false.obs,
          createdAt: DateTime.parse(myideas_ungrouped[x]['createdAt']),
        ));
      }
    }

    ideas_List_partial.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    ideas_List.assignAll(ideas_List_partial.reversed.toList());
    print(ideas_List.length);
  }

  getAllgroupedSharedIdeasToDisplay({required String groupId}) async {
    List<MyIdeaSingleModel> ideas_List_partial = <MyIdeaSingleModel>[];

    var myideas_data = Get.find<StorageServices>().storage.read("shared");
    List myideas_grouped = myideas_data['ideaBoards'];
    for (var i = 0; i < myideas_grouped.length; i++) {
      if (myideas_grouped[i]['isArchived'] == false) {
        if (myideas_grouped[i]['_id'] == groupId) {
          for (var z = 0; z < myideas_grouped[i]['ideas'].length; z++) {
            if (myideas_grouped[i]["ideas"][z]['isArchived'] == false) {
              ideas_List_partial.add(MyIdeaSingleModel(
                ideaId: myideas_grouped[i]["ideas"][z]['_id'],
                ideaName: myideas_grouped[i]["ideas"][z]['label'] == null
                    ? ""
                    : myideas_grouped[i]["ideas"][z]['label'],
                ideaFilename: myideas_grouped[i]["ideas"][z]['file']
                    ['filename'],
                isSelected: false.obs,
                createdAt:
                    DateTime.parse(myideas_grouped[i]["ideas"][z]['createdAt']),
              ));
            }
          }
        }
      }
    }

    ideas_List_partial.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    ideas_List.assignAll(ideas_List_partial.reversed.toList());
    print(ideas_List.length);
  }

  getProjectsAndIdeaBoards() async {
    RxList<ProjectBoardModel> project_List_temp = <ProjectBoardModel>[].obs;
    if (Get.find<StorageServices>().storage.read('data') != null) {
      List data = await Get.find<StorageServices>().storage.read('data');
      for (var i = 0; i < data.length; i++) {
        if (data[i]['isArchived'] == false) {
          List<BoardList> boardList = [];
          // createdAt

          for (var x = 0; x < data[i]['ideaGroups'].length; x++) {
            if (data[i]['ideaGroups'][x]['isArchived'] == false) {
              boardList.add(BoardList(
                  dateCreate:
                      DateTime.parse(data[i]['ideaGroups'][x]['createdAt']),
                  boardId: data[i]['ideaGroups'][x]['_id'],
                  boardName: data[i]['ideaGroups'][x]["name"] == null
                      ? ""
                      : data[i]['ideaGroups'][x]["name"],
                  isSelected: false.obs));
            }
          }
          boardList.sort((a, b) => a.dateCreate.compareTo(b.dateCreate));
          boardList.assignAll(boardList.toList());
          // boardList.insert(index, element);
          boardList.insert(
              0,
              BoardList(
                boardId: "Ungrouped ideas",
                boardName: "Ungrouped ideas",
                isSelected: false.obs,
                dateCreate: DateTime.now(),
              ));
          boardList.insert(
              boardList.length,
              BoardList(
                boardId: "Create board",
                boardName: "Create board",
                isSelected: false.obs,
                dateCreate: DateTime.now(),
              ));

          project_List_temp.add(ProjectBoardModel(
              isShown: false.obs,
              projectId: data[i]["_id"],
              projectName: data[i]["name"] == null ? "" : data[i]["name"],
              boardList: boardList));
        }
      }
    }
    project_List.assignAll(project_List_temp);
  }

  getMyIdeasGroups() async {
    RxList<BoardList> myideas_board_list_temp = <BoardList>[].obs;
    var myideas_data = Get.find<StorageServices>().storage.read("myideas");
    List myideas_grouped = myideas_data['ideaBoards'];

    for (var i = 0; i < myideas_grouped.length; i++) {
      myideas_board_list_temp.add(BoardList(
          dateCreate: DateTime.parse(myideas_grouped[i]['createdAt']),
          boardId: myideas_grouped[i]['_id'],
          isSelected: false.obs,
          boardName: myideas_grouped[i]['name'] == null
              ? "Untitled"
              : myideas_grouped[i]['name']));
    }
    myideas_board_list_temp
        .sort((a, b) => a.dateCreate.compareTo(b.dateCreate));
    myideas_board_list_temp.assignAll(myideas_board_list_temp.toList());
    myideas_board_list_temp.insert(
        0,
        BoardList(
          boardId: "Ungrouped ideas",
          boardName: "Ungrouped ideas",
          isSelected: false.obs,
          dateCreate: DateTime.now(),
        ));
    myideas_board_list_temp.insert(
        myideas_board_list_temp.length,
        BoardList(
          boardId: "Create board",
          boardName: "Create board",
          isSelected: false.obs,
          dateCreate: DateTime.now(),
        ));
    myideas_board_list.assignAll(myideas_board_list_temp);
  }

  uncheckAll() {
    for (var i = 0; i < myideas_board_list.length; i++) {
      myideas_board_list[i].isSelected.value = false;
    }
    for (var i = 0; i < project_List.length; i++) {
      for (var x = 0; x < project_List[i].boardList.length; x++) {
        project_List[i].boardList[x].isSelected.value = false;
      }
    }
    selected_projectID.value = "";
    selected_boardID.value = "";
  }

  checkForMyIdeas({required String boardID}) async {
    for (var i = 0; i < myideas_board_list.length; i++) {
      if (myideas_board_list[i].boardId == boardID) {
        if (myideas_board_list[i].isSelected.value == true) {
          myideas_board_list[i].isSelected.value = false;
        } else {
          myideas_board_list[i].isSelected.value = true;
        }
      } else {
        myideas_board_list[i].isSelected.value = false;
      }
    }
    for (var i = 0; i < project_List.length; i++) {
      for (var x = 0; x < project_List[i].boardList.length; x++) {
        project_List[i].boardList[x].isSelected.value = false;
      }
    }
    if (boardID == "Ungrouped ideas") {
      selected_boardID.value = "";
    } else {
      selected_boardID.value = boardID;
    }

    print("projectID: ${selected_projectID.value}");
    print("boardID: ${selected_boardID.value}");
  }

  checkForProjects({required String boardID, required String projectID}) async {
    for (var i = 0; i < project_List.length; i++) {
      if (project_List[i].projectId == projectID) {
        for (var x = 0; x < project_List[i].boardList.length; x++) {
          if (project_List[i].boardList[x].boardId == boardID) {
            if (project_List[i].boardList[x].isSelected.value == true) {
              project_List[i].boardList[x].isSelected.value = false;
            } else {
              project_List[i].boardList[x].isSelected.value = true;
            }
          } else {
            project_List[i].boardList[x].isSelected.value = false;
          }
        }
      }
    }
    for (var i = 0; i < myideas_board_list.length; i++) {
      myideas_board_list[i].isSelected.value = false;
    }
    if (boardID == "Ungrouped ideas") {
      selected_boardID.value = "";
    } else {
      selected_boardID.value = boardID;
    }
    selected_projectID.value = projectID;
    print("projectID: ${selected_projectID.value}");
    print("boardID: ${selected_boardID.value}");
  }

  renameGroup({
    required String groupID,
    required String groupName,
  }) async {
    var result =
        await MyIdeasApi.renameGroup(groupID: groupID, groupName: groupName);
    if (result == true) {
      selected_board_name_to_rename.value = groupName;
      getUserMyIdeasAndSharedIdeas_save_to_local();
    }
  }

  archivedMyIdeas(
      {required List ideasImagesToArchived,
      required String groupID,
      required List groupIDtoArchive}) async {
    var result = await MyIdeasApi.archivedIdeas(
        imagestoarchive: ideasImagesToArchived,
        groupToArchive: groupIDtoArchive);
    print("groupid: ${groupID}");
    isEditing.value = false;
    if (result == true) {
      await getUserMyIdeasAndSharedIdeas_save_to_local();
      if (groupID == "") {
        getAllUngroupedMyIdeasToDisplay();
      } else {
        getAllgroupedMyIdeasToDisplay(groupId: groupID);
      }
      Get.snackbar("Message", "Successfully archived.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  moveIdeas(
      {required String previousBoardID,
      required String destinationProjectID,
      required String destinationBoardID,
      required List imageIdList}) async {
    if (destinationProjectID != "" && destinationBoardID != "") {
      destinationProjectID = "";
    }
    print("projectID: ${destinationProjectID}");
    print("boardID: ${destinationBoardID}");
    var result = await MyIdeasApi.moveIdeas(
        previousBoardID: previousBoardID,
        destinationProjectID: destinationProjectID,
        destinationBoardID: destinationBoardID,
        imageIdList: imageIdList);
    if (result == true) {
      isEditing.value = false;
      if (result == true) {
        if (Get.isRegistered<ProjectsScreenController>() == true) {
          Get.find<ProjectsScreenController>().getProjectsAll();
        }
        await getUserMyIdeasAndSharedIdeas_save_to_local();
        if (previousBoardID == "") {
          getAllUngroupedMyIdeasToDisplay();
        } else {
          getAllgroupedMyIdeasToDisplay(groupId: previousBoardID);
        }
        Get.back();
        Get.back();
        Get.snackbar("Message", "Successfully moved ideas.",
            colorText: Colors.white,
            backgroundColor: AppColor.darkBlue,
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3));
      }
    }
  }

  copyIdeas(
      {required String selectedBoardID,
      required String destinationProjectID,
      required String destinationBoardID,
      required List imageIdList}) async {
    if (destinationProjectID != "" && destinationBoardID != "") {
      destinationProjectID = "";
    }
    var result = await MyIdeasApi.copyIdeas(
        destinationProjectID: destinationProjectID,
        destinationBoardID: destinationBoardID,
        imageIdList: imageIdList);
    if (result == true) {
      isEditing.value = false;
      if (result == true) {
        if (Get.isRegistered<ProjectsScreenController>() == true) {
          Get.find<ProjectsScreenController>().getProjectsAll();
        }
        await getUserMyIdeasAndSharedIdeas_save_to_local();
        if (selectedBoardID == "") {
          getAllUngroupedMyIdeasToDisplay();
        } else {
          getAllgroupedMyIdeasToDisplay(groupId: selectedBoardID);
        }
        Get.back();
        Get.back();
        Get.snackbar("Message", "Successfully copied ideas.",
            colorText: Colors.white,
            backgroundColor: AppColor.darkBlue,
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3));
      }
    }
  }

  createBoardWithIdeas(
      {required String boardName, required List imageIdList}) async {
    var result = await MyIdeasApi.createBoardWithIdeas(
        boardName: boardName, imageIdList: imageIdList);
    if (result == true) {
      Get.back();
      await getUserMyIdeasAndSharedIdeas_save_to_local();
    }
  }

  recoverMyideas(
      {required List imageIdList, required List groupsToRecover}) async {
    var result = await MyIdeasApi.restoreMyIdeas(
        imageIdList: imageIdList, groupsToRecover: groupsToRecover);
    if (result == true) {
      await getUserMyIdeasAndSharedIdeas_save_to_local();
      isEditing.value = false;

      Get.snackbar("Message", "Ideas restored.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  RxBool check_if_there_is_true_in_archived_list() {
    bool isCheck = false;
    for (var i = 0; i < archived_ideas.length; i++) {
      if (archived_ideas[i].isSelected.value == true) {
        isCheck = true;
      }
    }
    return isCheck.obs;
  }

  RxBool check_if_there_is_true_in_grouped_list() {
    bool isCheck = false;
    for (var i = 0; i < myIdeas_grouped_list.length; i++) {
      if (myIdeas_grouped_list[i].isSelected.value == true) {
        isCheck = true;
      }
    }
    return isCheck.obs;
  }

  RxBool check_if_there_is_true_in_Ungrouped_list() {
    bool isCheck = false;
    for (var i = 0; i < ideas_List.length; i++) {
      if (ideas_List[i].isSelected.value == true) {
        isCheck = true;
      }
    }
    return isCheck.obs;
  }

  shareIdeas(
      {required List ideasIdList,
      required String email,
      required String teamID}) async {
    var result = await MyIdeasApi.sharedIdeas(
        ideaIDList: ideasIdList, email: email, teamID: teamID);
    if (result == true) {
      isEditing.value = false;
      Get.back();
      Get.snackbar("Message", "Ideas successfully shared.",
          colorText: Colors.white,
          backgroundColor: AppColor.darkBlue,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  shareGroup(
      {required List groupIdList,
      required String email,
      required String teamID}) async {
    var result = await MyIdeasApi.sharedGroup(
        groupIdList: groupIdList, email: email, teamID: teamID);
    if (result == true) {
      isEditing.value = false;
      Get.back();
      Get.snackbar(
        "Message",
        "Ideas successfully shared.",
        colorText: Colors.white,
        backgroundColor: AppColor.darkBlue,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  deleteGroup(
      {required List ideaIdList,
      required List groupIdList,
      required String groupID}) async {
    var result = await MyIdeasApi.deleteGroupIdeasOrIdeas(
        ideaIdList: ideaIdList, groupIdList: groupIdList);
    if (result == true) {
      await getUserMyIdeasAndSharedIdeas_save_to_local();
      isEditing.value = false;

      if (groupID != "") {
        getAllgroupedMyIdeasToDisplay(groupId: groupID);
      } else {
        getAllUngroupedMyIdeasToDisplay();
      }
      Get.snackbar(
        "Message",
        "Ideas successfully deleted.",
        colorText: AppColor.white,
        backgroundColor: AppColor.darkBlue,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  createBoards_My_ideas({required String boardname}) async {
    var result = await MyIdeasApi.createBoard_my_ideas(boardname: boardname);
    if (result == true) {
      await Get.find<MyIdeasController>()
          .getUserMyIdeasAndSharedIdeas_save_to_local();
      await getMyIdeasGroups();
      isMyIdeasBoards.value = true;
    }
  }

  createBoards_projects(
      {required String boardname, required String projectID}) async {
    var result = await MyIdeasApi.createBoard_projects(
        boardname: boardname, projectID: projectID);
    if (result == true) {
      await Get.find<ProjectsScreenController>().getProjectsAll();
      await getProjectsAndIdeaBoards();
      isShowProjects.value = true;
      for (var element in project_List) {
        if (projectID == element.projectId) {
          element.isShown.value = true;
        }
      }
    }
  }
}
