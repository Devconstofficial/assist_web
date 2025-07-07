import 'package:assist_web/models/response_model.dart';
import 'package:assist_web/services/http_request.dart';
import 'package:assist_web/services/web_urls.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';

class DashboardStatsService {
  DashboardStatsService._();

  static final DashboardStatsService _instance = DashboardStatsService._();

  factory DashboardStatsService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> getMatrices() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kStatsUrl}/matrices",
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data['data']["matrics"];
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getDonarMatrices() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kStatsUrl}/donor-matrices",
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data['data']["percentage"];
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getUserGrowth({required String type}) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kStatsUrl}/user-growth?type=$type",
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data['data']["usersGrowth"] as List;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}
