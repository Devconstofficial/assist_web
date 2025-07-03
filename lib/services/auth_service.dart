import 'dart:convert';
import 'dart:developer';

import 'package:assist_web/models/response_model.dart';
import 'package:assist_web/models/user_model.dart';
import 'package:assist_web/services/http_request.dart';
import 'package:assist_web/services/web_urls.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> signInUser({
    required String email,
    required String password,
  }) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kSignInUrl,
      requestBody: {"email": email, "password": password},
      requestHeader: {'Content-Type': 'application/json'},
    );
    log("user data is -----------$responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserTokenKey,
        tokenValue: responseModel.data["data"]["authToken"],
      );

      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserModelKey,
        tokenValue: jsonEncode(responseModel.data["data"]["user"]),
      );

      return UserModel.fromJson(responseModel.data["data"]["user"]);
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> forgotPassword({required String email}) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kForgotPasswordOTPUrl,
      requestBody: {"email": email},
      requestHeader: {'Content-Type': 'application/json'},
    );
    log("$responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> verifyOTP({
    required String email,
    required String otp,
  }) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kVerifyOTPUrl,
      requestBody: {"email": email, "otp": otp},
      requestHeader: {'Content-Type': 'application/json'},
    );

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> createNewPassword({
    required String email,
    required String newPassword,
  }) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kCreatePasswordUrl,
      requestBody: {"email": email, "password": newPassword},
      requestHeader: {'Content-Type': 'application/json'},
    );
    log("$responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> updateProfile({required Map<String, dynamic> body}) async {
    final token = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserTokenKey,
    );
    ResponseModel responseModel = await _client.customRequest(
      'PUT',
      url: WebUrls.kUpdateProfileUrl,
      requestBody: body,
      requestHeader: {
        'Content-Type': 'application/json',
        'Authorization': 'Baerer $token',
      },
    );
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserModelKey,
        tokenValue: jsonEncode(responseModel.data["data"]["user"]),
      );

      log("user updated data is -----------${responseModel.data['data']}");
      return UserModel.fromJson(responseModel.data["data"]["user"]);
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}
