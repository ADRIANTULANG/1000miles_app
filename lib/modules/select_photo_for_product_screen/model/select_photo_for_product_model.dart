import 'dart:convert';

import 'package:get/get.dart';

List<PicturesProductModel> picturesModelFromJson(String str) =>
    List<PicturesProductModel>.from(
        json.decode(str).map((x) => PicturesProductModel.fromJson(x)));

String picturesModelToJson(List<PicturesProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PicturesProductModel {
  PicturesProductModel({
    required this.path,
    required this.isFirst,
    required this.isLast,
    required this.isSelected,
  });
  String path;
  bool isFirst;
  bool isLast;
  RxBool isSelected;

  factory PicturesProductModel.fromJson(Map<String, dynamic> json) =>
      PicturesProductModel(
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
