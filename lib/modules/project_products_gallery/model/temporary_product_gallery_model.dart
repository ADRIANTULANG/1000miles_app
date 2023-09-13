import 'dart:convert';

List<TemporaryProductGalleryModel> temporaryProductGalleryModelFromJson(
        String str) =>
    List<TemporaryProductGalleryModel>.from(
        json.decode(str).map((x) => TemporaryProductGalleryModel.fromJson(x)));

String temporaryProductGalleryModelToJson(
        List<TemporaryProductGalleryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TemporaryProductGalleryModel {
  TemporaryProductGalleryModel({
    required this.id,
    required this.createdBy,
    required this.name,
    required this.isGroup,
    required this.products,
    required this.active,
    required this.dateWrite,
    required this.dateCreate,
  });

  int id;
  int createdBy;
  String name;
  bool isGroup;
  List<Product> products;
  bool active;
  DateTime dateWrite;
  DateTime dateCreate;

  factory TemporaryProductGalleryModel.fromJson(Map<String, dynamic> json) =>
      TemporaryProductGalleryModel(
        id: json["id"],
        createdBy: json["created_by"],
        name: json["name"],
        isGroup: json["isGroup"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        active: json["active"],
        dateWrite: DateTime.parse(json["date_write"]),
        dateCreate: DateTime.parse(json["date_create"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "name": name,
        "isGroup": isGroup,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "active": active,
        "date_write": dateWrite.toIso8601String(),
        "date_create": dateCreate.toIso8601String(),
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.dateCreate,
    required this.dateWrite,
    required this.variants,
    required this.file,
  });

  int id;
  String name;
  DateTime dateCreate;
  DateTime dateWrite;
  List<Variant> variants;
  List<FileElement> file;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
        variants: List<Variant>.from(
            json["variants"].map((x) => Variant.fromJson(x))),
        file: List<FileElement>.from(
            json["file"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_create": dateCreate.toIso8601String(),
        "date_write": dateWrite.toIso8601String(),
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "file": List<dynamic>.from(file.map((x) => x.toJson())),
      };
}

class FileElement {
  FileElement({
    required this.file,
    required this.main,
  });

  String file;
  bool main;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        file: json["file"],
        main: json["main"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "main": main,
      };
}

class Variant {
  Variant({
    required this.id,
  });

  int id;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
