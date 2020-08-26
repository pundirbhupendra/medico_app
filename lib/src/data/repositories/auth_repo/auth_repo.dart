import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medico_app/src/data/http_exception.dart';
import 'package:medico_app/src/data/service/api_service.dart';
import 'package:medico_app/src/data/service/end_point.dart';
import 'package:medico_app/src/data/service/shared_preferences_service.dart';
import 'package:medico_app/src/model/login_response.dart';
import 'package:medico_app/src/res/app_color.dart';

class AuthRepository {
  AuthRepository(this.apiService) : assert(apiService != null);

  final ApiService apiService;
  //reg
  Future<LoginResponse> onLogin(String phoneNo, String password) async {
    final body = {
      "user": {"phone_number": phoneNo, "password": password}
    };

    SharedPreferencesService prefs = await SharedPreferencesService.instance;

    // final basicAuthToken = prefs.getToken();
    // print(basicAuthToken);

    final response =
        await apiService.dio.post(EndPoints.baseUrl + EndPoints.login,
            data: json.encode(body),
            options: Options(
              contentType: 'application/json',
              // headers: {'authorization': 'Token $basicAuthToken'}
            ));
    if (response.statusCode == 200) {
      final res = response.data;

      final token = res["user"]["token"];
      final userphoneNo = res["user"]["phone_number"];
      LoginResponse loginResponse = LoginResponse.fromJson(res);
      await prefs.setUserPhoneNo(userphoneNo);
      await prefs.setToken(token);
      return loginResponse;
    } else if (response.statusCode == 400) {
      throw HttpException(
          "A user with this phone number and password was not found.");
    }
  }

  onRegistration(Map<dynamic, dynamic> data) async {
    //Dio dio = Dio();
    SharedPreferencesService _prefs = await SharedPreferencesService.instance;
    // try {
    final response =
        await apiService.dio.post(EndPoints.baseUrl + EndPoints.signup,
            data: json.encode(data),
            options: Options(
              contentType: 'application/json',
            ));
    if (response.statusCode == 201) {
      final res = response.data;
      final token = res["user"]["token"];
      final phoneNo = res["user"]["phone_number"];
      print(res["user"]["token"]);
      await _prefs.setToken(token);
      await _prefs.setUserPhoneNo(phoneNo);
      return "OTP has sent to your register mobile number";
    } else if (response.statusCode == 400 || response.statusCode == 406) {
      throw HttpException("Phone number or email already in use!");
    }

    // } catch (e) {
    //throw HttpException(e.toString());
    // }
  }

  Future verifyOtp(String otp) async {
    SharedPreferencesService prefs = await SharedPreferencesService.instance;

    final basicAuth = prefs.getToken();
    try {
      final response = await apiService.dio.post(
          EndPoints.baseUrl + EndPoints.otpVerify,
          data: {"otp": otp},
          options: Options(
              contentType: 'application/json',
              headers: {'authorization': 'Token $basicAuth'}));
      if (response.statusCode == 200) {
        prefs.setPhoneNumberVerify(true);
        return "OTP Verify";
      } else if (response.statusCode == 202) {
        throw Exception("OTP Expired or may be OTP Mismatch");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future otpsResend() async {
    SharedPreferencesService prefs = await SharedPreferencesService.instance;

    final basicAuth = prefs.getToken();
    print(basicAuth);
    // try {
    final response = await apiService.dio.get(
        EndPoints.baseUrl + EndPoints.otpResend,
        options: Options(
            contentType: 'application/json',
            headers: {'authorization': 'Token $basicAuth'}));
    if (response.statusCode == 202) {
      final res = response.data;
      // prefs.setPhoneNumberVerify(true);
      return res["message"];
    } else if (response.statusCode == 400) {
      final res = response.data;
      throw Exception(res["message"]);
    }
    //  } catch (e) {
    // throw Exception(e.toString());
    //}
  }

  static Future signOut() async {
    SharedPreferencesService prefs = await SharedPreferencesService.instance;
    Dio dio = Dio();

    final basicAuth =prefs.getToken();
    print(basicAuth);
    var response;
    try {
      response = await dio.post(EndPoints.baseUrl + EndPoints.signout,
          options: Options(headers: {"Authorization": "Token $basicAuth"}));
      if (response.statusCode == 204) {
        await prefs.logout();
        await prefs.setLogout(true);
      //  final res = response.data;

        return response;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        Fluttertoast.showToast(
            backgroundColor: Colors.red,
            fontSize: 15,
            textColor: AppColors.primaryColor,
            msg: e.response.data["detail"]);
      } else {
        Fluttertoast.showToast(
            backgroundColor: Colors.red,
            fontSize: 15,
            textColor: AppColors.primaryColor,
            msg: "Somthing Wrong!");
      }
    } catch (e) {
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          fontSize: 15,
          textColor: AppColors.primaryColor,
          msg: "Try Again");
    }
  }
}
