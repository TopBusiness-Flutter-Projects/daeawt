class ContactsDataModel {
  List<ContactsModel> data;
  String message;
  int code;

  ContactsDataModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory ContactsDataModel.fromJson(Map<String, dynamic> json) => ContactsDataModel(
    data: List<ContactsModel>.from(json["data"].map((x) => ContactsModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class ContactsModel {
  int id;
  String name;
  String phone;
  dynamic email;
  dynamic userId;

  ContactsModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.userId,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) => ContactsModel(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "user_id": userId,
  };
}
