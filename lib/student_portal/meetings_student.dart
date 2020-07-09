import 'package:flutter/material.dart';

class MeetingsStudent extends StatefulWidget {
  @override
  _MeetingsStudentState createState() => _MeetingsStudentState();
}

class _MeetingsStudentState extends State<MeetingsStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetings Student'),
      ),
      body: Center(
        child: Text('student meetings'),
      ),
    );
  }
}
