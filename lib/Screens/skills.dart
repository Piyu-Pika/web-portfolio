import 'dart:math';
import 'package:flutter/material.dart';

class RotatingSkillsWheel extends StatefulWidget {
  @override
  _RotatingSkillsWheelState createState() => _RotatingSkillsWheelState();
}

class _RotatingSkillsWheelState extends State<RotatingSkillsWheel> {
  double _rotation = 0.0;

  final List<Map<String, String>> skillsData = [
    {"asset": "assets/images/as.png", "name": "Android Studio"},
    {"asset": "assets/images/Pyt.png", "name": "Python"},
    {"asset": "assets/images/vsc.png", "name": "VS Code"},
    {"asset": "assets/images/flt.png", "name": "Flutter"},
    {"asset": "assets/images/C++.png", "name": "C++"},
    {"asset": "assets/images/fb.png", "name": "Firebase"},
    {"asset": "assets/images/dt.png", "name": "Dart"},
    {"asset": "assets/images/c.png", "name": "C"},
    {"asset": "assets/images/gh.png", "name": "GitHub"},
  ];

  void _rotateWheel(DragUpdateDetails details) {
    setState(() {
      _rotation += details.delta.dx * 0.01;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('My Skills Wheel',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: GestureDetector(
        onPanUpdate: _rotateWheel,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(skillsData.length, (index) {
                final angle = 2 * pi * index / skillsData.length + _rotation;
                final radius = 140.0;
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(radius * cos(angle), radius * sin(angle)),
                  child: SkillCard(
                    imageAsset: skillsData[index]["asset"]!,
                    skillName: skillsData[index]["name"]!,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String imageAsset;
  final String skillName;

  const SkillCard({
    Key? key,
    required this.imageAsset,
    required this.skillName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageAsset, width: 50, height: 50),
          SizedBox(height: 4),
          Text(
            skillName,
            style: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
