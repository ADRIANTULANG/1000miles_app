import 'dart:convert';

import 'package:get/get.dart';

List<FinalProjectGalleryModel> finalProjectGalleryModelFromJson(String str) =>
    List<FinalProjectGalleryModel>.from(
        json.decode(str).map((x) => FinalProjectGalleryModel.fromJson(x)));

String finalProjectGalleryModelToJson(List<FinalProjectGalleryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FinalProjectGalleryModel {
  FinalProjectGalleryModel({
    required this.ideaNameOrIdeaGroupname,
    required this.isGroup,
    required this.groupIdOrIdeaId,
    required this.ideaFileImage,
    required this.groupIdeaImage,
    required this.numberorideas,
    required this.dateCreated,
    required this.isSelected,
  });

  String ideaNameOrIdeaGroupname;
  bool isGroup;
  String groupIdOrIdeaId;
  String numberorideas;
  String ideaFileImage;
  List<GroupIdeaImage> groupIdeaImage;
  DateTime dateCreated;
  RxBool isSelected;

  factory FinalProjectGalleryModel.fromJson(Map<String, dynamic> json) =>
      FinalProjectGalleryModel(
        ideaNameOrIdeaGroupname: json["idea_name_or_idea_groupname"],
        isGroup: json["is_group"],
        isSelected: false.obs,
        dateCreated: DateTime.parse(json["numberorideas"].toString()),
        numberorideas: json["numberorideas"],
        groupIdOrIdeaId: json["group_id_or_idea_id"],
        ideaFileImage: json["idea_file_image"],
        groupIdeaImage: List<GroupIdeaImage>.from(
            json["group_idea_image"].map((x) => GroupIdeaImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idea_name_or_idea_groupname": ideaNameOrIdeaGroupname,
        "is_group": isGroup,
        "isSelected": isSelected,
        "dateCreated": dateCreated,
        "group_id_or_idea_id": groupIdOrIdeaId,
        "numberorideas": numberorideas,
        "idea_file_image": ideaFileImage,
        "group_idea_image":
            List<dynamic>.from(groupIdeaImage.map((x) => x.toJson())),
      };
}

class GroupIdeaImage {
  GroupIdeaImage({
    required this.fileImage,
    required this.ideaImageId,
  });

  String fileImage;
  String ideaImageId;

  factory GroupIdeaImage.fromJson(Map<String, dynamic> json) => GroupIdeaImage(
        fileImage: json["file_image"],
        ideaImageId: json["idea_image_id"],
      );

  Map<String, dynamic> toJson() => {
        "file_image": fileImage,
        "idea_image_id": ideaImageId,
      };
}
