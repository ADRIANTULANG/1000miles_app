import 'dart:convert';

import 'package:get/get.dart';

List<MyIdeaSingleModel> myIdeaSingleModelFromJson(String str) =>
    List<MyIdeaSingleModel>.from(
        json.decode(str).map((x) => MyIdeaSingleModel.fromJson(x)));

String myIdeaSingleModelToJson(List<MyIdeaSingleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyIdeaSingleModel {
  MyIdeaSingleModel({
    required this.ideaId,
    required this.ideaName,
    required this.ideaFilename,
    required this.isSelected,
    required this.createdAt,
  });

  String ideaId;
  String ideaName;
  String ideaFilename;
  RxBool isSelected;
  DateTime createdAt;

  factory MyIdeaSingleModel.fromJson(Map<String, dynamic> json) =>
      MyIdeaSingleModel(
        ideaId: json["idea_id"],
        ideaName: json["idea_name"],
        ideaFilename: json["idea_filename"],
        isSelected: false.obs,
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "idea_id": ideaId,
        "idea_name": ideaName,
        "idea_filename": ideaFilename,
        "isSelected": isSelected,
        "created_at": createdAt.toIso8601String(),
      };
}
