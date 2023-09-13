import 'dart:convert';

List<ProductsTabModel> productsTabModelFromJson(String str) =>
    List<ProductsTabModel>.from(
        json.decode(str).map((x) => ProductsTabModel.fromJson(x)));

String productsTabModelToJson(List<ProductsTabModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsTabModel {
  ProductsTabModel({
    required this.id,
    required this.name,
    required this.groups,
  });

  int id;
  String name;
  List<Group> groups;

  factory ProductsTabModel.fromJson(Map<String, dynamic> json) =>
      ProductsTabModel(
        id: json["id"],
        name: json["name"],
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
      };
}

class Group {
  Group({
    required this.id,
    required this.name,
    required this.isGroup,
    required this.products,
  });

  int id;
  String name;
  bool isGroup;
  List<Product> products;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        isGroup: json["isGroup"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isGroup": isGroup,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.variants,
    required this.file,
  });

  int id;
  String name;
  List<int> variants;
  List<FileElement> file;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        variants: List<int>.from(json["variants"].map((x) => x)),
        file: List<FileElement>.from(
            json["file"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "variants": List<dynamic>.from(variants.map((x) => x)),
        "file": List<dynamic>.from(file.map((x) => x.toJson())),
      };
}

class FileElement {
  FileElement({
    required this.file,
    required this.name,
    required this.createdBy,
    required this.source,
    required this.dateWrite,
    required this.main,
  });

  String file;
  String name;
  int createdBy;
  String source;
  DateTime dateWrite;
  bool main;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        file: json["file"],
        name: json["name"],
        createdBy: json["created_by"],
        source: json["source"],
        dateWrite: DateTime.parse(json["date_write"]),
        main: json["main"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "name": name,
        "created_by": createdBy,
        "source": source,
        "date_write": dateWrite.toIso8601String(),
        "main": main,
      };
}
