import 'package:flutter/material.dart';
import 'package:ias322_project/models/message.dart';
import 'package:ias322_project/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.messages});
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: messages
            .map((message) => MessageBubble(
                  message: message.message,
                  isMe: message.isMe,
                ))
            .toList());
  }
}
