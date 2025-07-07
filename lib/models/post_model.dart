import 'package:assist_web/models/user_model.dart';

class PostModel {
  String postId = "";
  UserModel user = UserModel.empty();
  String text = "";
  String imageUrl = "";
  bool blocked = false;
  bool approved = false;
  List<String> likes = [];
  List<dynamic> reports = [];
  DateTime createdAt = DateTime.now();

  PostModel();
  PostModel.empty();

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json["_id"] ?? "";
    user =
        json["user"] != null
            ? UserModel.fromJson(json["user"])
            : UserModel.empty();
    text = json["text"] ?? "";
    imageUrl = json["imageUrl"] ?? "";
    blocked = json["blocked"] ?? false;
    approved = json["approved"] ?? false;
    likes = List<String>.from(json["likes"] ?? []);
    reports = List<dynamic>.from(json["reports"] ?? []);
    createdAt = DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": postId,
      "user": user.toJson(),
      "text": text,
      "imageUrl": imageUrl,
      "blocked": blocked,
      "approved": approved,
      "likes": likes,
      "reports": reports,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
