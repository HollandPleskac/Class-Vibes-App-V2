import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './student_portal/classview_student.dart';
import './teacher_portal/classview_teacher.dart';
import './auth/welcome.dart';
import './logic/auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _auth = Auth();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseUser user;
  String accountType;
  Future getUser() async {
    try {
      final FirebaseUser theUser = await _firebaseAuth.currentUser();
      user = theUser;
    } catch (_) {
      user = null;
    }
  }

  Future getAccountType(FirebaseUser user) async {
    if (user != null) {
      try {
        String type = await _auth.checkAccountType(user.email);
        accountType = type;
      } catch (_) {
        accountType = null;
      }
    } else {
      accountType = null;
    }
  }

  @override
  void initState() {
    getUser().then((_) {
      getAccountType(user).then((_) {
        setState(() {
          print(user);
          print(accountType);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return accountType == 'Student'
        ? ClassViewStudent()
        : accountType == 'Teacher' ? ClassViewTeacher() : Welcome();
  }
}
