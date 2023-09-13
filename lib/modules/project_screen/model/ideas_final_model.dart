import 'dart:convert';

List<TopWidgetModel> topWidgetModelFromJson(String str) =>
    List<TopWidgetModel>.from(
        json.decode(str).map((x) => TopWidgetModel.fromJson(x)));

String topWidgetModelToJson(List<TopWidgetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopWidgetModel {
  TopWidgetModel({
    required this.projectId,
    required this.projectname,
    required this.projectDateCreated,
    required this.ideas,
  });

  String projectId;
  String projectname;
  DateTime projectDateCreated;
  List<Idea> ideas;

  factory TopWidgetModel.fromJson(Map<String, dynamic> json) => TopWidgetModel(
        projectId: json["project_id"],
        projectname: json["projectname"],
        projectDateCreated:
            DateTime.parse(json["project_date_created"].toString()),
        ideas: List<Idea>.from(json["ideas"].map((x) => Idea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "projectname": projectname,
        "project_date_created": projectDateCreated,
        "ideas": List<dynamic>.from(ideas.map((x) => x.toJson())),
      };
}

class Idea {
  Idea({
    required this.groupNameOrIdeaName,
    required this.groupIdOrIdeaId,
    required this.ideaImageIfUngroup,
    required this.ideaListImagesIfGroup,
    required this.dateCreated,
    required this.isGroup,
  });

  String groupNameOrIdeaName;
  String groupIdOrIdeaId;
  String ideaImageIfUngroup;
  bool isGroup;
  DateTime dateCreated;
  List<IdeaListImagesIfGroup> ideaListImagesIfGroup;

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
        groupNameOrIdeaName: json["group_name_or_idea_name"],
        groupIdOrIdeaId: json["group_id_or_idea_id"],
        isGroup: json["isGroup"],
        ideaImageIfUngroup: json["idea_image_if_ungroup"],
        dateCreated: DateTime.parse(json["dateCreated"].toString()),
        ideaListImagesIfGroup: List<IdeaListImagesIfGroup>.from(
            json["idea_list_images_if_group"]
                .map((x) => IdeaListImagesIfGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dateCreated": dateCreated,
        "group_name_or_idea_name": groupNameOrIdeaName,
        "group_id_or_idea_id": groupIdOrIdeaId,
        "isGroup": isGroup,
        "idea_image_if_ungroup": ideaImageIfUngroup,
        "idea_list_images_if_group":
            List<dynamic>.from(ideaListImagesIfGroup.map((x) => x.toJson())),
      };
}

class IdeaListImagesIfGroup {
  IdeaListImagesIfGroup({
    required this.ideaName,
    required this.ideaId,
    required this.ideaImage,
    required this.dateCreated,
  });

  String ideaName;
  String ideaId;
  String ideaImage;
  DateTime dateCreated;

  factory IdeaListImagesIfGroup.fromJson(Map<String, dynamic> json) =>
      IdeaListImagesIfGroup(
        ideaName: json["idea_name"],
        ideaImage: json["idea_image"],
        ideaId: json["idea_id"],
        dateCreated: DateTime.parse(json["date_created"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "idea_name": ideaName,
        "idea_image": ideaImage,
        "idea_id": ideaId,
        "date_created": dateCreated,
      };
}
