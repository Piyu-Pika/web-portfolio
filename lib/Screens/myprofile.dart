import 'package:flutter/material.dart';

class CommunitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/profile.png"),
              ),
              const Text(
                "Piyush Bhardwaj",
              ),
              const Text(""),
              const Text(""),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "An candidate for flutter app devloper .Persuing the B.tech form Chaudhray charan singh university in the field of computer Science and expalnding the skills in flutter ,dart and firebase for the app development .also having the skils in python , C language, C++ language .Experiance of one months intership for ai and ml in YBI foundation",
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Certificate",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text('1. Certificate of completion from GUVI for Ai 2.0'),
              Text('2. Certificate of completion from GUVI for Python '),
              Text('3. Certificate of completion from Let\'sUpgarde for C++'),
              Text('4. Certificate of completion from Career Ninja For Flutter')
            ],
          ),
        ));
  }
}
