import 'package:flutter/material.dart';
import 'package:malabis_app/routes/routes_name.dart';
import 'package:malabis_app/views/authentication/signup/welcome_screen.dart';
import 'package:malabis_app/views/splash_screen.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    switch (setting.name) {
      case '/': // Add default root route
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) =>  SignUp());
      default:
        throw Exception('Route not found: ${setting.name}');
    }
  }
}
