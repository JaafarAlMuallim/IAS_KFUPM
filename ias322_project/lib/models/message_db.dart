class MessageDB {
  final String id;
  final String message;
  final String chatId;
  final String createdAt;
  final String role;
  final String userId;

  MessageDB({
    required this.id,
    required this.message,
    required this.chatId,
    required this.createdAt,
    required this.role,
    required this.userId,
  });

  factory MessageDB.fromJson(Map<String, dynamic> json) {
    return MessageDB(
      id: json['chat_messages_id'],
      message: json['message'],
      chatId: json['chat_id'],
      role: json['role'],
      createdAt: json['created_at'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_message_id': id,
      'message': message,
      "chat_id": chatId,
      "user_id": userId,
      "created_at": createdAt,
      "role": role,
    };
  }
}
