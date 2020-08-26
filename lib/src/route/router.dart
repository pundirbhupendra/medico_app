
import 'package:auto_route/auto_route_annotations.dart';
import 'package:medico_app/src/authentication/login_page.dart';
import 'package:medico_app/src/authentication/otp_page.dart';
import 'package:medico_app/src/authentication/registration_page.dart';
import 'package:medico_app/src/home/home_page.dart';
import 'package:medico_app/src/ui/profile/my_profile.dart';

import '../onboard.dart';
/*
* Run this command in terminal
* flutter packages pub run build_runner build
* */

/*
* Run this command in terminal to watch auto change
* flutter packages pub run build_runner watch
* */
@CupertinoAutoRouter()
class $Router {
 @initial
  OnboardingScreen onboardingScreen;
 RagistrationPage signUpPage;
 OtpPage otpPage;
 LoginPage loginPage;
 HomePage homePage;
 MyProfile myProfile;
  
}