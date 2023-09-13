import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/services/storage_services.dart';

import '../../feed_screen/controller/feed_screen_controller.dart';
import '../../login_and_register_screen/view/pre_login_and_register_view.dart';
import '../../my_ideas_screen/controller/my_ideas_controller.dart';
import '../../my_ideas_screen/view/my_ideas_main_view.dart';
import '../../project_screen/controller/projects_controller.dart';
import '../../project_screen/view/project_home_screen.dart';
import '../../project_space_screen/view/project_space_view.dart';
import '../../update_screen/controller/updates_controller.dart';
import '../api/bottom_navigation_screen_api.dart';
import '../model/team_model.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// import '../../update_screen/view/updates_view.dart';
// import '../../feed_screen/view/feed_screen_view.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isLoading = true.obs;

  var bottomNavContext = Get.context;

  RxBool isEnableContinueButton = false.obs;

  RxBool isCreatingProject = false.obs;

  RxString selectedTeam = "".obs;

  FocusNode projectTagFocusNode = FocusNode();
  FocusNode projectNameFocusNode = FocusNode();
  RxBool isFocusProjectTag = true.obs;
  RxBool isFocusProjectName = true.obs;
  RxBool isKeyboardOpen = false.obs;
  RxList<TeamModel> usersTeamList = <TeamModel>[].obs;

  TextEditingController projectname = TextEditingController();
  TextEditingController projecttags = TextEditingController();

  RxString tagValues = "".obs;

  Random rnd = new Random();

  List<Color> colorList = [
    AppColor.accentTorquise,
    AppColor.redAccent,
    AppColor.greyBlue,
    AppColor.orangeAccent,
    AppColor.black
  ];

  List views = <Widget>[
    ProjectHomeScreenView(),
    MyIdeasMainView(),
    Container(),
    // FeedScreen(),
    // UpdatesView(),
    // AccountScreen(),
  ];

  final GlobalKey floatingButtonKey = GlobalKey();
  // RxBool projectSelected = true.obs;
  // RxBool uploadSelected = false.obs;
  // RxBool updateSelected = false.obs;
  // RxBool accountSelected = false.obs;
  Timer? timechecker;

  late StreamSubscription<bool> keyboardSubscription;

  @override
  InternalFinalCallback<void> get onDelete => timerCancel();

  timerCancel() {
    if (timechecker != null) {
      timechecker!.cancel();
      print("deleted the timer");
    }
    return super.onDelete;
  }

  @override
  void onInit() async {
    expirationListener();
    if (Get.isRegistered<BottomNavigationController>() == true) {
      projectTagFocusNode.addListener(() {
        if (projectTagFocusNode.hasFocus == true) {
          isFocusProjectTag.value = true;
          isFocusProjectName.value = false;
          print("project tag has focus");
        } else {
          print("project tag no focus");
          isFocusProjectTag.value = false;
          isFocusProjectName.value = false;
        }
      });
      projectNameFocusNode.addListener(() {
        if (projectNameFocusNode.hasFocus == true) {
          isFocusProjectName.value = true;
          isFocusProjectTag.value = false;
          print("project name has focus");
        } else {
          print("project name no focus");
          isFocusProjectName.value = false;
          isFocusProjectTag.value = false;
        }
      });
      var keyboardVisibilityController = KeyboardVisibilityController();
      keyboardSubscription =
          keyboardVisibilityController.onChange.listen((bool visible) {
        if (visible == true) {
          isKeyboardOpen.value = true;
        } else {
          projectNameFocusNode.unfocus();
          projectTagFocusNode.unfocus();
          isKeyboardOpen.value = false;
          isFocusProjectName.value = false;
          isFocusProjectTag.value = false;
        }
      });

      await Get.put(ProjectsScreenController());
      await Get.put(FeedScreenController());
      await Get.put(MyIdeasController());
      await Get.put(UpdatesViewController());
    }
    getUsersTeam();
    super.onInit();
  }

  @override
  void onClose() {
    keyboardSubscription.cancel();
    // timechecker!.cancel();
    projectTagFocusNode.dispose();
    projectNameFocusNode.dispose();
    super.onClose();
  }

  expirationListener() {
    if (Get.find<StorageServices>().storage.read('expirationDate') != null ||
        Get.find<StorageServices>().storage.read('expirationDate') != "") {
      var expirationDate = DateTime.parse(
          Get.find<StorageServices>().storage.read('expirationDate'));
      print("Expiration Date:" +
          DateFormat.yMMMd().format(expirationDate) +
          " " +
          DateFormat.jm().format(expirationDate));
      timechecker = Timer.periodic(Duration(seconds: 60), (timer) async {
        if (expirationDate.isBefore(DateTime.now()) == true) {
          Get.find<StorageServices>().removeStorageCredentials();
          print("timer cancelled");
          timechecker!.cancel();
          timer.cancel();
          Get.offAll(() => PreLoginView());
        } else {
          print("Expiration Date:" +
              DateFormat.yMMMd().format(expirationDate) +
              " " +
              DateFormat.jm().format(expirationDate) +
              " dli pa expire");
        }
      });
    }
  }

  getUsersTeam() async {
    usersTeamList.clear();
    var result = await BottomNavigationScreenApi.getUsersTeam();
    if (result == "Session Expired") {
    } else {
      for (var i = 0; i < result.length; i++) {
        List<Member> members = [];
        for (var x = 0; x < result[i]['invites'].length; x++) {
          members.add(Member(
            id: result[i]['invites'][x]['user']['_id'],
            name: result[i]['invites'][x]['user']['name'],
            email: result[i]['invites'][x]['user']['email'],
          ));
        }
        usersTeamList.add(TeamModel(
            id: result[i]['_id'],
            name: result[i]['name'],
            createdBy: result[i]['createdBy'],
            active: result[i]['isActive'],
            dateCreate: DateTime.parse(result[i]['createdAt'].toString()),
            dateWrite: DateTime.parse(result[i]['updatedAt'].toString()),
            members: members,
            isSelected: false.obs));
      }
    }
  }

  getRandom() {
    int min = 0, max = 4;
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  changeRadioButton({required String id}) {
    for (var i = 0; i < usersTeamList.length; i++) {
      if (id == usersTeamList[i].id) {
        usersTeamList[i].isSelected.value = true;
        selectedTeam.value = usersTeamList[i].id.toString();
      } else {
        usersTeamList[i].isSelected.value = false;
      }
    }
  }

  createProject() async {
    List tagList = projecttags.text
        .replaceAll(RegExp('#'), "")
        .trim()
        .removeAllWhitespace
        .split(',');
    if (projecttags.text.isEmpty) {
      tagList.removeAt(0);
    }
    print(tagList.length);
    var result = await BottomNavigationScreenApi.createProject(
        projectName: projectname.text, tags: tagList, team: selectedTeam.value);
    if (result == "Session Expired") {
    } else if (result == false) {
    } else {
      if (Get.isRegistered<ProjectsScreenController>() == true) {
        await Get.find<ProjectsScreenController>().getProjectsAll();
      }
      Get.back();
      Get.to(() => ProjectSpaceView(), arguments: {
        'projectName': result[1].toString(),
        'projectID': result[0].toString()
      });
    }
  }

  tagsMaker({required String text}) {
    List tagList = projecttags.text.split(',');
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
}
