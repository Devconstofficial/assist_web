import 'package:shared_preferences/shared_preferences.dart';

class SessionManagement {
  SessionManagement._();

  static final SessionManagement _instance = SessionManagement._();

  factory SessionManagement() {
    return _instance;
  }

  Future<void> saveSession({
    required String tokenKey,
    required String tokenValue,
  }) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(tokenKey, tokenValue);
  }

  Future<void> saveBoolSession({
    required String tokenKey,
    required bool tokenValue,
  }) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(tokenKey, tokenValue);
  }

  Future<void> removeSession({required String token}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(token);
  }

  Future<String> getSessionToken({required String tokenKey}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(tokenKey) ?? '';
  }

  Future<bool> getBoolSession({required String tokenKey}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(tokenKey) ?? false;
  }
}
