import 'dart:convert';

List<RecentlyViewedModel> recentlyViewedModelFromJson(String str) =>
    List<RecentlyViewedModel>.from(
        json.decode(str).map((x) => RecentlyViewedModel.fromJson(x)));

String recentlyViewedModelToJson(List<RecentlyViewedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentlyViewedModel {
  RecentlyViewedModel({
    this.id,
    this.name,
    this.dateWrite,
    this.file,
  });

  String? id;
  String? name;
  DateTime? dateWrite;
  FileClass? file;

  factory RecentlyViewedModel.fromJson(Map<String, dynamic> json) =>
      RecentlyViewedModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        dateWrite: json["date_write"] == null
            ? DateTime.now()
            : DateTime.parse(json["date_write"]),
        file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "date_write": dateWrite == null ? null : dateWrite!.toIso8601String(),
        "file": file == null ? null : file!.toJson(),
      };
}

class FileClass {
  FileClass({
    this.file,
    this.name,
    this.fileType,
  });

  String? file;
  String? name;
  String? fileType;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        file: json["file"] == null ? "" : json["file"],
        name: json["name"] == null ? "" : json["name"],
        fileType: json["file_type"] == "" ? null : json["file_type"],
      );

  Map<String, dynamic> toJson() => {
        "file": file == null ? null : file,
        "name": name == null ? null : name,
        "file_type": fileType == null ? null : fileType,
      };
}
