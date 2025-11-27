import 'package:cloud_firestore/cloud_firestore.dart';

class NutritionSourceFirebaseModel {
  final String id;          
  final String uid;          
  final String name;
  final String portion;
  final DateTime dateAdded;

  NutritionSourceFirebaseModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.portion,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uid": uid,
      "name": name,
      "portion": portion,
      "dateAdded": Timestamp.fromDate(dateAdded),
    };
  }

  factory NutritionSourceFirebaseModel.fromMap(Map<String, dynamic> map) {
    return NutritionSourceFirebaseModel(
      id: map['id'] ?? "",          
      uid: map['uid'] ?? "",
      name: map['name'] ?? "",
      portion: map['portion'] ?? "",
      dateAdded: (map['dateAdded'] as Timestamp).toDate(),
    );
  }
}
