import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/screens/auth/form_login.dart';
import 'package:ueh_mobile_app/screens/auth/forgot_password.dart';
import 'package:ueh_mobile_app/screens/auth/reset_password.dart';
import 'package:ueh_mobile_app/widgets/welcome.dart';
import 'package:ueh_mobile_app/screens/auth/auth_home.dart';
import 'package:ueh_mobile_app/screens/auth/form_register.dart';
import 'package:ueh_mobile_app/screens/student/dashboard.dart';
import 'package:ueh_mobile_app/screens/student/pages/home_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/profile_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/exam_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/schedule_screen.dart';

class AppRoutes {
  static const String welcomeHome = '/welcome';
  static const String authHome = '/auth_home';
  static const String formLogin = '/form_login';
  static const String forgotPassword = '/forgot_password';
  static const String resetPassword = '/reset_password';
  static const String formRegister = '/register';
  static const String dashboardScreen ='/dashboard';
  static const String profileScreen = '/profile';
  static const String homeScreen = '/home';
  static const String examScreen = '/exam';
  static const String scheduleScreen ='/schedule';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeHome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case authHome:
        return MaterialPageRoute(builder: (_) => AuthHome());
      case formRegister:
        return MaterialPageRoute(builder: (_)=>FormRegister());
      case formLogin:
        return MaterialPageRoute(builder: (_) => FormLogin());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case dashboardScreen:
        return MaterialPageRoute(builder: (_) => Dashboard());
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
