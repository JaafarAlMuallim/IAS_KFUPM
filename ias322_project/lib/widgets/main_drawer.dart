import 'package:flutter/material.dart';
import 'package:ias322_project/models/chat.dart';
import 'package:ias322_project/network/api_client.dart';
import 'package:ias322_project/screens/chat_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  List<Chat> chats = [];
  bool _loading = false;
  getChats() async {
    setState(() {
      _loading = true;
    });
    ApiClient apiClient = ApiClient();
    final response = await apiClient.getChats();
    print(response);
    response.forEach((chat) {
      chats.add(Chat.fromJson(chat));
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.chat,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Text(
                  'المحادثات السابقة',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
        _loading
            ? const Center(child: CircularProgressIndicator())
            : chats.isEmpty
                ? const Center(child: Text('لا توجد محادثات سابقة'))
                : Expanded(
                    child: ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(
                                "المحادثة ${(index + 1).toString()}",
                                textAlign: TextAlign.end,
                              ),
                              onTap: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          chatId: chats[index].chatId)),
                                  (route) => false));
                        }),
                  )
      ]),
    );
  }
}
