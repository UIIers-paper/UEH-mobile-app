import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/screens/auth/form_login.dart';
import 'package:ueh_mobile_app/screens/auth/forgot_password.dart';
import 'package:ueh_mobile_app/screens/auth/reset_password.dart';

import 'package:ueh_mobile_app/screens/auth/auth_home.dart';


class AppRoutes {
  static const String welcomeHome = '/welcome';
  static const String authHome = '/auth_home';
  static const String formLogin = '/form_login';
  static const String forgotPassword = '/forgot_password';
  static const String resetPassword = '/reset_password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authHome:
        return MaterialPageRoute(builder: (_) => AuthHome());
      case formLogin:
        return MaterialPageRoute(builder: (_) => FormLogin());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case "/":
        return MaterialPageRoute(builder: (_) => AuthHome());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

}
