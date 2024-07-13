import 'package:flutter/material.dart';
import 'Screens/myprofile.dart';
import 'Screens/contact.dart';
import 'Screens/potfolio.dart';
import 'Screens/skills.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ProjectUI(),
    RotatingSkillsWheel(),
    ProfileScreen(),
    CallsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor:
            Colors.deepPurpleAccent, // Change the selected item color here
        unselectedItemColor:
            Colors.grey, // Change the unselected item color here
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'My Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Contact Me',
          ),
        ],
      ),
    );
  }
}
