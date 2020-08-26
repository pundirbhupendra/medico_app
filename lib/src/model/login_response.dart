class LoginResponse {
  User user;

  LoginResponse({this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class User {
  String phoneNumber;
  String token;
  bool otp;

  User({this.phoneNumber, this.token, this.otp});

  User.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    token = json['token'];
    otp = json['otp'];
  }

}