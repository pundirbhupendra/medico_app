
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medico_app/src/res/app_color.dart';

 showMessage(String msg) => Fluttertoast.showToast(
                          backgroundColor: Colors.white,
                          fontSize: 15,
                          textColor: AppColors.primaryColor, msg: msg);