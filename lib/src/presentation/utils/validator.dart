class Validator {
  String validateName(String value) {
    var pattern = r'(^[a-zA-Z ]*$)';
    var regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    var pattern =r'(^(?:[+0]9)?[0-9]{10,12}$)';
    var regExp = new RegExp(pattern);
     if (value.length==0) {
      return "Please enter mobile number";
     } else 
    if (value.length != 10) {
      return "Phone number must be 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Phone number must be digits";
    }
    return null;
  }

  String passwordDoNotMatch(String value, String confirmValue) {
    var pattern = r'(^[0-9]*$)';
    //  var regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Password is Required";
    } else if (value != confirmValue) {
      return "Password do not match!";
    }
    return null;
  }

  String validateEmail(String value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String password) {
    var pattern = r'(^[0-9]*$)';
    var regExp = new RegExp(pattern);
    if (password.isEmpty) {
      return "Password is Required";
     } else if (password.length < 8) {
      return "Password must be 8 digits";
     }
    return null;
  }

  String validateText(String value, String text) {
    var pattern = r'(^[a-zA-Z ]*$)';
    var regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "$text is Required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "$text must be a-z and A-Z";
    }
    return null;
  }

  String validateNumber(String value, String desc) {
    if (value.isEmpty) {
      return "$desc is Required";
    }
    return null;
  }
}
