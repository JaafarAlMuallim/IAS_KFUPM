import 'package:flutter/material.dart';
import 'package:ias322_project/app_routes.dart';
import 'package:ias322_project/network/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.initialize();
  if (LocalStorage.getString(LocalStorageKeys.userId) != null) {
    runApp(const MyApp(firstScreen: AppRoutes.adviceScreen));
  } else {
    runApp(const MyApp(firstScreen: AppRoutes.loginScreen));
  }
}

class MyApp extends StatelessWidget {
  final String firstScreen;

  const MyApp({super.key, required this.firstScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 49, 202, 202)),
          useMaterial3: true),
      title: 'IAS322 Project',
      initialRoute: firstScreen,
      routes: AppRoutes.routes,
    );
  }
}
