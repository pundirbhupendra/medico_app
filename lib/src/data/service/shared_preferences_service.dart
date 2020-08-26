import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._internal();

  static SharedPreferencesService _instance;
  static SharedPreferences _preferences;

  static Future<SharedPreferencesService> get instance async {
    if (_instance == null) {
      _instance = SharedPreferencesService._internal();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  final mobileNumber = "mobileNo";
  final authToken = "authToken";
  final phoneVerifyKey = "phoneVerifyKey";
    final loginTokenKey = "phoneVerifyKey";
     final isLogOutKey = "isLogout";
  setUserPhoneNo(String mobileNo) {
    _preferences.setString(mobileNumber, mobileNo);
  }

  getUserPhoneNo() => _preferences.getString(mobileNumber);
  setPhoneNumberVerify(bool verify){
    _preferences.setBool(phoneVerifyKey, verify);
  }
   getPhoneNoVerify()=> _preferences.getBool(phoneVerifyKey);

    setToken(String token){
    _preferences.setString(loginTokenKey,token);
  }
   getToken()=> _preferences.getString(loginTokenKey);
    logout()=>  _preferences.remove(loginTokenKey);

    setLogout(bool isLogout)=> _preferences.setBool(isLogOutKey,isLogout);
     isUserLogOut()=> _preferences.getBool(isLogOutKey);

}
