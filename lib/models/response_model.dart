class ResponseModel {
  int statusCode = -1;
  String statusDescription = "";
  dynamic data = "";
  String userToken = "";
  Map<String, String> header = {};

  ResponseModel();

  ResponseModel.named({
    required this.statusCode,
    required this.statusDescription,
    this.data,
  });

  ResponseModel.fromJson(Map<String, dynamic> json, {this.statusCode = 0}) {
    statusDescription = json["message"] ?? "";
    data = json["data"];
    userToken = json["token"] ?? "";
  }

  ResponseModel.errorFromJson(
    Map<String, dynamic> json, {
    this.statusCode = 0,
  }) {
    data = json.isEmpty ? null : json;
    statusDescription = json['error'] ?? json['message'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'statusDescription': statusDescription,
      'data': data,
    };
  }

  @override
  String toString() {
    return 'ResponseModel{statusCode: $statusCode, statusDescription: $statusDescription, data: $data, userToken: $userToken, header: $header}';
  }
}
