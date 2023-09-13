import 'dart:convert';

import 'package:get/get.dart';

List<GroupedProductsModel> groupedProductsModelFromJson(String str) =>
    List<GroupedProductsModel>.from(
        json.decode(str).map((x) => GroupedProductsModel.fromJson(x)));

String groupedProductsModelToJson(List<GroupedProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupedProductsModel {
  GroupedProductsModel({
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
  RxBool isSelected;
  String productImage;
  int noOfVariantsOrProducts;
  int productIDorGroupedID;
  DateTime dateCreate;

  factory GroupedProductsModel.fromJson(Map<String, dynamic> json) =>
      GroupedProductsModel(
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
