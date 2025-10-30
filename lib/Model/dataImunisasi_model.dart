// Model Class
class Immunization {
  final int id;
  final String name;
  final int ageMonth;
  final String date;
  final ImmunizationStatus status;
  bool reminder;

  Immunization({
    required this.id,
    required this.name,
    required this.ageMonth,
    required this.date,
    required this.status,
    required this.reminder,
  });
}

// Enum
enum ImmunizationStatus {
  completed,
  upcoming,
  overdue,
}