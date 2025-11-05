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
}

// // Class Model untuk Keluhan
// class HealthComplaint {
//   final String id;
//   final String complaint;
//   final String severity; // Ringan, Sedang, Berat
//   final DateTime dateAdded;

//   HealthComplaint({
//     required this.id,
//     required this.complaint,
//     required this.severity,
//     required this.dateAdded,
//   });
