import 'dart:convert';

class UserModel {
  int? id;
  String? fullname;
  String? email;
  String? phonenumber;
  String? password;

  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.phonenumber,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'phonenumber': phonenumber,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phonenumber: map['phonenumber'] != null
          ? map['phonenumber'] as String
          : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
