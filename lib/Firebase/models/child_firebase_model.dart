import 'dart:convert';

class ChildHistoryFirebaseModel {
  String? id;
  String? name;
  int? age;
  double? weight;
  double? height;
  double? imt;
  double? head;
  String? createdAt;

  ChildHistoryFirebaseModel({
    this.id,
    this.name,
    this.age,
    this.weight,
    this.height,
    this.imt,
    this.head,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'imt': imt,
      'head': head,
      'createdAt': createdAt,
    };
  }

  factory ChildHistoryFirebaseModel.fromMap(Map<String, dynamic> map) {
    return ChildHistoryFirebaseModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      weight: map['weight']?.toDouble(),
      height: map['height']?.toDouble(),
      imt: map['imt']?.toDouble(),
      head: map['head']?.toDouble(),
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChildHistoryFirebaseModel.fromJson(String source) =>
      ChildHistoryFirebaseModel.fromMap(json.decode(source));
}
