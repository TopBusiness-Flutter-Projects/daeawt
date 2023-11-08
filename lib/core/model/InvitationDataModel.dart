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
  String share_link;
  dynamic qrcode;
  String sendDate;
  String address;
  String longitude;
  String latitude;
  String password;
  dynamic userId;
  dynamic status;
  int step;
  List<Invitee> invitees;
  List<Invitee> all_messages;
  List<Invitee> invitees_messages;
  List<Invitee> all_confirmed;
  List<Invitee> all_scanned;
  List<Invitee> all_waiting;
  List<Invitee> all_apologized;
  List<Invitee> all_failed;
  List<Invitee> all_not_sent;
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
    required this.share_link,
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
    required this.all_apologized,
    required this.all_confirmed,
    required this.all_failed,
    required this.all_messages,
    required this.invitees_messages,
    required this.all_not_sent,
    required this.all_scanned,
    required this.all_waiting,
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
    share_link: json["share_link"],
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
    all_waiting: List<Invitee>.from(json["all_waiting"].map((x) => Invitee.fromJson(x))),
    all_apologized: List<Invitee>.from(json["all_apologized"].map((x) => Invitee.fromJson(x))),
    all_confirmed: List<Invitee>.from(json["all_confirmed"].map((x) => Invitee.fromJson(x))),
    all_failed: List<Invitee>.from(json["all_failed"].map((x) => Invitee.fromJson(x))),
    all_messages: List<Invitee>.from(json["all_messages"].map((x) => Invitee.fromJson(x))),
    invitees_messages: List<Invitee>.from(json["invitees_messages"].map((x) => Invitee.fromJson(x))),
    all_not_sent: List<Invitee>.from(json["all_not_sent"].map((x) => Invitee.fromJson(x))),
    all_scanned: List<Invitee>.from(json["all_scanned"].map((x) => Invitee.fromJson(x))),
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
    "share_link": share_link,
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
    "all_waiting": List<dynamic>.from(all_waiting.map((x) => x.toJson())),
    "all_scanned": List<dynamic>.from(all_scanned.map((x) => x.toJson())),
    "all_not_sent": List<dynamic>.from(all_not_sent.map((x) => x.toJson())),
    "all_messages": List<dynamic>.from(all_messages.map((x) => x.toJson())),
    "invitees_messages": List<dynamic>.from(invitees_messages.map((x) => x.toJson())),
    "all_confirmed": List<dynamic>.from(all_confirmed.map((x) => x.toJson())),
    "all_failed": List<dynamic>.from(all_failed.map((x) => x.toJson())),
    "all_apologized": List<dynamic>.from(all_apologized.map((x) => x.toJson())),
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
  List<Message> messages;
  int id;
  int invitationId;
  String name;
  dynamic email;
  String phone;
  int inviteesNumber;
  int status;
  String createdAt;
  String updatedAt;

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
    required this.messages,
  });

  factory Invitee.fromJson(Map<String, dynamic> json) => Invitee(
    id: json["id"],
    invitationId: json["invitation_id"],
    name: json["name"]??'',
    email: json["email"]??'',
    phone: json["phone"]??'',
    inviteesNumber: json["invitees_number"]??0,
    status: json["status"]??0,
    createdAt: json["created_at"]??'18-04-2020',
    updatedAt: json["updated_at"]??'18-04-2020',
    messages:json["messages"]!=null? List<Message>.from(json["messages"].map((x) => Message.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invitation_id": invitationId,
    "name": name,
    "email": email,
    "phone": phone,
    "invitees_number": inviteesNumber,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}
class Message {
  int id;
  int invitationId;
  int inviteeId;
  String title;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  Message({
    required this.id,
    required this.invitationId,
    required this.inviteeId,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    invitationId: json["invitation_id"],
    inviteeId: json["invitee_id"],
    title: json["title"],
    message: json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invitation_id": invitationId,
    "invitee_id": inviteeId,
    "title": title,
    "message": message,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
