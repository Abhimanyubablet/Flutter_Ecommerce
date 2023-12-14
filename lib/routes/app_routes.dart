import 'package:flutter/cupertino.dart';
import 'package:shopping_practise_project/presentation/dashboard/dashboard.dart';
import 'package:shopping_practise_project/presentation/login_screen/login_screen.dart';
import 'package:shopping_practise_project/presentation/login_screen/login_with_phone.dart';

import '../presentation/login_screen/verify_code_screen.dart';
import '../presentation/splash_screen/slash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  static const String dashboard = '/dashboard';
  static const String login_with_phone = '/login_with_phone';
  static const String verifycode = '/verifycode';


  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.splashScreen: (context) => SplashScreen(),
      AppRoutes.loginScreen: (context) => LoginScreen(),
      AppRoutes.dashboard: (context) => DashBoard(),

    };
  }

}




