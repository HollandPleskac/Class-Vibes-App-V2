import 'package:flutter/material.dart';

import '../teacher_portal/classview_teacher.dart';
import '../student_portal/classview_student.dart';

import '../nav_student.dart';
import '../nav_teacher.dart';
import '../constant.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log in as a..',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Student'),
            ),
          ],
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       RaisedButton(
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ClassViewStudent(),
      //             ),
      //           );
      //         },
      //         child: Text('student'),
      //       ),
      //       RaisedButton(
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ClassViewTeacher(),
      //             ),
      //           );
      //         },
      //         child: Text('teacher'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
