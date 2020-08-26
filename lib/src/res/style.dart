


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medico_app/src/res/app_color.dart';

final kTitleStyle = GoogleFonts.poppins(
  color: Colors.white,
 
  fontSize: 15,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize:12.0,
 
);

  inputDecoration({String hint,bool isPasswordField,BuildContext context}) =>InputDecoration(
                             hoverColor: Colors.white,
                             focusColor: Colors.white,

                        //  contentPadding: EdgeInsets.only(
                             // left: 25.0, top: 10.0, right: 10.0, bottom: 10.0),
                          hintStyle: TextStyle(color: Color(0XFFe1e8ed)
                          ,fontSize: 14,
                          ),
                         labelText: hint,
                        //  errorStyle:TextStyle(color: AppColors.primaryColor ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        );
                        normalInputDecoration({String hint,bool isPasswordField}) =>InputDecoration(
                            
                             counterStyle: TextStyle(
                               color: Colors.black
                             ),
                          hintStyle: TextStyle(color: Colors.black45
                          ,fontSize: 14,
                          ),
                          hintText: hint,
                           errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        errorStyle: GoogleFonts.poppins(color: AppColors.primaryColor),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color:  Colors.black12)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.black12)
       
                        
                          )  );
                     