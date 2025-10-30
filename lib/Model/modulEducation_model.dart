// Model Classes
class Module {
  final int id;
  final String title;
  final String duration;
  final bool completed;
  final ModuleType type;

  Module({
    required this.id,
    required this.title,
    required this.duration,
    required this.completed,
    required this.type,
  });
}

class FAQ {
  final String question;
  final String answer;

  FAQ({
    required this.question,
    required this.answer,
  });
}

// Enum
enum ModuleType {
  video,
  article,
}