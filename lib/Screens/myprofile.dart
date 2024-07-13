import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text('My Profile',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue[700],
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Piyush Bhardwaj",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Flutter Developer | Computer Science Student",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("About Me"),
                    _buildText(
                      "A passionate Flutter app developer pursuing B.Tech in Computer Science from Chaudhary Charan Singh University. Expanding skills in Flutter, Dart, and Firebase for app development. Also proficient in Python, C, and C++.",
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Education"),
                    _buildEducationItem(
                      "Bachelor of Technology (Computer Science)",
                      "Chaudhary Charan Singh University, Meerut",
                      "June 2022 - August 2026",
                    ),
                    _buildEducationItem(
                      "High School & Intermediate",
                      "Modern School, Vaishali",
                      "June 2020 - August 2022",
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Skills"),
                    _buildSkillsSection(),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Certifications"),
                    _buildCertificationItem("C++ (Letsupgrade)"),
                    _buildCertificationItem("Python (GUVI)"),
                    _buildCertificationItem("AI for India 2.0 (GUVI)"),
                    _buildCertificationItem(
                        "Introduction to Flutter (CareerNinja)"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue[700]),
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildEducationItem(String degree, String school, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(degree,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(school, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Text(duration,
              style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    final skills = [
      "Flutter",
      "Dart",
      "Firebase",
      "Python",
      "C",
      "C++",
      "SQL",
      "Android SDK",
      "Git",
      "GitHub"
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills
          .map((skill) => Chip(
                label: Text(skill),
                backgroundColor: Colors.blue[100],
                labelStyle: TextStyle(color: Colors.blue[800]),
              ))
          .toList(),
    );
  }

  Widget _buildCertificationItem(String certification) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 8),
          Text(certification, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
