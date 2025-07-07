import 'package:assist_web/models/user_model.dart';

class ApplicationModel {
  String applicationId = "";
  UserModel user = UserModel.empty();
  String billCategory = "";
  String reason = "";
  String billFile = "";
  bool randomlySelected = false;
  String status = "";

  ApplicationModel();

  ApplicationModel.fromJson(Map<String, dynamic> json) {
    applicationId = json["_id"] ?? "";
    user =
        json["user"] != null
            ? UserModel.fromJson(json["user"])
            : UserModel.empty();
    billCategory = json["billCategory"] ?? "";
    reason = json["reason"] ?? "";
    billFile = json["billFile"] ?? "";
    randomlySelected = json["randomlySelected"] ?? false;
    status = json["status"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": applicationId,
      "user": user.toJson(),
      "billCategory": billCategory,
      "reason": reason,
      "billFile": billFile,
      "randomlySelected": randomlySelected,
      "status": status,
    };
  }
}
