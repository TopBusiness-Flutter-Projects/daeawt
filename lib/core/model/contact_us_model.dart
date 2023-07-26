// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  Data? data;
  String? message;
  int? code;

  ContactUsModel({
    this.data,
    this.message,
    this.code,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  String? name;
  String? phone;
  String? subject;
  String? message;
  int? id;

  Data({
    this.name,
    this.phone,
    this.subject,
    this.message,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    phone: json["phone"],
    subject: json["subject"],
    message: json["message"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "subject": subject,
    "message": message,
    "id": id,
  };
}
