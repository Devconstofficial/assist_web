import 'package:assist_web/models/application_model.dart';
import 'package:assist_web/models/response_model.dart';
import 'package:assist_web/services/http_request.dart';
import 'package:assist_web/services/web_urls.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';

class ApplicationService {
  ApplicationService._();

  static final ApplicationService _instance = ApplicationService._();

  factory ApplicationService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> getApplications() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kApplicationUrl,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return (responseModel.data['data']["applications"] as List)
          .map((json) => ApplicationModel.fromJson(json))
          .toList();
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> updateApplicationStatus({
    required String status,
    required String id,
  }) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'PATCH',
      url: "${WebUrls.kApplicationUrl}/$id",
      requestBody: {"status": status},
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}
