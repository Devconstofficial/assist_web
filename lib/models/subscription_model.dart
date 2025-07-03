import 'user_model.dart';

class SubscriptionModel {
  String id = "";
  UserModel user = UserModel.empty();
  String type = "";
  String startDate = "";
  String endDate = "";
  String status = "";
  double amount = 0;

  SubscriptionModel.empty();

  SubscriptionModel({
    required this.id,
    required this.user,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.amount,
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"] ?? "";
    user =
        json["user"] != null
            ? UserModel.fromJson(json["user"])
            : UserModel.empty();
    type = json["type"] ?? "";
    startDate = json["startDate"] ?? "";
    endDate = json["endDate"] ?? "";
    status = json["status"] ?? "";
    amount = (json["amount"] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": user.toJson(),
      "type": type,
      "startDate": startDate,
      "endDate": endDate,
      "status": status,
      "amount": amount,
    };
  }

  SubscriptionModel copyWith({
    String? id,
    UserModel? user,
    String? type,
    String? startDate,
    String? endDate,
    String? status,
    double? amount,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      user: user ?? this.user,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      amount: amount ?? this.amount,
    );
  }
}
