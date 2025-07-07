import 'package:assist_web/models/event_model.dart';
import 'package:assist_web/models/response_model.dart';
import 'package:assist_web/services/http_request.dart';
import 'package:assist_web/services/web_urls.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';

class EventService {
  EventService._();

  static final EventService _instance = EventService._();

  factory EventService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> getEvents() async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kEventUrl,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return (responseModel.data['data']["events"] as List)
          .map((json) => EventModel.fromJson(json))
          .toList();
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> addEvent({required Map<String, dynamic> body}) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kEventUrl,
      requestBody: body,
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
