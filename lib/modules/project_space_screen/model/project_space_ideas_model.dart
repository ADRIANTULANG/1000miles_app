import 'dart:convert';

List<ProjectSpaceIdeasModel> projectSpaceIdeasModelFromJson(String str) =>
    List<ProjectSpaceIdeasModel>.from(
        json.decode(str).map((x) => ProjectSpaceIdeasModel.fromJson(x)));

String projectSpaceIdeasModelToJson(List<ProjectSpaceIdeasModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectSpaceIdeasModel {
  ProjectSpaceIdeasModel({
    required this.id,
    required this.name,
    required this.projectId,
    required this.ideas,
  });

  String id;
  String name;
  int projectId;
  List<Idea> ideas;

  factory ProjectSpaceIdeasModel.fromJson(Map<String, dynamic> json) =>
      ProjectSpaceIdeasModel(
        id: json["id"],
        name: json["name"],
        projectId: json["project_id"],
        ideas: List<Idea>.from(json["ideas"].map((x) => Idea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "project_id": projectId,
        "ideas": List<dynamic>.from(ideas.map((x) => x.toJson())),
      };
}

class Idea {
  Idea({
    required this.id,
  });

  int id;

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
