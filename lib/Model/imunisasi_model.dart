class Imunisasi {
  final int id;
  final String name;
  final int ageMonth;
  final DateTime date;
  // final ImunisasiStatus status;
  bool reminder;
  bool completed;
  // final completedList = Imunisasi.where((i) => i.completed).toList();


  Imunisasi({
    required this.id,
    required this.name,
    required this.ageMonth,
    required this.date,
    // required this.status,
    required this.reminder,
    required this.completed
  });

  ImunisasiStatus get status {
    final today = DateTime.now();
    final cleanToday = DateTime(
      today.year,
      today.month,
      today.day,
    ); // normalize

    if (date.isBefore(today)) {
      return ImunisasiStatus.overdue;
    } else if (date.isAfter(today)) {
      return ImunisasiStatus.upcoming;
    } else {
      return ImunisasiStatus.completed;
    }
  }
}
// ImunisasiStatus get status {
//   final today = DateTime.now();
//   if (DateTime.isBefore(DateTime(today.day, today.month, today.year))) {
//     return ImunisasiStatus.overdue;
//   } else if (DateTime.isAfter(DateTime(today.day, today.month, today.year))) {
//     return ImunisasiStatus.completed;
//   } else {
//     return ImunisasiStatus.upcoming;
//   }
// }

// Enum
enum ImunisasiStatus { completed, upcoming, overdue }
