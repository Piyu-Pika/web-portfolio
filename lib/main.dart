import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:portfolio/ai_bot.dart';
import 'package:portfolio/code.dart';
import 'Screens/myprofile.dart';
import 'Screens/contact.dart';
import 'Screens/potfolio.dart';
import 'Screens/skills.dart';
import 'dart:js' as js;

void main() {
  String apiKey = js.context['ENV']['GEMINI_API_KEY'];
  Gemini.init(apiKey: apiKey);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const HomePage(
      {super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      ProjectUI(),
      RotatingSkillsWheel(),
      ProfileScreen(),
      CallsScreen(),
    ];
  }

  void _openaiassistent() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MyAiScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
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
      floatingActionButton: FloatingActionButton(
          onPressed: _openaiassistent, child: Icon(Icons.adb)),
    );
  }
}
