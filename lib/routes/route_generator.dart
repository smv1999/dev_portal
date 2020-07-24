import 'file:///C:/Users/smv1999/dev_portal/lib/screens/forgot_password_page.dart';
import 'package:dev_portal/home_page.dart';
import 'package:dev_portal/pages/settings_page.dart';
import 'file:///C:/Users/smv1999/dev_portal/lib/screens/login_page.dart';
import 'package:dev_portal/screens/main.dart';
import 'package:dev_portal/screens/user_profile_page.dart';
import 'file:///C:/Users/smv1999/dev_portal/lib/screens/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case '/login':
      // Validation of correct data type
          return MaterialPageRoute(
            builder: (_) => MyLoginPage());
      case '/signup':
        return MaterialPageRoute(
            builder: (_) => MyRegisterPage());
      case '/home':
        return MaterialPageRoute(
            builder: (_) => MyHomePage());
      case '/forgotpassword':
        return MaterialPageRoute(
            builder: (_) => ForgotPasswordPage());
      case '/settings':
        return MaterialPageRoute(
            builder: (_) => SettingsPage());
      case '/profile':
        return MaterialPageRoute(
            builder: (_) => UserProfile());
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('You are on a wrong page!'),
        ),
      );
    });
  }
}