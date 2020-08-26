import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medico_app/src/res/app_color.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      
        textTheme: TextTheme(

      headline1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
      focusColor: Colors.white,
      accentColor: Colors.blue,
      inputDecorationTheme: InputDecorationTheme(
        counterStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Color(0XFFe1e8ed),
          fontSize: 14,
        ),
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        errorStyle: GoogleFonts.poppins(color: Colors.white),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      fontFamily: 'poppins',
      primaryColor: AppColors.primaryColor,
      
    );
  }
}
