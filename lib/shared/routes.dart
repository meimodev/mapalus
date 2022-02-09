import 'package:flutter/material.dart';
import 'package:mapalus/app/modules/account_settings/account_settings_screen.dart';
import 'package:mapalus/app/modules/home/home_screen.dart';

class Routes {
  static const String home = '/';
  static const String accountSetting = '/account-setting';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case accountSetting:
        return MaterialPageRoute(builder: (_) => const AccountSettingsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}