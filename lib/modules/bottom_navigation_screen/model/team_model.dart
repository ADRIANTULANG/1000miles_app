import 'dart:convert';

import 'package:get/get.dart';

List<TeamModel> teamModelFromJson(String str) =>
    List<TeamModel>.from(json.decode(str).map((x) => TeamModel.fromJson(x)));

String teamModelToJson(List<TeamModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamModel {
  TeamModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.active,
    required this.dateCreate,
    required this.dateWrite,
    required this.members,
    required this.isSelected,
  });

  String id;
  String name;
  String createdBy;
  bool active;
  DateTime dateCreate;
  DateTime dateWrite;
  List<Member> members;
  RxBool isSelected;

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        id: json["id"],
        name: json["name"],
        createdBy: json["created_by"],
        isSelected: false.obs,
        active: json["active"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_by": createdBy,
        "isSelected": isSelected,
        "active": active,
        "date_create": dateCreate.toIso8601String(),
        "date_write": dateWrite.toIso8601String(),
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class Member {
  Member({
    required this.id,
    required this.name,
    required this.email,
  });

  String id;
  String name;
  String email;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
