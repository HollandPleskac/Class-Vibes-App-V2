import 'package:flutter/material.dart';

import '../teacher_portal/classview_teacher.dart';
import '../student_portal/classview_student.dart';

import '../nav_student.dart';
import '../nav_teacher.dart';

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
                    builder: (context) => ClassViewStudent(),
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
                    builder: (context) => ClassViewTeacher(),
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
