// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:medico_app/src/onboard.dart';
import 'package:medico_app/src/authentication/registration_page.dart';
import 'package:medico_app/src/authentication/otp_page.dart';
import 'package:medico_app/src/authentication/login_page.dart';
import 'package:medico_app/src/home/home_page.dart';
import 'package:medico_app/src/ui/profile/my_profile.dart';


class Router {
  static const onboardingScreen = '/';
  static const signUpPage = '/sign-up-page';
  static const otpPage = '/otp-page';
  static const loginPage = '/login-page';
  static const homePage = '/home-page';
  static const myProfile = '/my-profile';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.onboardingScreen:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => OnboardingScreen(),
          settings: settings,
        );
      case Router.signUpPage:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => RagistrationPage(),
          settings: settings,
        );
      case Router.otpPage:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => OtpPage(),
          settings: settings,
        );
      case Router.loginPage:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => LoginPage(),
          settings: settings,
        );
      case Router.homePage:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => HomePage(),
          settings: settings,
        );
      case Router.myProfile:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => MyProfile(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
