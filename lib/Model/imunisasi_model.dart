class Imunisasi {
  final int id;
  final String name;
  final int ageMonth;
  final String date;
  final ImunisasiStatus status;
  bool reminder;

  Imunisasi({
    required this.id,
    required this.name,
    required this.ageMonth,
    required this.date,
    required this.status,
    required this.reminder,
  });
}

// Enum
enum ImunisasiStatus { completed, upcoming, overdue }
