
import 'package:flutter/material.dart';
import 'package:medico_app/src/onboard.dart';
import 'package:medico_app/src/res/app_theme.dart';

import 'route/router.gr.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      title: 'Medico',
      theme: AppTheme.appTheme(),
      home:OnboardingScreen(),
     initialRoute: Router.onboardingScreen,
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigator.key
      
    );
  }
}