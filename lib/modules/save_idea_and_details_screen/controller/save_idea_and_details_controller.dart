import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yoooto/modules/project_space_screen/controller/project_space_controller.dart';
import 'package:yoooto/services/storage_services.dart';

import '../../my_ideas_screen/controller/my_ideas_controller.dart';
import '../../preview_selected_idea_images_screen/controller/preview_selected_idea_images_controller.dart';
import '../../project_ideas_gallery/bottomsheet/project_ideas_gallery_bottomsheet.dart';
import '../../project_ideas_gallery/controller/project_ideas_gallery_controller.dart';

import '../../project_ideas_gallery/view/project_ideas_gallery_view.dart';
import '../../project_screen/controller/projects_controller.dart';
import '../../select_photo_for_idea_screen/controller/select_photo_for_idea_controller.dart';
import '../api/save_idea_and_details_api.dart';
import '../dialogs/save_idea_and_details_dialog.dart';
import '../model/idea_images_model.dart';
import '../model/idea_projects_and_groups_model.dart';
import '../widget/add_details_Screen.dart';
import '../widget/save_idea_screen.dart';

class SaveIdeaAndDetailsController extends GetxController {
  TextEditingController forSingleImage = TextEditingController();
  TextEditingController forMultipleImage = TextEditingController();
  RxList<IdeaImagesModel> imagesList = <IdeaImagesModel>[].obs;

  List screen = [SaveIdeaScreen(), AddDetailsScreen()];

  RxInt selectedIndex = 0.obs;

  RxBool isSavetoNewProject = false.obs;
  RxBool isSavetoMyIdeas = false.obs;

  RxString isSaveTo = "".obs;

  RxString selected_project_name = "".obs;

  CarouselController carouselController = CarouselController();

  RxBool isFromHomescreen = false.obs;
  RxString projectID = "".obs;
  RxString projectName = "".obs;
  RxString groupID = "".obs;

  RxInt initialPage = 0.obs;

  RxBool isShowProjects = false.obs;
  RxBool isMyIdeasBoards = false.obs;
  RxBool isShowIdeas = false.obs;

  RxBool isCreatingIdea = false.obs;
  RxList<ProjectGroupModel> project_List = <ProjectGroupModel>[].obs;
  RxList<BoardList> myideas_board_list = <BoardList>[].obs;

  List<TextEditingController> textEditingController = [];

  @override
  void onInit() async {
    setImages();
    isSavetoMyIdeas.value = await Get.arguments['isSavetoMyIdeas'];
    isFromHomescreen.value = await Get.arguments['isFromHomescreen'];
    projectID.value = await Get.arguments['projectID'];
    projectName.value = await Get.arguments['projectName'];
    groupID.value = await Get.arguments['groupID'];

    print("IS SAVE TO MY IDEAS: ${isSavetoMyIdeas.value}");
    print("GROUP ID: ${groupID.value}");
    print("FROM HOME SCREEN? ${isFromHomescreen.value}");
    print("PROJECT ID: ${projectID.value}");
    print("PROJECT NAME: ${projectName.value}");

    if (isFromHomescreen.value == false) {
      initialPage.value = 1;
      selectedIndex.value = 1;
      carouselController.jumpToPage(1);
    }

    getProjectsAndIdeaGroups();
    getMyIdeasGroups();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setImages() async {
    imagesList.clear();
    for (var i = 0;
        i < Get.find<SelectIdeaPhotoController>().selected_images.length;
        i++) {
      IdeaImagesModel data = IdeaImagesModel(
        imageTitle: "",
        path: Get.find<SelectIdeaPhotoController>().selected_images[i].path,
        isFirst:
            Get.find<SelectIdeaPhotoController>().selected_images[i].isFirst,
        isLast: Get.find<SelectIdeaPhotoController>().selected_images[i].isLast,
        isSelected:
            Get.find<SelectIdeaPhotoController>().selected_images[i].isSelected,
      );
      imagesList.add(data);
    }
  }

  getProjectsAndIdeaGroups() async {
    RxList<ProjectGroupModel> project_List_temp = <ProjectGroupModel>[].obs;
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

          project_List_temp.add(ProjectGroupModel(
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

  checkAndUncheck_MyIdeas(
      {required bool isSelected, required String id}) async {
    for (var element in myideas_board_list) {
      if (element.boardId == id) {
        if (isSelected == true) {
          element.isSelected.value = false;
          isSaveTo.value = "";
          isSavetoMyIdeas.value = false;
          groupID.value = "";
        } else {
          if (id != "Ungrouped ideas") {
            isSaveTo.value = "SAVE TO MYIDEAS";
            isSavetoMyIdeas.value = true;
            projectID.value = "";
            groupID.value = element.boardId;
          } else {
            isSaveTo.value = "SAVE TO MYIDEAS";
            isSavetoMyIdeas.value = true;
            projectID.value = "";
            groupID.value = "";
          }

          element.isSelected.value = true;
        }
      } else {
        element.isSelected.value = false;
      }
    }

    for (var project in project_List) {
      for (var board in project.boardList) {
        board.isSelected.value = false;
      }
    }
    isSavetoNewProject.value = false;
    print("is save to: ${isSaveTo.value}");
    print("is save to my ideas: ${isSavetoMyIdeas.value}");
    print("is save to new project: ${isSavetoNewProject.value}");
    print("group id : ${groupID.value}");
    print("project id :${projectID.value}");
  }

  checkAndUnchecked_Projects(
      {required String projectId,
      required bool isSelected,
      required String boardId}) async {
    // print(isSelected);
    for (var project in project_List) {
      if (project.projectId == projectId) {
        for (var boards in project.boardList) {
          if (boards.boardId == boardId) {
            if (isSelected == true) {
              boards.isSelected.value = false;
              projectName.value = "";
              groupID.value = "";
              isSaveTo.value = "";
              projectID.value = "";
            } else {
              boards.isSelected.value = true;
              if (boards.boardId != "Ungrouped ideas") {
                groupID.value = boards.boardId;
                isSaveTo.value = "SAVE TO GROUP";
                projectID.value = project.projectId;
                projectName.value = project.projectName;
              } else {
                projectName.value = "";
                groupID.value = "";
                isSaveTo.value = "SAVE TO PROJECT";
                projectID.value = project.projectId;
              }
            }
          } else {
            boards.isSelected.value = false;
          }
        }
      }
    }

    for (var element in myideas_board_list) {
      element.isSelected.value = false;
    }
    isSavetoMyIdeas.value = false;
    isSavetoNewProject.value = false;

    print("is save to: ${isSaveTo.value}");
    print("is save to my ideas: ${isSavetoMyIdeas.value}");
    print("is save to new project: ${isSavetoNewProject.value}");
    print("group id : ${groupID.value}");
    print("project id :${projectID.value}");
  }

  checkAndUncheckSaveToNewProject() async {
    selected_project_name.value = "";
    projectID.value = "";
    groupID.value = "";
    isSavetoMyIdeas.value = false;
    if (isSavetoNewProject.value == false) {
      isSavetoNewProject.value = true;
      isSaveTo.value = "SAVE TO NEW PROJECT";
    } else {
      isSaveTo.value = "";
      isSavetoNewProject.value = false;
    }
    for (var element in myideas_board_list) {
      element.isSelected.value = false;
    }
    for (var project in project_List) {
      for (var board in project.boardList) {
        board.isSelected.value = false;
      }
    }

    print("is save to: ${isSaveTo.value}");
    print("is save to my ideas: ${isSavetoMyIdeas.value}");
    print("is save to new project: ${isSavetoNewProject.value}");
    print("group id : ${groupID.value}");
    print("project id :${projectID.value}");
  }

  createProjectFirstBeforeCreatingIdea() async {
    print("createProjectFirstBeforeCreatingIdea");
    SaveIdeaDialog.showLoadingScreen();
    var result = await SaveIdeaAndDetailsApi.uploadImageIdea(
      saveTo: "",
      listfile: imagesList,
      projectID: projectID.value,
      groupID: groupID.value,
    );

    if (result == false) {
    } else {
      if (Get.find<StorageServices>().storage.read("data") != null) {
        List oldData = Get.find<StorageServices>().storage.read("data");
        var newData = result;
        oldData.insert(0, newData);
        Get.find<StorageServices>().saveLocalDataForCaching(data: oldData);
      } else {
        List list = [];
        list.insert(0, result);
        Get.find<StorageServices>().saveLocalDataForCaching(data: list);
      }
      // responseImage = result;
      isCreatingIdea(false);
      Get.back();
      Get.back();
      Get.back();
      Get.back();
      if (Get.isRegistered<PreviewSelectedIdeaImage>() == true) {
        Get.back();
      }
      Get.to(() => ProjectIdeasGalleryView(), arguments: {
        "projectID": result['_id'].toString(),
        "projectName": "",
      });
      if (Get.isRegistered<ProjectsScreenController>() == true) {
        Get.find<ProjectsScreenController>().getProjectsAll();
      }
      if (Get.isRegistered<ProjectSpaceController>() == true) {
        Get.find<ProjectSpaceController>().getIdeasCount();
      }
    }
  }

  uploadIdeaImageFromHomeScreen() async {
    print("uploadIdeaImageFromHomeScreen");
    SaveIdeaDialog.showLoadingScreen();

    var result = await SaveIdeaAndDetailsApi.uploadImageIdea(
      saveTo: isSaveTo.value,
      listfile: imagesList,
      projectID: projectID.value,
      groupID: groupID.value,
    );

    if (result == false) {
    } else {
      List oldData = Get.find<StorageServices>().storage.read("data");
      List newData = result;
      if (isSaveTo.value == "SAVE TO PROJECT") {
        for (var i = 0; i < oldData.length; i++) {
          if (oldData[i]["id"] == projectID.value) {
            oldData[i]["ideas"].insertAll(0, newData);
          }
        }
      } else if (isSaveTo.value == "SAVE TO GROUP") {
        for (var i = 0; i < oldData.length; i++) {
          if (oldData[i]["id"] == projectID.value) {
            for (var x = 0; x < oldData[i]["ideaGroups"].length; x++) {
              if (oldData[i]["ideaGroups"][x]['id'] == groupID.value) {
                oldData[i]["ideaGroups"][x]['ideas'].insertAll(0, newData);
              }
            }
          }
        }
      }
      Get.find<StorageServices>().saveLocalDataForCaching(data: oldData);
      isCreatingIdea(false);

      //   responseImage = result;
      //   //navigate back first before refetching data
      Get.back();
      Get.back();
      Get.back();
      Get.back();
      if (Get.isRegistered<PreviewSelectedIdeaImage>() == true) {
        Get.back();
      }

      Get.to(() => ProjectIdeasGalleryView(), arguments: {
        "projectID": projectID.value.toString(),
        "projectName": selected_project_name.value,
      });
      if (Get.isRegistered<ProjectsScreenController>() == true) {
        Get.find<ProjectsScreenController>().getProjectsAll();
      }
      if (Get.isRegistered<ProjectSpaceController>() == true) {
        Get.find<ProjectSpaceController>().getIdeasCount();
      }
    }
  }

  uploadIdeaImageFromIdeaScreen() async {
    print("uploadIdeaImageFromIdeaScreen");
    SaveIdeaDialog.showLoadingScreen();

    var result = await SaveIdeaAndDetailsApi.uploadImageIdea(
      saveTo: "SAVE TO PROJECT",
      listfile: imagesList,
      projectID: projectID.value,
      groupID: groupID.value,
    );

    if (result == false) {
    } else {
      // responseImage = result;
      isCreatingIdea(false);
      List oldData = Get.find<StorageServices>().storage.read("data");
      List newData = result;

      for (var i = 0; i < oldData.length; i++) {
        if (oldData[i]["id"] == projectID.value) {
          oldData[i]["ideas"].insertAll(0, newData);
        }
      }
      Get.find<StorageServices>().saveLocalDataForCaching(data: oldData);
      Get.back();
      Get.back();
      Get.back();
      Get.back();
      if (Get.isRegistered<PreviewSelectedIdeaImage>() == true) {
        Get.back();
      }

      if (Get.isRegistered<ProjectIdeasGalleryController>() == true) {
        await Get.find<ProjectIdeasGalleryController>().getProjectsIdea();
      }
      if (Get.isRegistered<ProjectsScreenController>() == true) {
        Get.find<ProjectsScreenController>().getProjectsAll();
      }
      if (Get.isRegistered<ProjectSpaceController>() == true) {
        Get.find<ProjectSpaceController>().getIdeasCount();
      }

      if (Get.isRegistered<ProjectIdeasGalleryController>() == true) {
        print("called here");
        Get.find<ProjectIdeasGalleryController>()
            .carouselController
            .jumpToPage(1);
      }
    }
  }

  uploadIdeaImageFromIdeaScreen_but_fromGroupFolder() async {
    print("uploadIdeaImageFromIdeaScreen_but_fromGroupFolder");
    SaveIdeaDialog.showLoadingScreen();

    var result = await SaveIdeaAndDetailsApi.uploadImage_from_group_folder(
        listfile: imagesList,
        groupID: groupID.value.toString(),
        projectID: projectID.value.toString());

    if (result == false) {
    } else {
      // responseImage = result;
      List oldData = Get.find<StorageServices>().storage.read("data");
      List newData = result;
      for (var i = 0; i < oldData.length; i++) {
        if (oldData[i]["id"] == projectID.value) {
          for (var x = 0; x < oldData[i]["ideaGroups"].length; x++) {
            if (oldData[i]["ideaGroups"][x]['id'] == groupID.value) {
              oldData[i]["ideaGroups"][x]['ideas'].insertAll(0, newData);
            }
          }
        }
      }
      Get.find<StorageServices>().saveLocalDataForCaching(data: oldData);
      isCreatingIdea(false);
      Get.back();
      Get.back();
      Get.back();
      Get.back();
      Get.back();
      if (Get.isRegistered<PreviewSelectedIdeaImage>() == true) {
        Get.back();
      }

      if (Get.isRegistered<ProjectIdeasGalleryController>() == true) {
        ProjectIdeaGallerBottomsheet.showGroupIdeas(
          groupID: Get.find<ProjectIdeasGalleryController>()
              .selectedGroupIDBottomSheet
              .value,
          controller: Get.find<ProjectIdeasGalleryController>(),
          projectName: Get.find<ProjectIdeasGalleryController>()
              .selectedProjectNameBottomSheet
              .value
              .obs,
          nameofthegroup: Get.find<ProjectIdeasGalleryController>()
              .selectedNameoftheGroupBottomSheet
              .value,
        );
        await Get.find<ProjectIdeasGalleryController>().getProjectsIdea();
        Get.find<ProjectIdeasGalleryController>()
            .selectItemsOfGroup(groupID: groupID.value);
      }
      if (Get.isRegistered<ProjectsScreenController>() == true) {
        Get.find<ProjectsScreenController>().getProjectsAll();
      }
      if (Get.isRegistered<ProjectSpaceController>() == true) {
        Get.find<ProjectSpaceController>().getIdeasCount();
      }
    }
  }

  saveToMyIdeas() async {
    SaveIdeaDialog.showLoadingScreen();
    var result = await SaveIdeaAndDetailsApi.saveToMyIdeas(
        listfile: imagesList, groupID: groupID.value);
    if (result == true) {
      if (Get.isRegistered<MyIdeasController>() == true) {
        await Get.find<MyIdeasController>()
            .getUserMyIdeasAndSharedIdeas_save_to_local();
        if (groupID.value == "") {
          Get.find<MyIdeasController>().getAllUngroupedMyIdeasToDisplay();
        } else {
          Get.find<MyIdeasController>()
              .getAllgroupedMyIdeasToDisplay(groupId: groupID.value);
        }
      }
      Get.back();
      Get.back();
      Get.back();
      Get.back();

      if (Get.isRegistered<PreviewSelectedIdeaImage>() == true) {
        Get.back();
      }
    }
  }

  createBoards_My_ideas({required String boardname}) async {
    var result =
        await SaveIdeaAndDetailsApi.createBoard_my_ideas(boardname: boardname);
    if (result == true) {
      await Get.find<MyIdeasController>()
          .getUserMyIdeasAndSharedIdeas_save_to_local();
      await getMyIdeasGroups();
      isMyIdeasBoards.value = true;
    }
  }

  createBoards_projects(
      {required String boardname, required String projectID}) async {
    var result = await SaveIdeaAndDetailsApi.createBoard_projects(
        boardname: boardname, projectID: projectID);
    if (result == true) {
      await Get.find<ProjectsScreenController>().getProjectsAll();
      await getProjectsAndIdeaGroups();
      isShowProjects.value = true;
      for (var element in project_List) {
        if (projectID == element.projectId) {
          element.isShown.value = true;
        }
      }
    }
  }
}
