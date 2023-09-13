import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:yoooto/constant/colors_class.dart';
import 'package:yoooto/constant/font_family_class.dart';
import 'package:yoooto/services/storage_services.dart';

import '../../project_ideas_gallery/controller/project_ideas_gallery_controller.dart';
import '../../project_screen/controller/projects_controller.dart';
import '../api/idea_details_api.dart';
import '../model/idea_detail_model.dart';

class IdeaDetailController extends GetxController {
  RxString ideaID = "".obs;
  RxString projectID = "".obs;
  RxString groupID = "".obs;
  RxBool isArchived = false.obs;
  GlobalKey<FlutterMentionsState> mention_key =
      GlobalKey<FlutterMentionsState>();
  IdeaDetails? ideasDetails;

  List globalKeys = [];
  List<Map<String, dynamic>> mentions = [];

  RxList<Votes> ideaVotes = <Votes>[].obs;
  RxList<Comment> ideaComments = <Comment>[].obs;

  RxString ideaName = "".obs;
  RxString ideaFileImage = "".obs;

  ScrollController scrollController = ScrollController();

  RxBool isLike = false.obs;

  RxBool isMatchedAll = false.obs;

  @override
  void onInit() async {
    ideaID.value = await Get.arguments['ideaID'];
    projectID.value = await Get.arguments['projectID'];
    groupID.value = await Get.arguments['groupID'];
    print("ideaID ${ideaID.value}");
    print("projectID ${projectID.value}");
    print("groupID ${groupID.value}");
    await getIdeaDetails();
    setIfAlreadyLike();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getIdeaDetails() async {
    mentions.clear();
    List data = Get.find<StorageServices>().storage.read('data');
    for (var i = 0; i < data.length; i++) {
      if (data[i]['_id'] == projectID.value) {
        if (data[i]['assignedTeam'] != null) {
          for (var z = 0; z < data[i]['assignedTeam']['invites'].length; z++) {
            mentions.add({
              'id': data[i]['assignedTeam']['invites'][z]['user']['_id'],
              'display': data[i]['assignedTeam']['invites'][z]['user']['name'],
              'full_name': data[i]['assignedTeam']['invites'][z]['user']
                  ['name'],
              'email': data[i]['assignedTeam']['invites'][z]['user']['email'],
              'mention':
                  "@" + data[i]['assignedTeam']['invites'][z]['user']['name'],
              'newmention': "@" +
                  data[i]['assignedTeam']['invites'][z]['user']['name']
                      .split(" ")[0],
            });
          }
        }

        for (var y = 0; y < data[i]['invites'].length; y++) {
          mentions.add({
            'id': data[i]['invites'][y]['user']['_id'],
            'display': data[i]['invites'][y]['user']['name'],
            'full_name': data[i]['invites'][y]['user']['name'],
            'email': data[i]['invites'][y]['user']['email'],
            'mention': "@" + data[i]['invites'][y]['user']['name'],
            'newmention':
                "@" + data[i]['invites'][y]['user']['name'].split(" ")[0],
          });
        }

        for (var x = 0; x < data[i]['ideas'].length; x++) {
          if (data[i]['ideas'][x]['_id'] == ideaID.value) {
            isArchived.value = data[i]['ideas'][x]['isArchived'];
            var ideaDetailtoparse =
                await ideaDetailsFromJson(jsonEncode(data[i]['ideas'][x]));
            ideasDetails = ideaDetailtoparse;

            if (ideasDetails != null) {
              ideaName.value = ideasDetails!.label.toString();
              ideaFileImage.value = ideasDetails!.file.filename.toString();

              ideaComments.assignAll(ideasDetails!.comments);
              ideaVotes.assignAll(ideasDetails!.votes);
              ideaVotes.removeWhere((element) => element.isVote == false);
            }
          }
        }
        for (var x = 0; x < data[i]['ideaGroups'].length; x++) {
          for (var z = 0; z < data[i]['ideaGroups'][x]['ideas'].length; z++) {
            if (data[i]['ideaGroups'][x]['ideas'][z]['_id'] == ideaID.value) {
              isArchived.value =
                  data[i]['ideaGroups'][x]['ideas'][z]['isArchived'];
              var ideaDetailtoparse = await ideaDetailsFromJson(
                  jsonEncode(data[i]['ideaGroups'][x]['ideas'][z]));
              ideasDetails = ideaDetailtoparse;

              if (ideasDetails != null) {
                ideaName.value = ideasDetails!.label.toString();
                ideaFileImage.value = ideasDetails!.file.filename.toString();

                ideaComments.assignAll(ideasDetails!.comments);
                ideaVotes.assignAll(ideasDetails!.votes);
                ideaVotes.removeWhere((element) => element.isVote == false);
              }
            }
          }
        }
      }
    }
  }

  setIfAlreadyLike() async {
    isLike.value = false;
    for (var i = 0; i < ideaVotes.length; i++) {
      if (ideaVotes[i].createdBy.id ==
          Get.find<StorageServices>().storage.read('id')) {
        if (ideaVotes[i].isVote == true) {
          print(ideaVotes[i].id);
          print(ideaVotes[i].createdBy.id);
          isLike.value = true;
        }
      }
    }
  }

  List<TextSpan> setMentionCollored({required String comment}) {
    List<TextSpan> textSpanList = <TextSpan>[];

    for (var i = 0; i < mentions.length; i++) {
      if (comment.contains(mentions[i]['mention'].toString().trim())) {
        comment = comment.replaceAll(mentions[i]['mention'].toString().trim(),
            mentions[i]['newmention'].toString().trim());
      }
    }
    List toParse = comment.split(" ");
    List strings = [];
    toParse.removeWhere((element) => element == "");
    for (var i = 0; i < toParse.length; i++) {
      bool isExist = false;
      for (var x = 0; x < mentions.length; x++) {
        if (toParse[i].toString().trim() ==
            mentions[x]['newmention'].toString().trim()) {
          isExist = true;
        } else {}
      }

      if (isExist == true) {
        strings.add(toParse[i].toString().trim());
        textSpanList.add(
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                for (var x = 0; x < mentions.length; x++) {
                  if (mentions[x]['newmention'] == toParse[i]) {
                    print(mentions[x]['newmention']);
                    print(mentions[x]['id']);
                    print(mentions[x]['full_name']);
                  }
                }
              },
            text: toParse[i].toString().trim() + " ",
            style: TextStyle(
                fontFamily: FontFamily.maloryBold,
                fontSize: 12.sp,
                color: AppColor.accentTorquise),
          ),
        );
      } else {
        strings.add(toParse[i].toString().trim());
        textSpanList.add(
          TextSpan(
            text: toParse[i].toString().trim() + " ",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.maloryLight,
                fontSize: 12.sp,
                color: AppColor.black),
          ),
        );
      }
    }
    return textSpanList;
  }

  String commentIdentifier({required String comment}) {
    String comm = comment.replaceAll("~", "");
    List existingMention = [];
    for (var i = 0; i < mentions.length; i++) {
      if (comm.contains(mentions[i]['id'])) {
        existingMention.add({
          "id": mentions[i]['id'].toString().trim(),
          "name": mentions[i]['full_name'].toString().trim()
        });
      }
    }
    if (existingMention.length != 0) {
      for (var x = 0; x < existingMention.length; x++) {
        comm = comm.replaceAll("${existingMention[x]['id'].toString().trim()}",
            "${existingMention[x]['name'].toString().toString()}");
      }
    } else {
      comm = comm;
    }
    return comm;
  }

  createComment({required String comment}) async {
    var result = await IdeaDetailsApi.createComment(
        ideaID: ideaID.value, comment: comment);

    if (result == true) {
      await Get.find<ProjectsScreenController>().getProjectsAll();
      getIdeaDetails();
    } else {}
  }

  voteIdea() async {
    var result = await IdeaDetailsApi.voteIdea(ideaId: ideaID.value);
    if (result == true) {
      isLike.value = false;
      await Get.find<ProjectsScreenController>().getProjectsAll();
      await getIdeaDetails();
      setIfAlreadyLike();
    } else {}
  }

  renameIdea({required String label}) async {
    var result =
        await IdeaDetailsApi.renameIdea(label: label, ideaId: ideaID.value);
    if (result == true) {
      await Get.find<ProjectsScreenController>().getProjectsAll();
      await getIdeaDetails();
      if (Get.isRegistered<ProjectIdeasGalleryController>() == true) {
        Get.find<ProjectIdeasGalleryController>().getProjectsIdea();
        Get.find<ProjectIdeasGalleryController>().getProjectsArchivedIdea();
        if (groupID.value == "") {
        } else {
          Get.find<ProjectIdeasGalleryController>()
              .selectItemsOfGroup(groupID: groupID.value);
        }
      }
    }
  }

  deleteIdea() async {
    List ideaList = [];
    ideaList.add(ideaID.value);
    var result = await IdeaDetailsApi.deleteGroupIdeasOrIdeas(
        ideaIdList: ideaList, groupIdList: []);
    if (result == true) {
      Get.back();
      Get.find<ProjectIdeasGalleryController>()
          .ungrouped_list
          .removeWhere((element) => element.groupIdOrIdeaId == ideaID.value);
      Get.find<ProjectIdeasGalleryController>()
          .displayGroupItemsList
          .removeWhere((element) => element.ideaId == ideaID.value);
      for (var i = 0;
          i < Get.find<ProjectIdeasGalleryController>().grouped_list.length;
          i++) {
        Get.find<ProjectIdeasGalleryController>()
            .grouped_list[i]
            .groupIdeaImage
            .removeWhere((element) => element.ideaImageId == ideaID.value);
      }
      await Get.find<ProjectsScreenController>().getProjectsAll();
      Get.find<ProjectIdeasGalleryController>().getProjectsIdea();
    } else {}
  }
}
