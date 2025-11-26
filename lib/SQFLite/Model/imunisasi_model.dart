
class Imunisasi {
  int id;
  String name;
  int ageMonth;
  DateTime date; 
  bool reminder;
  bool completed;
  ImunisasiStatus status; 

  Imunisasi({
    required this.id,
    required this.name,
    required this.ageMonth,
    required this.date,
    this.reminder = false,
    this.completed = false,
    this.status = ImunisasiStatus.upcoming, 
  });
}

// Enum
enum ImunisasiStatus { completed, upcoming, overdue }
