class NotificationModel {
  String uid;
  String deviceToken;
  String email;
  String name;
  String phone;

  NotificationModel({
    required this.uid,
    required this.deviceToken,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      uid: json["uid"],
      deviceToken: json["deviceToken"],
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "deviceToken": deviceToken,
      "email": email,
      "name": name,
      "phone": phone,
    };
  }
}
