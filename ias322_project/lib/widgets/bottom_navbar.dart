import 'package:flutter/material.dart';
import 'package:ias322_project/app_routes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  static int _selectedIndex = 4;
  static reset() {
    _selectedIndex = 4;
  }

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final int _currentIndex = BottomNavBar._selectedIndex;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ThemeData.light().colorScheme.primaryContainer,
      elevation: 0,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconBottomBar(
              icon: Icons.account_circle,
              selected: BottomNavBar._selectedIndex == 0,
              onPressed: () {
                setState(
                  () {
                    if (_currentIndex != 0) {
                      Navigator.popAndPushNamed(
                          context, AppRoutes.profileScreen);
                      BottomNavBar._selectedIndex = 0;
                    }
                  },
                );
              },
            ),
            IconBottomBar(
              icon: Icons.group,
              selected: BottomNavBar._selectedIndex == 1,
              onPressed: () {
                setState(
                  () {
                    if (_currentIndex != 1) {
                      Navigator.popAndPushNamed(
                          context, AppRoutes.communityScreen);
                      BottomNavBar._selectedIndex = 1;
                    }
                  },
                );
              },
            ),
            IconBottomBar(
                icon: Icons.chat,
                selected: _currentIndex == 2,
                onPressed: () {
                  setState(() {
                    if (_currentIndex != 2) {
                      Navigator.popAndPushNamed(context, AppRoutes.chatScreen);
                      BottomNavBar._selectedIndex = 2;
                    }
                  });
                }),
            IconBottomBar(
              icon: Icons.bar_chart,
              selected: _currentIndex == 3,
              onPressed: () {
                setState(
                  () {
                    if (_currentIndex != 3) {
                      Navigator.popAndPushNamed(
                          context, AppRoutes.trackerScreen);
                      BottomNavBar._selectedIndex = 3;
                    }
                  },
                );
              },
            ),
            IconBottomBar(
              icon: Icons.newspaper,
              selected: _currentIndex == 4,
              onPressed: () {
                setState(
                  () {
                    if (_currentIndex != 4) {
                      // _auth.signOut();
                      Navigator.popAndPushNamed(
                          context, AppRoutes.adviceScreen);
                      BottomNavBar._selectedIndex = 4;
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {super.key,
      required this.icon,
      required this.selected,
      required this.onPressed});
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      IconButton(
          onPressed: onPressed,
          icon: Icon(icon,
              size: 40,
              color: selected
                  ? ThemeData.light().colorScheme.primary
                  : ThemeData.light().colorScheme.secondary)),
    ]);
  }
}
