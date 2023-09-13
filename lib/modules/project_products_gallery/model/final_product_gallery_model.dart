import 'dart:convert';

List<FinalProductGalleryModel> finalProductGalleryModelFromJson(String str) =>
    List<FinalProductGalleryModel>.from(
        json.decode(str).map((x) => FinalProductGalleryModel.fromJson(x)));

String finalProductGalleryModelToJson(List<FinalProductGalleryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FinalProductGalleryModel {
  FinalProductGalleryModel({
    required this.productIDorGroupedID,
    required this.productOrGroupName,
    required this.isGroup,
    required this.productImage,
    required this.noOfVariantsOrProducts,
    required this.dateCreate,
  });

  String productOrGroupName;
  bool isGroup;
  String productImage;
  int productIDorGroupedID;
  int noOfVariantsOrProducts;
  DateTime dateCreate;

  factory FinalProductGalleryModel.fromJson(Map<String, dynamic> json) =>
      FinalProductGalleryModel(
        productIDorGroupedID: json["productIDorGroupedID"],
        productOrGroupName: json["product_or_group_name"],
        isGroup: json["isGroup"],
        productImage: json["product_image"],
        noOfVariantsOrProducts: json["no_of_variants_or_products"],
        dateCreate: json["dateCreate"],
      );

  Map<String, dynamic> toJson() => {
        "productIDorGroupedID": productIDorGroupedID,
        "product_or_group_name": productOrGroupName,
        "isGroup": isGroup,
        "product_image": productImage,
        "no_of_variants_or_products": noOfVariantsOrProducts,
        "dateCreate": dateCreate,
      };
}
