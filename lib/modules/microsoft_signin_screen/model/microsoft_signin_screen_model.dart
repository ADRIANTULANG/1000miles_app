import 'dart:convert';

List<MicroSoftUsers> microSoftUsersFromJson(String str) =>
    List<MicroSoftUsers>.from(
        json.decode(str).map((x) => MicroSoftUsers.fromJson(x)));

String microSoftUsersToJson(List<MicroSoftUsers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MicroSoftUsers {
  MicroSoftUsers({
    required this.name,
    required this.webUrl,
  });

  String name;
  String webUrl;

  factory MicroSoftUsers.fromJson(Map<String, dynamic> json) => MicroSoftUsers(
        name: json["name"],
        webUrl: json["webUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "webUrl": webUrl,
      };
}
