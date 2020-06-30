import 'package:flutter/material.dart';

import '../constant.dart';

class ClassViewTeacher extends StatefulWidget {
  @override
  _ClassViewTeacherState createState() => _ClassViewTeacherState();
}

class _ClassViewTeacherState extends State<ClassViewTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text(
          'Screen 2',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('class view teacher'),
      ),
    );
  }
}
