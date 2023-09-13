import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

List<ImageModel> imageModelFromJson(String str) =>
    List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

String imageModelToJson(List<ImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  ImageModel({
    required this.imagePath,
    this.imageFile,
    required this.isLink,
  });

  String imagePath;
  XFile? imageFile;
  bool isLink;
  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        imagePath: json["imagePath"],
        imageFile: json["imageFile"],
        isLink: json["isLink"],
      );

  Map<String, dynamic> toJson() => {
        "imagePath": imagePath,
        "imageFile": imageFile,
        "isLink": isLink,
      };
}

List<ColorModels> colorModelFromJson(String str) => List<ColorModels>.from(
    json.decode(str).map((x) => ColorModels.fromJson(x)));

String colorModelToJson(List<ColorModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ColorModels {
  ColorModels({
    required this.colorPick,
    required this.colorName,
  });

  Color colorPick;
  String colorName;

  factory ColorModels.fromJson(Map<String, dynamic> json) => ColorModels(
        colorPick: json["colorPick"],
        colorName: json["colorName"],
      );

  Map<String, dynamic> toJson() => {
        "colorPick": colorPick,
        "colorName": colorName,
      };
}

List<ProductCategoryModel> productCategoryFromJson(String str) =>
    List<ProductCategoryModel>.from(
        json.decode(str).map((x) => ColorModels.fromJson(x)));

String productCategoryToJson(List<ColorModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCategoryModel {
  ProductCategoryModel({
    required this.categoryIcon,
    required this.categoryName,
  });

  Widget categoryIcon;
  RxString categoryName;

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(
        categoryIcon: json["categoryIcon"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "colorcategoryIconPick": categoryIcon,
        "categoryName": categoryName,
      };
}
