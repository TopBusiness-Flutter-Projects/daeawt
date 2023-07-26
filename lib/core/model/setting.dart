class SettingDataModel {
  Data data;
  String message;
  int code;

  SettingDataModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory SettingDataModel.fromJson(Map<String, dynamic> json) => SettingDataModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  int id;
  String title;
  String logo;
  String email;
  String address;
  String phone;
  String terms;
  String privacy;
  String facebook;
  String youtube;
  String linkedin;
  String instagram;
  String twitter;
  String whatsapp;
  dynamic createdAt;
  dynamic updatedAt;

  Data({
    required this.id,
    required this.title,
    required this.logo,
    required this.email,
    required this.address,
    required this.phone,
    required this.terms,
    required this.privacy,
    required this.facebook,
    required this.youtube,
    required this.linkedin,
    required this.instagram,
    required this.twitter,
    required this.whatsapp,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    logo: json["logo"],
    email: json["email"],
    address: json["address"],
    phone: json["phone"],
    terms: json["terms"],
    privacy: json["privacy"],
    facebook: json["facebook"],
    youtube: json["youtube"],
    linkedin: json["linkedin"],
    instagram: json["instagram"],
    twitter: json["twitter"],
    whatsapp: json["whatsapp"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "logo": logo,
    "email": email,
    "address": address,
    "phone": phone,
    "terms": terms,
    "privacy": privacy,
    "facebook": facebook,
    "youtube": youtube,
    "linkedin": linkedin,
    "instagram": instagram,
    "twitter": twitter,
    "whatsapp": whatsapp,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
