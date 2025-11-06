import 'package:stuntinq_apps/Model/edukasi_model.dart';

// Class Model untuk Sumber Nutrisi
class NutritionSource {
  final String id;
  final String name;
  final String portion;
  final DateTime dateAdded;

  NutritionSource({
    required this.id,
    required this.name,
    required this.portion,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'portion': portion,
      'dateAdded': dateAdded.toIso8601String(), // ubah ke String saat disimpan
    };
  }

  factory NutritionSource.fromMap(Map<String, dynamic> map) {
    return NutritionSource(
      id: map['id'],
      name: map['name'],
      portion: map['portion'],
      dateAdded: DateTime.parse(map['dateAdded']), // ubah ke DateTime saat dibaca
    );
  }
}


// Class Model untuk Anak
class ChildData {
  String id;
  String name;
  int age;
  double weight;
  double height;
  double headCircumference;
  String gender;

  ChildData({
    required this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.headCircumference,
    required this.gender,
  });
}

