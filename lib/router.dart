//IMPORTANT NOTE:
// this is not the actual first "splash screen" that gets showed
// the first one needs to be configured separately for ios and android
// the default is a white screen which is what we have kept
// this screen is just a gif - it looks good after the actual splash screen

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'student_portal/classview_student.dart';
import 'teacher_portal/classview_teacher.dart';
import 'auth/welcome.dart';
import 'logic/auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _auth = Auth();

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
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

  Future getAccountTypeAndStatus(FirebaseUser user) async {
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
      getAccountTypeAndStatus(user).then((_) {
        setState(() {
          print(user);
          print(accountType);
        });
      });
    });
    // Timer(
    //   Duration(seconds: 1),
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return isCheckedAccount == true
                ? (accountType == 'Student')
                    ? ClassViewStudent()
                    : (accountType == 'Teacher' || accountType == 'District Teacher')
                        ? ClassViewTeacher()
                        : Welcome()
                : Welcome(
                    //this welcome screen never actually shows up
                    );
          },
        ),
      // ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // maybe have an animation like twitter or something
    print('Splash');
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
