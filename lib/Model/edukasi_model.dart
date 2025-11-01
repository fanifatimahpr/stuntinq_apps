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

//Class Question
class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

// Enum
enum EducationType { video, article }
