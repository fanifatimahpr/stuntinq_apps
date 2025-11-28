class ImunisasiFirebaseModel {
  final int id;
  final String name;
  final int ageMonth;
  final DateTime date;
  final bool completed;

  ImunisasiFirebaseModel({
    required this.id,
    required this.name,
    required this.ageMonth,
    required this.date,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ageMonth': ageMonth,
      'date': date.toIso8601String(),
      'completed': completed,
    };
  }

  factory ImunisasiFirebaseModel.fromJson(Map<String, dynamic> json) {
    return ImunisasiFirebaseModel(
      id: json['id'],
      name: json['name'],
      ageMonth: json['ageMonth'],
      date: DateTime.parse(json['date']),
      completed: json['completed'] ?? false,
    );
  }
}
