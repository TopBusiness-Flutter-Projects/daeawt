import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';

class LoginModel{

  String email = '';
  String password = '';

  bool isDataValid() {
    if (EmailValidator.validate(email) &&
       !password.isEmpty &&
        password.length >= 6
       ) {
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>> updateToJson() async => {

        "email": email,
        "password": password,

      };
}
