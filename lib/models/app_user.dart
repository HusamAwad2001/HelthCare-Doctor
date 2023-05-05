class AppUser {
  String? id;
  String firstName;
  String secondName;
  String familyName;
  String email;
  String phone;
  String address;
  String birthDate;
  String password;

  AppUser({
    this.id,
    required this.firstName,
    required this.secondName,
    required this.familyName,
    required this.email,
    required this.phone,
    required this.address,
    required this.birthDate,
    required this.password,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json["id"],
      firstName: json["firstName"],
      secondName: json["secondName"],
      familyName: json["familyName"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      birthDate: json["birthDate"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "secondName": secondName,
      "familyName": familyName,
      "email": email,
      "phone": phone,
      "address": address,
      "birthDate": birthDate,
      "password": password,
    };
  }
}
