import 'dart:convert';

IdeaDetails ideaDetailsFromJson(String str) =>
    IdeaDetails.fromJson(json.decode(str));

String ideaDetailsToJson(IdeaDetails data) => json.encode(data.toJson());

class IdeaDetails {
  IdeaDetails({
    required this.file,
    required this.id,
    required this.label,
    required this.isActive,
    required this.isArchived,
    required this.votes,
    required this.comments,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.ideaDetailsId,
  });

  FileClass file;
  String id;
  String label;
  bool isActive;
  bool isArchived;
  List<Votes> votes;
  List<Comment> comments;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  String ideaDetailsId;

  factory IdeaDetails.fromJson(Map<String, dynamic> json) => IdeaDetails(
        file: FileClass.fromJson(json["file"]),
        id: json["_id"],
        label: json["label"] ?? "",
        isActive: json["isActive"],
        isArchived: json["isArchived"],
        votes: List<Votes>.from(json["votes"].map((x) => Votes.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        ideaDetailsId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "file": file.toJson(),
        "_id": id,
        "label": label,
        "isActive": isActive,
        "isArchived": isArchived,
        "votes": List<dynamic>.from(votes.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": ideaDetailsId,
      };
}

class Comment {
  Comment({
    required this.id,
    required this.comment,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.commentId,
  });

  String id;
  String comment;
  bool isActive;
  CreatedBy createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  String commentId;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        comment: json["comment"],
        isActive: json["isActive"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        commentId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment,
        "isActive": isActive,
        "createdBy": createdBy.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": commentId,
      };
}

class Votes {
  Votes({
    required this.id,
    required this.isActive,
    required this.isVote,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  bool isActive;
  bool isVote;
  CreatedBy createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Votes.fromJson(Map<String, dynamic> json) => Votes(
        id: json["_id"],
        isActive: json["isActive"],
        isVote: json["isVote"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isActive": isActive,
        "isVote": isVote,
        "createdBy": createdBy.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.createdById,
  });

  String id;
  String name;
  String email;
  DateTime createdAt;
  String createdById;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdById: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "id": createdById,
      };
}

class FileClass {
  FileClass({
    required this.originalname,
    required this.mimetype,
    required this.filename,
    required this.size,
  });

  String originalname;
  String mimetype;
  String filename;
  int size;

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        originalname: json["originalname"],
        mimetype: json["mimetype"],
        filename: json["filename"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "originalname": originalname,
        "mimetype": mimetype,
        "filename": filename,
        "size": size,
      };
}
