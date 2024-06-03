import 'package:flutter/material.dart';
import 'package:ias322_project/models/message.dart';
import 'package:ias322_project/models/message_db.dart';
import 'package:ias322_project/network/api_client.dart';
import 'package:ias322_project/widgets/bottom_navbar.dart';
import 'package:ias322_project/widgets/chat_messages.dart';
import 'package:ias322_project/widgets/main_drawer.dart';
import 'package:ias322_project/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.chatId});
  final String? chatId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool? _loading;
  String? chatId;
  List<Message> messages = [
    Message(
      message:
          'أهلا بكم في الاستشارات الخاصة بالذكاء الاصطناعي، كيف يمكنني مساعدتك؟',
      isMe: false,
    ),
  ];
  ApiClient apiClient = ApiClient();
  addMsgToList(String message, bool isMe) {
    setState(() {
      messages.add(Message(message: message, isMe: isMe));
    });
  }

  getChatMessages() async {
    if (widget.chatId != null) {
      chatId = widget.chatId;
      setState(() {
        _loading = true;
      });
      final response = await apiClient.getMessages(widget.chatId!);
      response.forEach((message) {
        final msg = MessageDB.fromJson(message);
        messages.add(Message(
          message: msg.message,
          isMe: msg.role == 'user',
        ));
      });
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = true;
      });
      final response = await apiClient.createChat();
      chatId = response;

      setState(() {
        _loading = false;
      });
    }
  }

  void addMessage(String message) async {
    addMsgToList(message, true);
    setState(() {
      _loading = true;
    });
    final response = await apiClient.sendMessage(chatId!, message);
    setState(() {
      _loading = false;
    });
    addMsgToList(response["message"], false);
  }

  @override
  void initState() {
    getChatMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.background,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        shadowColor: ThemeData.light().shadowColor,
        backgroundColor: ThemeData.light().colorScheme.primaryContainer,
        elevation: 4.0,
        title: Center(
          child: Text(
            'استشارات الذكاء الاصطناعي',
            style: TextStyle(
              color: ThemeData.light().colorScheme.onBackground,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Expanded(
                child: ChatMessages(messages: messages),
              ),
            ),
            NewMessage(onSend: addMessage),
          ],
        ),
      ),
      drawer: const MainDrawer(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
