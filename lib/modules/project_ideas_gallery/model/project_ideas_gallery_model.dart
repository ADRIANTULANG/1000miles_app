import 'dart:convert';

List<ProjectGalleryModel> projectGalleryModelFromJson(String str) =>
    List<ProjectGalleryModel>.from(
        json.decode(str).map((x) => ProjectGalleryModel.fromJson(x)));

String projectGalleryModelToJson(List<ProjectGalleryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectGalleryModel {
  ProjectGalleryModel({
    required this.id,
    required this.name,
    required this.projectId,
    required this.ideas,
    required this.isGroup,
    required this.createdBy,
    required this.dateCreate,
    required this.dateWrite,
  });

  int id;
  String name;
  int projectId;
  List<Idea> ideas;
  bool isGroup;
  int createdBy;
  DateTime dateCreate;
  DateTime dateWrite;

  factory ProjectGalleryModel.fromJson(Map<String, dynamic> json) =>
      ProjectGalleryModel(
        id: json["id"],
        name: json["name"],
        projectId: json["project_id"],
        ideas: List<Idea>.from(json["ideas"].map((x) => Idea.fromJson(x))),
        isGroup: json["is_group"],
        createdBy: json["created_by"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "project_id": projectId,
        "ideas": List<dynamic>.from(ideas.map((x) => x.toJson())),
        "is_group": isGroup,
        "created_by": createdBy,
        "date_create": dateCreate.toIso8601String(),
        "date_write": dateWrite.toIso8601String(),
      };
}

class Idea {
  Idea({
    required this.id,
    required this.label,
    required this.file,
  });

  int id;
  String label;
  FileClass file;

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
        label: json["label"],
        id: json["id"],
        file: FileClass.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "file": file.toJson(),
      };
}

class FileClass {
  FileClass({
    required this.id,
    required this.objectId,
    required this.source,
    required this.file,
  });

  int id;
  int objectId;
  String source;
  String file;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        id: json["id"],
        objectId: json["object_id"],
        source: json["source"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object_id": objectId,
        "source": source,
        "file": file,
      };
}
