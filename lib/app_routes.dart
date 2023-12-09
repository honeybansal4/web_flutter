import 'package:flutter/material.dart';
import 'package:web_demo_satish/view/main_screen.dart';

import 'view/authentication_screen.dart';

class AppRoutes {
  static const String loginScreen = "/loginScreen";
  static const String homeScreen = "/homeScreen";
}

class OnGenerateRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => AuthenticationScreen(), settings: settings);
      case AppRoutes.homeScreen:
        return MaterialPageRoute(
            builder: (_) => const MainScreen(), settings: settings);
    }
    return null;
  }
}
