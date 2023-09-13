import 'dart:convert';

import 'package:get/get.dart';

List<ProjectCreateGroupModel> projectCreateGroupModelFromJson(String str) =>
    List<ProjectCreateGroupModel>.from(
        json.decode(str).map((x) => ProjectCreateGroupModel.fromJson(x)));

String projectCreateGroupModelToJson(List<ProjectCreateGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectCreateGroupModel {
  ProjectCreateGroupModel({
    required this.ideaId,
    required this.label,
    required this.file,
    required this.isSelected,
  });
  RxBool isSelected;
  String ideaId;
  String label;
  String file;

  factory ProjectCreateGroupModel.fromJson(Map<String, dynamic> json) =>
      ProjectCreateGroupModel(
        isSelected: json["isSelected"],
        ideaId: json["idea_id"],
        label: json["label"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "isSelected": isSelected,
        "idea_id": ideaId,
        "label": label,
        "file": file,
      };
}
