import 'dart:convert';

import 'package:get/get.dart';

ProductDetailsModel productDetailsModelFromJson(String str) =>
    ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) =>
    json.encode(data.toJson());

class ProductDetailsModel {
  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.tags,
    required this.description,
    required this.dateCreate,
    required this.dateWrite,
    required this.variants,
    required this.file,
    required this.place,
    required this.length,
    required this.width,
    required this.height,
    required this.quantity,
    required this.incoterms,
    required this.metric,
  });

  int id;
  String? name;
  List<Tags> tags;
  String description;
  DateTime dateCreate;
  DateTime dateWrite;
  List<Variant> variants;
  List<FileElement> file;
  String place;
  String length;
  String width;
  String height;
  String quantity;
  Incoterms? incoterms;
  Metrics? metric;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        id: json["id"],
        name: json["name"],
        tags: List<Tags>.from(json["tags"].map((x) => Tags.fromJson(x))),
        description: json["description"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
        variants: List<Variant>.from(
            json["variants"].map((x) => Variant.fromJson(x))),
        file: List<FileElement>.from(
            json["file"].map((x) => FileElement.fromJson(x))),
        place: json["place"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        quantity: json["quantity"],
        incoterms: json["incoterms"] == null
            ? null
            : Incoterms.fromJson(json["incoterms"]),
        metric:
            json["metric"] == null ? null : Metrics.fromJson(json["metric"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "description": description,
        "date_create": dateCreate.toIso8601String(),
        "date_write": dateWrite.toIso8601String(),
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "file": List<dynamic>.from(file.map((x) => x.toJson())),
        "place": place,
        "length": length,
        "width": width,
        "height": height,
        "quantity": quantity,
        "incoterms": incoterms?.toJson(),
        "metric": metric?.toJson(),
      };
}

class FileElement {
  FileElement({
    required this.file,
    required this.name,
    required this.fileType,
    required this.fileExt,
    required this.createdBy,
    required this.source,
    required this.main,
    required this.link,
    required this.getFrom,
    required this.dateWrite,
    required this.dateCreate,
  });

  String file;
  String name;
  String fileType;
  String fileExt;
  int createdBy;
  String source;
  bool main;
  String link;
  String getFrom;
  DateTime dateWrite;
  DateTime dateCreate;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        file: json["file"],
        name: json["name"],
        fileType: json["file_type"],
        fileExt: json["file_ext"],
        createdBy: json["created_by"],
        source: json["source"],
        main: json["main"],
        link: json["link"],
        getFrom: json["get_from"],
        dateWrite: DateTime.parse(json["date_write"]),
        dateCreate: DateTime.parse(json["date_create"]),
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "name": name,
        "file_type": fileType,
        "file_ext": fileExt,
        "created_by": createdBy,
        "source": source,
        "main": main,
        "link": link,
        "get_from": getFrom,
        "date_write": dateWrite.toIso8601String(),
        "date_create": dateCreate.toIso8601String(),
      };
}

class Incoterms {
  Incoterms({
    this.id,
    this.name,
    this.dateCreate,
    this.dateWrite,
    this.abbreviation,
    this.active,
  });

  int? id;
  String? name;
  DateTime? dateCreate;
  DateTime? dateWrite;
  String? abbreviation;
  bool? active;

  factory Incoterms.fromJson(Map<String, dynamic> json) => Incoterms(
        id: json["id"],
        name: json["name"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
        abbreviation: json["abbreviation"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_create":
            dateCreate == null ? null : dateCreate!.toIso8601String(),
        "date_write": dateWrite == null ? null : dateWrite!.toIso8601String(),
        "abbreviation": abbreviation,
        "active": active,
      };
}

class Metrics {
  Metrics({
    this.id,
    this.name,
    this.dateCreate,
    this.dateWrite,
    this.abbreviation,
    this.active,
  });

  int? id;
  String? name;
  DateTime? dateCreate;
  DateTime? dateWrite;
  String? abbreviation;
  bool? active;

  factory Metrics.fromJson(Map<String, dynamic> json) => Metrics(
        id: json["id"],
        name: json["name"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
        abbreviation: json["abbreviation"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date_create":
            dateCreate == null ? null : dateCreate!.toIso8601String(),
        "date_write": dateWrite == null ? null : dateWrite!.toIso8601String(),
        "abbreviation": abbreviation,
        "active": active,
      };
}

class Tags {
  Tags({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Variant {
  Variant({
    required this.id,
    required this.name,
    required this.cellValues,
    required this.active,
    required this.dateCreate,
    required this.dateWrite,
    required this.file,
    required this.isSelected,
    required this.isAddNew,
  });

  int id;
  dynamic name;
  List<dynamic> cellValues;
  bool active;
  DateTime dateCreate;
  DateTime dateWrite;
  List<FileElement> file;
  RxBool isSelected;
  RxBool isAddNew;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        name: json["name"],
        isSelected: false.obs,
        isAddNew: false.obs,
        cellValues: List<dynamic>.from(json["cell_values"].map((x) => x)),
        active: json["active"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
        file: List<FileElement>.from(
            json["file"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cell_values": List<dynamic>.from(cellValues.map((x) => x)),
        "active": active,
        "isSelected": isSelected,
        "isAddNew": isAddNew,
        "date_create": dateCreate.toIso8601String(),
        "date_write": dateWrite.toIso8601String(),
        "file": List<dynamic>.from(file.map((x) => x.toJson())),
      };
}
