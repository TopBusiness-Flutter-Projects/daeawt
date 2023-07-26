import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';

class RegisterModel {
  int user_id=0;
  String image='';
  String email = '';
  String password = '';
  String name = '';
  String phone = '';


  bool isDataValid() {
    if (EmailValidator.validate(email) &&
        (user_id!=0||(!password.isEmpty &&
        password.length >= 6) )&&
        name.isNotEmpty &&

        phone.isNotEmpty ) {
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>> updateToJson() async => {
        "phone": phone,
        "email": email,
        "name": name,
        "password": password,

      };
  Future<Map<String, dynamic>> updateuserToJson() async => {
        "phone": phone,
        "email": email,
        "name": name,
    if (image.isNotEmpty&&!image.contains("http")) ...{"image": await MultipartFile.fromFile(image)},




      };
}
