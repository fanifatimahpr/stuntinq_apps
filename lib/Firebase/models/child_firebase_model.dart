import 'package:cloud_firestore/cloud_firestore.dart';

class ChildHistoryFirebaseModel {
  final String? id;
  final String uid;
  final String name;
  final int age;
  final double weight;
  final double height;
  final double imt;
  final double head;
  final DateTime createdAt;


  ChildHistoryFirebaseModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.imt,
    required this.head,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "name": name,
      "age": age,
      "weight": weight,
      "height": height,
      "imt": imt,
      "head": head,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }

  factory ChildHistoryFirebaseModel.fromMap(Map<String, dynamic> map) {
  return ChildHistoryFirebaseModel(
    id: map["id"],
    uid: map["uid"] ?? "",
    name: map["name"] ?? "",
    age: map["age"] ?? 0,
    weight: (map["weight"] as num?)?.toDouble() ?? 0,
    height: (map["height"] as num?)?.toDouble() ?? 0,
    imt: (map["imt"] as num?)?.toDouble() ?? 0,
    head: (map["head"] as num?)?.toDouble() ?? 0,
    createdAt: (map["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
  );
}


}
