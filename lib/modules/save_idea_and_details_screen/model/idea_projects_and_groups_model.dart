import 'dart:convert';

import 'package:get/get.dart';

List<ProjectGroupModel> projectGroupModelFromJson(String str) =>
    List<ProjectGroupModel>.from(
        json.decode(str).map((x) => ProjectGroupModel.fromJson(x)));

String projectGroupModelToJson(List<ProjectGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectGroupModel {
  ProjectGroupModel({
    required this.projectId,
    required this.projectName,
    required this.boardList,
    required this.isShown,
  });
  RxBool isShown;
  String projectId;
  String projectName;
  List<BoardList> boardList;

  factory ProjectGroupModel.fromJson(Map<String, dynamic> json) =>
      ProjectGroupModel(
        isShown: false.obs,
        projectId: json["project_id"],
        projectName: json["project_name"],
        boardList: List<BoardList>.from(
            json["board_list"].map((x) => BoardList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "isShown": isShown,
        "project_name": projectName,
        "board_list": List<dynamic>.from(boardList.map((x) => x.toJson())),
      };
}

class BoardList {
  BoardList({
    required this.boardId,
    required this.boardName,
    required this.isSelected,
    required this.dateCreate,
  });

  String boardId;
  String boardName;
  DateTime dateCreate;
  RxBool isSelected;

  factory BoardList.fromJson(Map<String, dynamic> json) => BoardList(
        boardId: json["board_id"],
        boardName: json["board_name"],
        dateCreate: DateTime.parse(json["dateCreate"]),
        isSelected: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "board_id": boardId,
        "dateCreate": dateCreate,
        "board_name": boardName,
        "isSelected": isSelected,
      };
}
