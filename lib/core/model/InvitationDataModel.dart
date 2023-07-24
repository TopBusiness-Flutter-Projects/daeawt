class InvitationDataModel {
  List<InvitationModel> data;
  String message;
  int code;

  InvitationDataModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory InvitationDataModel.fromJson(Map<String, dynamic> json) => InvitationDataModel(
    data: List<InvitationModel>.from(json["data"].map((x) => InvitationModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class InvitationModel {
  int id;
  String date;
  String title;
  String image;
  String hasQrcode;
  dynamic qrcode;
  String sendDate;
  String address;
  String longitude;
  String latitude;
  String password;
  int userId;
  String status;
  int step;
  List<Invitee> invitees;
  int messages;
  int inviteesCount;
  int scanned;
  int confirmed;
  int apologized;
  int waiting;
  int notSent;
  int failed;

  InvitationModel({
    required this.id,
    required this.date,
    required this.title,
    required this.image,
    required this.hasQrcode,
    this.qrcode,
    required this.sendDate,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.password,
    required this.userId,
    required this.status,
    required this.step,
    required this.invitees,
    required this.messages,
    required this.inviteesCount,
    required this.scanned,
    required this.confirmed,
    required this.apologized,
    required this.waiting,
    required this.notSent,
    required this.failed,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) => InvitationModel(
    id: json["id"],
    date: json["date"],
    title: json["title"],
    image: json["image"],
    hasQrcode: json["has_qrcode"],
    qrcode: json["qrcode"],
    sendDate: json["send_date"],
    address: json["address"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    password: json["password"],
    userId: json["user_id"],
    status: json["status"],
    step: json["step"],
    invitees: List<Invitee>.from(json["invitees"].map((x) => Invitee.fromJson(x))),
    messages: json["messages"],
    inviteesCount: json["invitees_count"],
    scanned: json["scanned"],
    confirmed: json["confirmed"],
    apologized: json["apologized"],
    waiting: json["waiting"],
    notSent: json["not_sent"],
    failed: json["failed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "title": title,
    "image": image,
    "has_qrcode": hasQrcode,
    "qrcode": qrcode,
    "send_date": sendDate,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "password": password,
    "user_id": userId,
    "status": status,
    "step": step,
    "invitees": List<dynamic>.from(invitees.map((x) => x.toJson())),
    "messages": messages,
    "invitees_count": inviteesCount,
    "scanned": scanned,
    "confirmed": confirmed,
    "apologized": apologized,
    "waiting": waiting,
    "not_sent": notSent,
    "failed": failed,
  };
}

class Invitee {
  int id;
  int invitationId;
  String name;
  dynamic email;
  String phone;
  int inviteesNumber;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  bool isselected=false;

  Invitee({
    required this.id,
    required this.invitationId,
    required this.name,
    this.email,
    required this.phone,
    required this.inviteesNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Invitee.fromJson(Map<String, dynamic> json) => Invitee(
    id: json["id"],
    invitationId: json["invitation_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    inviteesNumber: json["invitees_number"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invitation_id": invitationId,
    "name": name,
    "email": email,
    "phone": phone,
    "invitees_number": inviteesNumber,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
