import 'dart:convert';

import 'package:get/get.dart';

List<ProjectGroupAndProducts> projectGroupAndProductsFromJson(String str) =>
    List<ProjectGroupAndProducts>.from(
        json.decode(str).map((x) => ProjectGroupAndProducts.fromJson(x)));

String projectGroupAndProductsToJson(List<ProjectGroupAndProducts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectGroupAndProducts {
  ProjectGroupAndProducts(
      {required this.id,
      required this.name,
      required this.dateCreate,
      required this.isSelected,
      required this.groups,
      required this.showGroup});

  int id;
  String name;
  DateTime dateCreate;
  List<Group> groups;
  RxBool showGroup;
  RxBool isSelected;

  factory ProjectGroupAndProducts.fromJson(Map<String, dynamic> json) =>
      ProjectGroupAndProducts(
        id: json["id"],
        name: json["name"],
        showGroup: false.obs,
        isSelected: false.obs,
        dateCreate: DateTime.parse(json["date_create"]),
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "showGroup": showGroup,
        "isSelected": isSelected,
        "date_create": dateCreate.toIso8601String(),
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
      };
}

class Group {
  Group({
    required this.id,
    required this.createdBy,
    required this.name,
    required this.isGroup,
    required this.isSelected,
  });

  int id;
  int createdBy;
  String name;
  bool isGroup;
  RxBool isSelected;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        createdBy: json["created_by"],
        name: json["name"],
        isSelected: false.obs,
        isGroup: json["isGroup"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "name": name,
        "isSelected": isSelected,
        "isGroup": isGroup,
      };
}
