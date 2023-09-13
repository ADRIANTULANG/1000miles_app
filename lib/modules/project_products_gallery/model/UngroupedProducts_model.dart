import 'dart:convert';

import 'package:get/get.dart';

List<UngroupedProductsModel> ungroupedProductsModelFromJson(String str) =>
    List<UngroupedProductsModel>.from(
        json.decode(str).map((x) => UngroupedProductsModel.fromJson(x)));

String ungroupedProductsModelToJson(List<UngroupedProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UngroupedProductsModel {
  UngroupedProductsModel({
    required this.productIDorGroupedID,
    required this.productOrGroupName,
    required this.isGroup,
    required this.productImage,
    required this.noOfVariantsOrProducts,
    required this.dateCreate,
    required this.isSelected,
  });

  String productOrGroupName;
  bool isGroup;
  int productIDorGroupedID;
  RxBool isSelected;
  String productImage;
  int noOfVariantsOrProducts;
  DateTime dateCreate;

  factory UngroupedProductsModel.fromJson(Map<String, dynamic> json) =>
      UngroupedProductsModel(
        productIDorGroupedID: json["productIDorGroupedID"],
        productOrGroupName: json["product_or_group_name"],
        isGroup: json["isGroup"],
        isSelected: false.obs,
        productImage: json["product_image"],
        noOfVariantsOrProducts: json["no_of_variants_or_products"],
        dateCreate: json["dateCreate"],
      );

  Map<String, dynamic> toJson() => {
        "productIDorGroupedID": productIDorGroupedID,
        "product_or_group_name": productOrGroupName,
        "isGroup": isGroup,
        "isSelected": isSelected,
        "product_image": productImage,
        "no_of_variants_or_products": noOfVariantsOrProducts,
        "dateCreate": dateCreate,
      };
}
