import 'package:assist_web/models/user_model.dart';

class EventModel {
  String eventId = "";
  String eventTitle = "";
  String place = "";
  DateTime date = DateTime.now();
  int startTime = 0;
  int endTime = 0;
  List<UserModel> members = [];
  String notes = "";

  EventModel();

  EventModel.fromJson(Map<String, dynamic> json) {
    eventId = json["_id"] ?? "";
    eventTitle = json["eventTitle"] ?? "";
    place = json["place"] ?? "";
    date = DateTime.tryParse(json["date"] ?? "") ?? DateTime.now();
    startTime = json["startTime"] ?? 0;
    endTime = json["endTime"] ?? 0;
    members =
        (json["members"] as List).map((e) => UserModel.fromJson(e)).toList();
    notes = json["notes"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": eventId,
      "eventTitle": eventTitle,
      "place": place,
      "date": date.toIso8601String(),
      "startTime": startTime,
      "endTime": endTime,
      "members": members,
      "notes": notes,
    };
  }
}
