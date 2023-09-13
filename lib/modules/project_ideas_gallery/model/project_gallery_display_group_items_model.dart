import 'dart:convert';

import 'package:get/get.dart';

List<ProjectDisplayGroupItemsModel> projectDisplayGroupItemsModelFromJson(
        String str) =>
    List<ProjectDisplayGroupItemsModel>.from(
        json.decode(str).map((x) => ProjectDisplayGroupItemsModel.fromJson(x)));

String projectDisplayGroupItemsModelToJson(
        List<ProjectDisplayGroupItemsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectDisplayGroupItemsModel {
  ProjectDisplayGroupItemsModel({
    required this.ideaId,
    required this.label,
    required this.file,
    required this.dateCreated,
    required this.isSelected,
  });
  RxBool isSelected;
  String ideaId;
  String label;
  String file;
  DateTime dateCreated;

  factory ProjectDisplayGroupItemsModel.fromJson(Map<String, dynamic> json) =>
      ProjectDisplayGroupItemsModel(
        isSelected: json["isSelected"],
        ideaId: json["idea_id"],
        label: json["label"],
        file: json["file"],
        dateCreated: DateTime.parse(json["date_created"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "isSelected": isSelected,
        "idea_id": ideaId,
        "label": label,
        "file": file,
        "date_created": dateCreated,
      };
}
