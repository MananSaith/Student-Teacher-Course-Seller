// lib/models/quiz_model.dart

class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
    );
  }
}

class Quiz {
  final String title;
  final String courseId;
  final List<Question> questions;

  Quiz({
    required this.title,
    required this.courseId,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      title: json['title'],
      courseId: json['courseId'],
      questions: List<Question>.from(
          json['questions'].map((x) => Question.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'courseId': courseId,
      'questions': questions
          .map((x) => {
                'question': x.question,
                'options': x.options,
                'correctAnswer': x.correctAnswer,
              })
          .toList(),
    };
  }
}
