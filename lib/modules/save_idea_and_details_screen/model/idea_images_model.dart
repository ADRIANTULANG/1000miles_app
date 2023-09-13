import 'dart:convert';

import 'package:get/get.dart';

List<IdeaImagesModel> picturesIdeaModelFromJson(String str) =>
    List<IdeaImagesModel>.from(
        json.decode(str).map((x) => IdeaImagesModel.fromJson(x)));

String picturesIdeaModelToJson(List<IdeaImagesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IdeaImagesModel {
  IdeaImagesModel(
      {required this.path,
      required this.isFirst,
      required this.isLast,
      required this.isSelected,
      required this.imageTitle});
  String path;
  String imageTitle;
  bool isFirst;
  bool isLast;
  RxBool isSelected;

  factory IdeaImagesModel.fromJson(Map<String, dynamic> json) =>
      IdeaImagesModel(
        imageTitle: "",
        path: json["path"],
        isLast: json["isLast"],
        isFirst: json["isFirst"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "imageTitle": imageTitle,
        "isLast": isLast,
        "isSelected": isSelected,
        "isFirst": isFirst,
      };
}
