import 'package:flutter/material.dart';

import '../teacher_portal/classview_teacher.dart';
import '../student_portal/classview_student.dart';

import '../tab_page_student.dart';
import '../tab_page_teacher.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TabPageTeacher(),
                  ),
                );
              },
              child: Text('student'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TabPageStudent(),
                  ),
                );
              },
              child: Text('teacher'),
            ),
          ],
        ),
      ),
    );
  }
}
