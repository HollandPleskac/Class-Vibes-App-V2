import 'package:flutter/material.dart';

import '../nav_student.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavStudent(),
      body: Center(
        child: Text('student profile'),
      ),
    );
  }
}
