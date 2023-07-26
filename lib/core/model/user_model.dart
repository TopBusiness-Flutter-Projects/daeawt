// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

class UserModel {
  Data? data;
  String? message;
  int? code;

  UserModel({
     this.data,
     this.message,
     this.code,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data:json["data"]!=null? Data.fromJson(json["data"]):json["data"],
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
  User? user;
  String? accessToken;
  String? tokenType;

  Data({
     this.user,
     this.accessToken,
     this.tokenType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "access_token": accessToken,
    "token_type": tokenType,
  };
}

class User {
  int id;
  String name;
  String phone;
  String email;
  int status;
  dynamic userType;
  String watts;
  String image;
  dynamic address;
  dynamic providerType;
  dynamic translationTypeId;
  dynamic aboutMe;
  dynamic experience;
  dynamic previousExperience;
  dynamic certificateImage;
  dynamic locationImage;
  dynamic commercialRegisterImage;
  dynamic city;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    this.userType,
    required this.watts,
    required this.image,
    this.address,
    this.providerType,
    this.translationTypeId,
    this.aboutMe,
    this.experience,
    this.previousExperience,
    this.certificateImage,
    this.locationImage,
    this.commercialRegisterImage,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"]??" ",
    email: json["email"]??'',
    status: json["status"]??0,
    userType: json["user_type"],
    watts: json["watts"],
    image: json["image"],
    address: json["address"],
    providerType: json["provider_type"],
    translationTypeId: json["translation_type_id"],
    aboutMe: json["about_me"],
    experience: json["experience"],
    previousExperience: json["previous_experience"],
    certificateImage: json["certificate_image"],
    locationImage: json["location_image"],
    commercialRegisterImage: json["commercial_register_image"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "status": status,
    "user_type": userType,
    "watts": watts,
    "image": image,
    "address": address,
    "provider_type": providerType,
    "translation_type_id": translationTypeId,
    "about_me": aboutMe,
    "experience": experience,
    "previous_experience": previousExperience,
    "certificate_image": certificateImage,
    "location_image": locationImage,
    "commercial_register_image": commercialRegisterImage,
    "city": city,
  };
}
