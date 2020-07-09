import 'package:flutter/material.dart';

import '../nav_student.dart';

class ProfileStudent extends StatefulWidget {
  @override
  _ProfileStudentState createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
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
