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
      dateAdded: DateTime.parse(
        map['dateAdded'],
      ), // ubah ke DateTime saat dibaca
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

//Lingkar Kepala Ideal (WHO)
// Laki-laki
final Map<int, double> headCircumferenceBoys = {
  0: 34.5,
  1: 35.4,
  2: 36.3,
  3: 37.0,
  4: 37.6,
  5: 38.2,
  6: 38.7,
  7: 39.2,
  8: 39.6,
  9: 40.0,
  10: 40.4,
  11: 40.8,
  12: 41.2,
  18: 42.1,
  24: 42.8,
  36: 44.0,
  48: 45.1,
  60: 46.0,
};

// Perempuan
final Map<int, double> headCircumferenceGirls = {
  0: 33.9,
  1: 34.8,
  2: 35.6,
  3: 36.3,
  4: 36.9,
  5: 37.5,
  6: 38.0,
  7: 38.5,
  8: 39.0,
  9: 39.5,
  10: 39.9,
  11: 40.3,
  12: 40.6,
  18: 41.5,
  24: 42.2,
  36: 43.4,
  48: 44.5,
  60: 45.3,
};

final Map<String, Map<int, double>> headCircumference = {
  'Laki-Laki': headCircumferenceBoys,
  'Perempuan': headCircumferenceGirls,
};
