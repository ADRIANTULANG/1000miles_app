import 'dart:convert';

List<MyIdeasModel> myIdeasModelFromJson(String str) => List<MyIdeasModel>.from(
    json.decode(str).map((x) => MyIdeasModel.fromJson(x)));

String myIdeasModelToJson(List<MyIdeasModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyIdeasModel {
  MyIdeasModel({
    required this.idea,
    required this.myIdeaBoardsList,
  });

  String idea;
  List<MyIdeaBoardsList> myIdeaBoardsList;

  factory MyIdeasModel.fromJson(Map<String, dynamic> json) => MyIdeasModel(
        idea: json["idea"],
        myIdeaBoardsList: List<MyIdeaBoardsList>.from(
            json["my_idea_boards_list"]
                .map((x) => MyIdeaBoardsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idea": idea,
        "my_idea_boards_list":
            List<dynamic>.from(myIdeaBoardsList.map((x) => x.toJson())),
      };
}

class MyIdeaBoardsList {
  MyIdeaBoardsList({
    required this.boardId,
    required this.boardName,
  });

  String boardId;
  String boardName;

  factory MyIdeaBoardsList.fromJson(Map<String, dynamic> json) =>
      MyIdeaBoardsList(
        boardId: json["board_id"],
        boardName: json["board_name"],
      );

  Map<String, dynamic> toJson() => {
        "board_id": boardId,
        "board_name": boardName,
      };
}
