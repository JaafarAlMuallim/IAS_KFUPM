import 'package:ias322_project/models/chat_message.dart';

class Chat {
  String chatId;
  String userId;
  DateTime createdAt;
  List<ChatMessage>? messages = [];

  Chat({
    required this.chatId,
    required this.userId,
    required this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chat_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chatId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
