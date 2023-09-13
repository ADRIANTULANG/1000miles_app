import 'dart:convert';

import 'package:get/get.dart';

List<ProjectSpace> ProjectSpaceFromJson(String str) => List<ProjectSpace>.from(
    json.decode(str).map((x) => ProjectSpace.fromJson(x)));

String ProjectSpaceToJson(List<ProjectSpace> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectSpace {
  ProjectSpace(
      {required this.optionName,
      required this.assetCount,
      required this.icon,
      required this.isPress,
      required this.paddingValue});

  String optionName;
  RxInt assetCount;
  String icon;
  RxBool isPress;
  RxInt paddingValue;
  factory ProjectSpace.fromJson(Map<String, dynamic> json) => ProjectSpace(
        optionName: json["option_name"],
        isPress: false.obs,
        assetCount: int.parse(json["asset_count"].toString()).obs,
        icon: json["icon"],
        paddingValue: 1.obs,
      );

  Map<String, dynamic> toJson() => {
        "option_name": optionName,
        "asset_count": assetCount,
        "icon": icon,
        "isPress": isPress,
        "paddingValue": paddingValue,
      };
}
