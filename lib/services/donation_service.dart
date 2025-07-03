import 'package:assist_web/models/response_model.dart';
import 'package:assist_web/models/subscription_model.dart';
import 'package:assist_web/services/http_request.dart';
import 'package:assist_web/services/web_urls.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';

class DonationService {
  DonationService._();

  static final DonationService _instance = DonationService._();

  factory DonationService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> getDonationStats() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kSubscriptionUrl}/donation",
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return responseModel.data['data']["donations"];
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getRevenue({required String type}) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kSubscriptionUrl}/revenue?type=$type",
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return List<Map<String, dynamic>>.from(
        responseModel.data['data']["revenue"],
      );
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getSubscriptions() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kSubscriptionUrl,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return (responseModel.data['data']["subscriptions"]['subscriptions']
              as List)
          .map((json) => SubscriptionModel.fromJson(json))
          .toList();
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}
