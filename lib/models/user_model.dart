class UserModel {
  String userId = "";
  String email = "";
  String password = "";
  String name = "";
  String userImage = "";
  List<String> roles = [];
  List<String> providers = [];
  List<dynamic> notificationIds = [];
  String createdAt = "";
  bool paidUser = false;
  String phoneNumber = "";
  String location = "";
  bool blocked = false;

  UserModel.empty();

  UserModel({
    required this.userId,
    required this.email,
    required this.password,
    required this.name,
    required this.userImage,
    required this.roles,
    required this.providers,
    required this.notificationIds,
    required this.createdAt,
    required this.paidUser,
    required this.phoneNumber,
    required this.location,
    required this.blocked,
  });

  UserModel copyWith({
    String? userId,
    String? email,
    String? password,
    String? name,
    String? userImage,
    List<String>? roles,
    List<String>? providers,
    List<dynamic>? notificationIds,
    String? createdAt,
    bool? paidUser,
    String? phoneNumber,
    String? location,
    bool? blocked,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      userImage: userImage ?? this.userImage,
      roles: roles ?? this.roles,
      providers: providers ?? this.providers,
      createdAt: createdAt ?? this.createdAt,
      notificationIds: notificationIds ?? this.notificationIds,
      paidUser: paidUser ?? this.paidUser,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      blocked: blocked ?? this.blocked,
    );
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json["_id"] ?? json["id"] ?? "";
    email = json["email"] ?? "";
    password = json["password"] ?? "";
    name = json["name"] ?? "";
    userImage = json["profilePicture"] ?? "";
    roles = List<String>.from(json["roles"] ?? []);
    providers = List<String>.from(json["providers"] ?? []);
    notificationIds = List<dynamic>.from(json["notificationIds"] ?? []);
    createdAt = json["createdAt"] ?? "";
    paidUser = json["paidUser"] ?? false;
    phoneNumber = json["phoneNumber"] ?? "";
    location = json["location"] ?? "";
    blocked = json["blocked"] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": userId,
      "email": email,
      "password": password,
      "name": name,
      "userImage": userImage,
      "roles": roles,
      "providers": providers,
      "createdAt": createdAt,
      "phoneNumber": phoneNumber,
      "paidUser": paidUser,
    };
  }
}
