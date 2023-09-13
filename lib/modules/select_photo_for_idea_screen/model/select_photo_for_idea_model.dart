import 'dart:convert';

import 'package:get/get.dart';

List<PicturesIdeaModel> picturesIdeaModelFromJson(String str) =>
    List<PicturesIdeaModel>.from(
        json.decode(str).map((x) => PicturesIdeaModel.fromJson(x)));

String picturesIdeaModelToJson(List<PicturesIdeaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PicturesIdeaModel {
  PicturesIdeaModel({
    required this.path,
    required this.isFirst,
    required this.isLast,
    required this.isSelected,
  });
  String path;
  bool isFirst;
  bool isLast;
  RxBool isSelected;

  factory PicturesIdeaModel.fromJson(Map<String, dynamic> json) =>
      PicturesIdeaModel(
        path: json["path"],
        isLast: json["isLast"],
        isFirst: json["isFirst"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "isLast": isLast,
        "isSelected": isSelected,
        "isFirst": isFirst,
      };
}
