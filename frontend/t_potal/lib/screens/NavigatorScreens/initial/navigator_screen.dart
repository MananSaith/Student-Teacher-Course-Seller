import 'package:flutter/material.dart';
import 'package:t_potal/constant/colorclass.dart';

import '../ChatScreen/ChatScreenList.dart';
import '../homeScreen/homescreen.dart';
import '../video call/video_screen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
    const Homescreen(),
    const ZIMKitDemoHomePage(),
    CallPageScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.bgPallet,
        currentIndex: _currentIndex, // Highlight the current tab
        onTap: _onTabTapped, // Update the index on tab change
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Video',
          ),
        ],
      ),
    );
  }
}
