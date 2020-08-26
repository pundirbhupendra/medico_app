import 'package:flutter/material.dart';
import 'package:medico_app/src/data/repositories/auth_repo/auth_repo.dart';
import 'package:medico_app/src/presentation/utils/common_toast.dart';
import 'package:medico_app/src/presentation/widget/common_button.dart';
import 'package:medico_app/src/res/app_color.dart';
import 'package:medico_app/src/route/router.gr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //  backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: 
            Column(
              children: [
                Center(
                  child: Text('Welcome to Medico Home'),
                ),
                RaisedButton(
                    child: Text('Logout'),
                    onPressed: () async {

                     _singout();
                    }),
                    RaisedButton(
                    child: Text('Profile'),
                    onPressed: () async {

                    Navigator.pushNamed(context, Router.myProfile);
                    })
              ],
            ),
            );
  }

  _singout() async {
    final response = await AuthRepository.signOut();
    if (response.statusCode == 204) {
      showMessage("loggedout!");

      await Navigator.pushReplacementNamed(context, Router.onboardingScreen);
    }
  }
}
