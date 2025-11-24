class ChildHistoryModel {
  final int? id;
  final String name;
  final int age;
  final double weight;
  final double height;
  final double imt;
  final double head;
  final DateTime createdAt;

  ChildHistoryModel({
    this.id,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.imt,
    required this.head,
    required this.createdAt,
  });

  factory ChildHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChildHistoryModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      weight: json['weight'],
      height: json['height'],
      imt: json['imt'],
      head: json['head'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'imt': imt,
      'head': head,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
