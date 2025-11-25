import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserFirebaseModel {
  String? uid;
  String? fullname;
  String? email;
  String? phonenumber;
  String? createdAt;
  String? updatedAt;
  UserFirebaseModel({
    this.uid,
    this.fullname,
    this.email,
    this.phonenumber,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'phonenumber': phonenumber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UserFirebaseModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,      
      phonenumber: map['phonenumber'] != null ? map['phonenumber'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFirebaseModel.fromJson(String source) => UserFirebaseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
