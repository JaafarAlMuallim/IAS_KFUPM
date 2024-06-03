// export const answer = pgTable("answer", {
//   answer_id: uuid("answer_id")
//     .primaryKey()
//     .default(sql`gen_random_uuid()`),
//   answer: varchar("answer", { length: 255 }).notNull(),
//   question_id: uuid("question_id")
//     .notNull()
//     .references(() => question.question_id),
//   created_at: date("created_at")
//     .notNull()
//     .default(sql`now()`),
//   user_id: uuid("user_id")
//     .notNull()
//     .references(() => user.user_id),
// });

class Answer {
  String answerId;
  String answer;
  String questionId;
  DateTime createdAt;
  String userId;

  Answer({
    required this.answerId,
    required this.answer,
    required this.questionId,
    required this.createdAt,
    required this.userId,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerId: json['answer_id'],
      answer: json['answer'],
      questionId: json['question_id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer_id': answerId,
      'answer': answer,
      'question_id': questionId,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
    };
  }
}
