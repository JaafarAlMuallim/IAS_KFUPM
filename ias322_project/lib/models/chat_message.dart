// export const chatMessages = pgTable("chat_messages", {
//   chat_messages_id: uuid("chat_messages_id")
//     .primaryKey()
//     .default(sql`gen_random_uuid()`),
//   message: text("message").notNull(),
//   chat_id: uuid("chat_id")
//     .notNull()
//     .references(() => chat.chat_id),
//   created_at: date("created_at")
//     .notNull()
//     .default(sql`now()`),
//   role: roleEnum("role").notNull().default("user"),
// });

class ChatMessage {
  String chatMessagesId;
  String message;
  String chatId;
  DateTime createdAt;
  String role;

  ChatMessage({
    required this.chatMessagesId,
    required this.message,
    required this.chatId,
    required this.createdAt,
    required this.role,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      chatMessagesId: json['chat_messages_id'],
      message: json['message'],
      chatId: json['chat_id'],
      createdAt: DateTime.parse(json['created_at']),
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_messages_id': chatMessagesId,
      'message': message,
      'chat_id': chatId,
      'created_at': createdAt.toIso8601String(),
      'role': role,
    };
  }
}
