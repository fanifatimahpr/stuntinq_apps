import 'package:cloud_firestore/cloud_firestore.dart';

class ChildBirthModel {
  final String uid;          // ID user
  final DateTime birthDate;  // tanggal lahir anak

  ChildBirthModel({
    required this.uid,
    required this.birthDate,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "birthDate": Timestamp.fromDate(birthDate),
    };
  }

  factory ChildBirthModel.fromMap(Map<String, dynamic> map) {
    return ChildBirthModel(
      uid: map['uid'],
      birthDate: (map['birthDate'] as Timestamp).toDate(),
    );
  }
}
