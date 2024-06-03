import 'package:ias322_project/models/answer.dart';

class Question {
  String questionId;
  String question;
  DateTime createdAt;
  String userId;
  List<Answer> answers = [];

  Question({
    required this.questionId,
    required this.question,
    required this.createdAt,
    required this.userId,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      question: json['question'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'question': question,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
    };
  }
}
