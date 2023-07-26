// To parse this JSON data, do
//
//     final checkCodeModel = checkCodeModelFromJson(jsonString);

import 'dart:convert';

CheckCodeModel checkCodeModelFromJson(String str) => CheckCodeModel.fromJson(json.decode(str));

String checkCodeModelToJson(CheckCodeModel data) => json.encode(data.toJson());

class CheckCodeModel {
  String? verifyCode;
  int? code;
  String? message;

  CheckCodeModel({
    this.verifyCode,
    this.code,
    this.message,
  });

  factory CheckCodeModel.fromJson(Map<String, dynamic> json) => CheckCodeModel(
    verifyCode: json["verify_code"],
    code: json["code"]??0,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "verify_code": verifyCode,
    "code": code,
    "message": message,
  };
}
