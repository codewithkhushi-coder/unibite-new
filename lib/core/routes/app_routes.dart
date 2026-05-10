import 'package:flutter/material.dart';

import '../../modules/auth/splash_screen.dart';
import '../../modules/auth/login_screen.dart';
import '../../modules/auth/signup_screen.dart';
import '../../modules/user/user_dashboard.dart';
import '../../modules/vendor/vendor_dashboard.dart';
import '../../modules/delivery/delivery_dashboard.dart';
import '../../modules/admin/admin_dashboard.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String vendor = '/vendor';
  static const String delivery = '/delivery';
  static const String admin = '/admin';

  static final Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    home: (context) => const UserDashboard(),
    vendor: (context) => const VendorDashboard(),
    delivery: (context) => const DeliveryDashboard(),
    admin: (context) => const AdminDashboard(),
  };
}