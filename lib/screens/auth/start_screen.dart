import 'package:assist_web/utils/app_strings.dart';
import 'package:assist_web/utils/session_management/session_management.dart';
import 'package:assist_web/utils/session_management/session_token_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final SessionManagement _sessionManagement = SessionManagement();

  @override
  void initState() {
    super.initState();
    _checkSessionAndNavigate();
  }

  void _checkSessionAndNavigate() async {
    final isRemember = await _sessionManagement.getBoolSession(
      tokenKey: SessionTokenKeys.kIsRememberMeKey,
    );

    if (isRemember == true) {
      Get.offAllNamed(kDashboardScreenRoute);
    } else {
      Get.offAllNamed(kAuthScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
