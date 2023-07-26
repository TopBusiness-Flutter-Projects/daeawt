// To parse this JSON data, do
//
//     final resetPsswordModel = resetPsswordModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordModel resetPsswordModelFromJson(String str) => ResetPasswordModel.fromJson(json.decode(str));

String resetPsswordModelToJson(ResetPasswordModel data) => json.encode(data.toJson());

class ResetPasswordModel {
  String? message;
  int? code;

  ResetPasswordModel({
    this.message,
    this.code,
  });

  @override
  String toString() {
    return 'ResetPsswordModel{message: $message, code: $code}';
  }

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(
    message: json["message"],
    code: json["code"]??0,
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
  };
}
