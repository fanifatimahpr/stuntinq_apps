import 'package:stuntinq_apps/Model/edukasi_model.dart';

List<NutritionSource> _nutritionSources = [
    NutritionSource(
      id: '1',
      name: 'Nasi Putih',
      portion: '1 mangkok',
      dateAdded: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NutritionSource(
      id: '2',
      name: 'Telur Rebus',
      portion: '1 butir',
      dateAdded: DateTime.now(),
    ),
  ];

  List<HealthComplaint> _healthComplaints = [
    HealthComplaint(
      id: '1',
      complaint: 'Nafsu makan berkurang',
      severity: 'Ringan',
      dateAdded: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
  
