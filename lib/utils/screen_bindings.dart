import 'package:assist_web/screens/application_screen/controller/application_controller.dart';
import 'package:assist_web/screens/calender_screen/controller/location_controller.dart';
import 'package:assist_web/screens/chat/controller/chat_controller.dart';
import 'package:assist_web/screens/feed_screen/controller/feed_controller.dart';
import 'package:assist_web/screens/post_screen/controller/post_controller.dart';
import 'package:assist_web/screens/setting_screen/controller/setting_controller.dart';
import 'package:assist_web/screens/subscription_screen/controller/subscription_controller.dart';
import 'package:assist_web/screens/user_screen/controller/user_controller.dart';
import 'package:get/get.dart';
import '../screens/auth/controller/auth_controller.dart';
import '../screens/calender_screen/controller/calender_controller.dart';
import '../screens/dashboard_screen/controller/dashboard_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => FeedController());
    Get.lazyPut(() => SettingController());
    Get.lazyPut(() => SubscriptionController());
    Get.lazyPut(() => CalenderController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => LocationController());
    Get.lazyPut(() => ApplicationController());
    Get.lazyPut(() => PostController());
    Get.lazyPut(() => ChatController());
  }
}
