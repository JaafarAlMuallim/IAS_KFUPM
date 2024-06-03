class QuestionDB {
  String? questionId;
  String title;
  String question;
  String photo;
  int answers;
  int views;
  DateTime date = DateTime.now();
  QuestionDB({
    this.questionId,
    required this.title,
    required this.question,
    this.photo = "assets/default.png",
    this.answers = 0,
    this.views = 0,
  });
  factory QuestionDB.fromJson(Map<String, dynamic> json) {
    return QuestionDB(
      questionId: json['question_id'],
      title: json['title'],
      question: json['question'],
    );
  }
}
