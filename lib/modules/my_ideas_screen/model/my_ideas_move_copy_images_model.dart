import 'dart:convert';

List<ImagesModel> imageModelFromJson(String str) => List<ImagesModel>.from(
    json.decode(str).map((x) => ImagesModel.fromJson(x)));

String imageModelToJson(List<ImagesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImagesModel {
  ImagesModel({
    required this.ideaId,
    required this.ideaFileImage,
  });

  String ideaId;
  String ideaFileImage;

  factory ImagesModel.fromJson(Map<String, dynamic> json) => ImagesModel(
        ideaId: json["idea_id"],
        ideaFileImage: json["idea_fileImage"],
      );

  Map<String, dynamic> toJson() => {
        "idea_id": ideaId,
        "idea_fileImage": ideaFileImage,
      };
}
