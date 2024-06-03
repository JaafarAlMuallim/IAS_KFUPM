import 'package:flutter/material.dart';
import 'package:ias322_project/app_routes.dart';
import 'package:ias322_project/models/user.dart';
import 'package:ias322_project/network/api_client.dart';
import 'package:ias322_project/utils/style.dart';
import 'package:ias322_project/widgets/bottom_navbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool _loading = false;
  String name = 'GUEST';
  bool loggedIn = false;
  User? user;

  getUser() async {
    ApiClient apiClient = ApiClient();
    final currUser = await apiClient.getUser();
    if (currUser != null) {
      setState(() {
        user = currUser;
      });
    }
  }

  logout() {
    BottomNavBar.reset();
    ApiClient().logout();
    Navigator.popAndPushNamed(context, AppRoutes.loginScreen);
  }

  @override
  void initState() {
    getUser();
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
          backgroundColor: ThemeData.light().colorScheme.primaryContainer,
          elevation: 4.0,
          title: Center(
            child: Text(
              'الملف الشخصي',
              style: TextStyle(
                color: ThemeData.light().colorScheme.onBackground,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: user == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  Container(
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      iconSize: 45,
                                      color: ThemeData.light()
                                          .colorScheme
                                          .onBackground,
                                      icon: const Icon(Icons.logout),
                                      onPressed: () {
                                        logout();
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        const AssetImage('assets/default.png'),
                                    backgroundColor: ThemeData.light()
                                        .colorScheme
                                        .onPrimaryContainer,
                                    radius: 100,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  user!.name,
                                  style: Style.h3.copyWith(
                                    color: ThemeData.light()
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  user!.contactNumber,
                                  style: Style.h3.copyWith(
                                    color: ThemeData.light()
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
        bottomNavigationBar: const BottomNavBar());
  }
}
