import 'package:flutter/material.dart';
import 'package:ias322_project/screens/advice_screen.dart';
import 'package:ias322_project/screens/chat_screen.dart';
import 'package:ias322_project/screens/community_screen.dart';
import 'package:ias322_project/screens/login_screen.dart';
import 'package:ias322_project/screens/profile_screen.dart';
import 'package:ias322_project/screens/signup_screen.dart';
import 'package:ias322_project/screens/tracker_screen.dart';

class AppRoutes {
  static const String signUpScreen = '/signup_screen';
  static const String loginScreen = '/login_screen';
  static const String homeScreen = '/home_screen';
  static const String adviceScreen = '/advice_screen';
  static const String trackerScreen = '/tracker_screen';
  static const String communityScreen = '/community_screen';
  static const String chatScreen = '/chat_screen';
  static const String profileScreen = '/profile_screen';

  static Map<String, WidgetBuilder> routes = {
    signUpScreen: (context) => const SignUpScreen(),
    loginScreen: (context) => const LoginScreen(),
    adviceScreen: (context) => const AdviceScreen(),
    trackerScreen: (context) => const TrackerScreen(),
    communityScreen: (context) => const CommunityScreen(),
    chatScreen: (context) => const ChatScreen(),
    profileScreen: (context) => const ProfileScreen(),
  };
}
