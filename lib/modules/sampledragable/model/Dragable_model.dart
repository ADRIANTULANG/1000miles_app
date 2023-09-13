import 'dart:convert';

List<DragableModel> dragableModelFromJson(String str) =>
    List<DragableModel>.from(
        json.decode(str).map((x) => DragableModel.fromJson(x)));

String dragableModelToJson(List<DragableModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DragableModel {
  DragableModel({
    required this.groupProductName,
    required this.groupProductImage,
  });

  String groupProductName;
  String groupProductImage;

  factory DragableModel.fromJson(Map<String, dynamic> json) => DragableModel(
        groupProductName: json["group_product_name"],
        groupProductImage: json["group_product_image"],
      );

  Map<String, dynamic> toJson() => {
        "group_product_name": groupProductName,
        "group_product_image": groupProductImage,
      };
}
