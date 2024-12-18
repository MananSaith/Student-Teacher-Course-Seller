import 'package:flutter/material.dart';
import '../../constant/colorclass.dart';
import 'ChatScreen/ChatScreenList.dart';
import 'HomeScreen/homescreen.dart';
import 'ai chat/ai_chat.dart';
import 'enrolledCourseByStd/enrolled_course.dart';
import 'free course/free_course_list_screen.dart';
import 'video call/video_screen.dart';

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
    const EnrolledCourse(),
    const ZIMKitDemoHomePage(),
    CallPageScreen(),
    AiChatScreen(),
    const CourseListScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent the bottom nav bar from being pushed up
      body: GestureDetector(
        onTap: () {
          // Dismiss the keyboard when tapping outside the text fields
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
                child: _screens[_currentIndex]), // Display the selected screen
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: MyColors.bgPallet,
        currentIndex: _currentIndex, // Highlight the current tab
        onTap: _onTabTapped, // Update the index on tab change
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'You',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Free',
          ),
        ],
      ),
    );
  }
}
