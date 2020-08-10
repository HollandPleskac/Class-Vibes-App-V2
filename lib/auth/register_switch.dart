import 'package:flutter/material.dart';

import './student_sign_up.dart';
import 'teacher_sign_up.dart';

class RegisterSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Student'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpStudent()));
            },
          ),
          RaisedButton(
            child: Text('Teacher'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpTeacher()));
            },
          )
        ],
      ),
    );
  }
}
