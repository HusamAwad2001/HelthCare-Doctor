class UserView {
  String uid;
  String name;
  String email;
  String phone;
  var dateTime;

  UserView({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.dateTime,
  });


  factory UserView.fromJson(Map<String, dynamic> json) {
    return UserView(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      dateTime: json["dateTime"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "dateTime": dateTime,
    };
  }
}
