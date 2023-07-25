// // To parse this JSON data, do
// //
// //     final resetPsswordModel = resetPsswordModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ResetPsswordModel resetPsswordModelFromJson(String str) => ResetPsswordModel.fromJson(json.decode(str));
//
// String resetPsswordModelToJson(ResetPsswordModel data) => json.encode(data.toJson());
//
// class ResetPsswordModel {
//   dynamic data;
//   Message? message;
//   int? code;
//
//   ResetPsswordModel({
//     this.data,
//     this.message,
//     this.code,
//   });
//
//   factory ResetPsswordModel.fromJson(Map<String, dynamic> json) => ResetPsswordModel(
//     data: json["data"],
//     message: json["message"] == null ? null : Message.fromJson(json["message"]),
//     code: json["code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data,
//     "message": message?.toJson(),
//     "code": code,
//   };
// }
//
// class Message {
//   List<String>? email;
//
//   Message({
//     this.email,
//   });
//
//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//     email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
//   };
// }


// To parse this JSON data, do
//
//     final resetPsswordModel = resetPsswordModelFromJson(jsonString);

import 'dart:convert';

ResetPsswordModel resetPsswordModelFromJson(String str) => ResetPsswordModel.fromJson(json.decode(str));

String resetPsswordModelToJson(ResetPsswordModel data) => json.encode(data.toJson());

class ResetPsswordModel {
  String? message;
  Errors? errors;

  ResetPsswordModel({
    this.message,
    this.errors,
  });

  @override
  String toString() {
    return 'ResetPsswordModel{message: $message, errors: $errors}';
  }

  factory ResetPsswordModel.fromJson(Map<String, dynamic> json) => ResetPsswordModel(
    message: json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors?.toJson(),
  };
}


class Errors {
  List<String>? email;

  Errors({
    this.email,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
  };
}
