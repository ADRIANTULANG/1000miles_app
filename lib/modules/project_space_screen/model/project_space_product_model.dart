import 'dart:convert';

List<PorjectSpaceProductModel> porjectSpaceProductModelFromJson(String str) =>
    List<PorjectSpaceProductModel>.from(
        json.decode(str).map((x) => PorjectSpaceProductModel.fromJson(x)));

String porjectSpaceProductModelToJson(List<PorjectSpaceProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PorjectSpaceProductModel {
  PorjectSpaceProductModel({
    required this.id,
    required this.createdBy,
    required this.name,
    required this.isGroup,
    required this.products,
  });

  int id;
  int createdBy;
  String name;
  bool isGroup;
  List<Product> products;

  factory PorjectSpaceProductModel.fromJson(Map<String, dynamic> json) =>
      PorjectSpaceProductModel(
        id: json["id"],
        createdBy: json["created_by"],
        name: json["name"],
        isGroup: json["isGroup"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "name": name,
        "isGroup": isGroup,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
