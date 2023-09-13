import 'dart:convert';

import 'package:get/get.dart';

List<ProjectAndGroupModel> projectAndGroupModelFromJson(String str) =>
    List<ProjectAndGroupModel>.from(
        json.decode(str).map((x) => ProjectAndGroupModel.fromJson(x)));

String projectAndGroupModelToJson(List<ProjectAndGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectAndGroupModel {
  ProjectAndGroupModel(
      {required this.id,
      required this.name,
      required this.groupLists,
      required this.dateCreated,
      required this.isShown});

  String id;
  String name;
  DateTime dateCreated;
  RxBool isShown;
  List<GroupList> groupLists;

  factory ProjectAndGroupModel.fromJson(Map<String, dynamic> json) =>
      ProjectAndGroupModel(
        id: json["id"],
        name: json["name"],
        dateCreated: DateTime.parse(json["dateCreated"].toString()),
        isShown: false.obs,
        groupLists: List<GroupList>.from(
            json["idea_list"].map((x) => GroupList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dateCreated": dateCreated,
        "isShown": isShown,
        "idea_groups": List<dynamic>.from(groupLists.map((x) => x.toJson())),
      };
}

class GroupList {
  GroupList({
    required this.id,
    required this.name,
    required this.projectId,
    required this.isSelected,
  });

  String id;
  String name;
  String projectId;
  RxBool isSelected;

  factory GroupList.fromJson(Map<String, dynamic> json) => GroupList(
        id: json["id"],
        name: json["name"],
        projectId: json["project_id"],
        isSelected: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isSelected": isSelected,
        "project_id": projectId,
      };
}
