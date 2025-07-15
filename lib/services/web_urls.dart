class WebUrls extends _BaseUrl {
  WebUrls._();

  static const String kSignInUrl = "${_BaseUrl._kBaseUrl}/auth/signin";
  static const String kForgotPasswordOTPUrl =
      "${_BaseUrl._kBaseUrl}/auth/forgotPassword";
  static const String kVerifyOTPUrl =
      "${_BaseUrl._kBaseUrl}/auth/forgotPassword/VerifyEmail";
  static const String kCreatePasswordUrl =
      "${_BaseUrl._kBaseUrl}/auth/createPassword";
  static const String kUpdateProfileUrl = "${_BaseUrl._kBaseUrl}/user/me";
  static const String kUsersUrl = "${_BaseUrl._kBaseUrl}/admin/users";
  static const String kPostUrl = "${_BaseUrl._kBaseUrl}/admin/posts";
  static const String kEventUrl = "${_BaseUrl._kBaseUrl}/admin/events";
  static const String kApplicationUrl =
      "${_BaseUrl._kBaseUrl}/admin/applications";
  static const String kSubscriptionUrl =
      "${_BaseUrl._kBaseUrl}/admin/subscriptions";
  static const String kStatsUrl = "${_BaseUrl._kBaseUrl}/admin/stats";
  static const String kGetAllPostsUrl = "${_BaseUrl._kBaseUrl}/admin/posts";
  static const String kGetRandomApplicationUrl =
      "${_BaseUrl._kBaseUrl}/admin/applications/random";
  static const String kGetNotificationIds =
      "${_BaseUrl._kBaseUrl}/user/notifications/ids";
}

abstract class _BaseUrl {
  static const String _kBaseUrl = 'https://backend.theassistapp.org';
}
