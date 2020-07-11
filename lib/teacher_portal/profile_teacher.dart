import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';

import '../nav_teacher.dart';

class ProfileTeacher extends StatefulWidget {
  @override
  _ProfileTeacherState createState() => _ProfileTeacherState();
}

class _ProfileTeacherState extends State<ProfileTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavTeacher(),
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text('Teacher Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('teacher profile'),
      ),
    );
  }
}
