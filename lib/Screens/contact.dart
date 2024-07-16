import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallsScreen extends StatelessWidget {
  final String contactNumber = '8376049497';
  final String email = 'piyushbhardwaj1603@gmail.com';
  final String linkedInUrl =
      'https://www.linkedin.com/in/piyush-bhardwaj-flutter';
  final String githubUrl = 'https://github.com/Piyu-Pika';
  final String whatsappNumber = '+91 8376049497';

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Contact', style: TextStyle(color: Colors.white)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple, Colors.blue],
                  ),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: max(0, 100),
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                _buildContactCard(
                  icon: Icons.phone,
                  title: 'Phone',
                  subtitle: contactNumber,
                  onTap: () => _launchUrl('tel://$contactNumber'),
                ),
                _buildContactCard(
                  icon: Icons.email,
                  title: 'Email',
                  subtitle: email,
                  onTap: () => _launchUrl('mailto:$email'),
                ),
                _buildContactCard(
                  icon: Icons.language,
                  title: 'LinkedIn',
                  subtitle: 'View Profile',
                  onTap: () => _launchUrl(linkedInUrl),
                ),
                _buildContactCard(
                  icon: Icons.code,
                  title: 'GitHub',
                  subtitle: 'Check Projects',
                  onTap: () => _launchUrl(githubUrl),
                ),
                _buildContactCard(
                  icon: Icons.chat,
                  title: 'WhatsApp',
                  subtitle: whatsappNumber,
                  onTap: () => _launchUrl('https://wa.me/$whatsappNumber'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle()),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
