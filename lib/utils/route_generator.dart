import 'package:assist_web/utils/screen_bindings.dart';
import 'package:get/get.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/auth/send_otp_screen.dart';
import '../screens/auth/set_new_pass.dart';
import '../screens/auth/verify_otp_screen.dart';
import '../screens/calender_screen/calender_screen.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';
import '../screens/feed_screen/feed_screen.dart';
import '../screens/setting_screen/setting_screen.dart';
import '../screens/subscription_screen/subscription_screen.dart';
import '../screens/user_screen/user_screen.dart';
import 'app_strings.dart';


class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(name: kDashboardScreenRoute, page: () => DashboardScreen(), binding: ScreenBindings(),),
      GetPage(name: kUserScreenRoute, page: () => UserScreen(), binding: ScreenBindings(),),
      GetPage(name: kFeedScreenRoute, page: () => FeedScreen(), binding: ScreenBindings(),),
      GetPage(name: kSettingScreenRoute, page: () => SettingScreen(), binding: ScreenBindings(),),
      GetPage(name: kSubscriptionScreenRoute, page: () => SubscriptionScreen(), binding: ScreenBindings(),),
      GetPage(name: kCalenderScreenRoute, page: () => CalenderScreen(), binding: ScreenBindings(),),
      GetPage(
        name: kAuthScreenRoute,
        page: () => const AuthScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kSendOtpScreenRoute,
        page: () => const SendOtpScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kVerifyScreenRoute,
        page: () => const VerifyOtpScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kSetNewPassScreenRoute,
        page: () => const SetNewPassScreen(),
        binding: ScreenBindings(),
      ),
    ];
  }
}

