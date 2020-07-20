import 'dart:async';

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
  bool isCheckedAccount = false;
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
        isCheckedAccount = true;
      } catch (_) {
        accountType = null;
        isCheckedAccount = true;
      }
    } else {
      accountType = null;
      isCheckedAccount = true;
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
    Timer(
      Duration(seconds: 2),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => isCheckedAccount == true
              ? accountType == 'Student'
                  ? ClassViewStudent()
                  : accountType == 'Teacher' ? ClassViewTeacher() : Welcome()
              : Welcome(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Splash');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset('Loading/loading.gif',fit: BoxFit.contain,)),
    );
  }
}
