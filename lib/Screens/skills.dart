import 'dart:math';
import 'package:flutter/material.dart';

class RotatingSkillsWheel extends StatefulWidget {
  @override
  _RotatingSkillsWheelState createState() => _RotatingSkillsWheelState();
}

class _RotatingSkillsWheelState extends State<RotatingSkillsWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _startRotation = 0.0;
  double _endRotation = 0.0;

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rotateWheel(double rotation) {
    setState(() {
      _startRotation = _endRotation;
      _endRotation += rotation;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Skills Wheel',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: Center(
          child: GestureDetector(
            onPanUpdate: (details) {
              _rotateWheel(details.delta.dx * 0.01);
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _startRotation +
                      (_endRotation - _startRotation) * _controller.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(skillsData.length, (index) {
                      final angle = 2 * pi * index / skillsData.length;
                      final radius = 140.0;
                      return Transform.translate(
                        offset:
                            Offset(radius * cos(angle), radius * sin(angle)),
                        child: SkillCard(
                          imageAsset: skillsData[index]["asset"]!,
                          skillName: skillsData[index]["name"]!,
                        ),
                      );
                    }),
                  ),
                );
              },
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
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
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
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
