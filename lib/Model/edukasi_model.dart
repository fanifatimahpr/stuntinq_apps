class Education {
  final int id;
  final String title;
  final String duration;
  final bool completed;
  final EducationType type;

  Education({
    required this.id,
    required this.title,
    required this.duration,
    required this.completed,
    required this.type,
  });
}
List<Education> modul = [
    Education(
      id: 1,
      title: 'Apa Itu Stunting?',
      duration: '5 menit',
      completed: true,
      type: EducationType.video,
    ),
    Education(
      id: 2,
      title: 'Penyebab Stunting',
      duration: '7 menit',
      completed: true,
      type: EducationType.article,
    ),
    Education(
      id: 3,
      title: 'Nutrisi untuk Mencegah Stunting',
      duration: '10 menit',
      completed: false,
      type: EducationType.video,
    ),
    Education(
      id: 4,
      title: '1000 Hari Pertama Kehidupan',
      duration: '8 menit',
      completed: false,
      type: EducationType.article,
    ),
    Education(
      id: 5,
      title: 'Resep MPASI Bergizi',
      duration: '12 menit',
      completed: false,
      type: EducationType.video,
    ),
  ];

//Class Question
class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

// Enum
enum EducationType { video, article }

//Model Class untuk sumber nutrisi
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

/// Model Class untuk Keluhan
class HealthComplaint {
  final String id;
  final String complaint;
  final String severity; // Ringan, Sedang, Berat
  final DateTime dateAdded;

  HealthComplaint({
    required this.id,
    required this.complaint,
    required this.severity,
    required this.dateAdded,
  });
}