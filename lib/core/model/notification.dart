class NotificationDataModel {
  List<NotificationModel> data;
  String message;
  int code;

  NotificationDataModel({
    required this.data,
    required this.message,
    required this.code,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) => NotificationDataModel(
    data: List<NotificationModel>.from(json["data"].map((x) => NotificationModel.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class NotificationModel {
  int id;
  String title;
  String body;
  String image;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "image": image,
  };
}
