//IMPORTANT NOTE:
// this is not the actual first "splash screen" that gets showed
// the first one needs to be configured separately for ios and android
// the default is a white screen which is what we have kept
// this screen is just a gif - it looks good after the actual splash screen

//TODO : PUT THE ROUTER CODE IN THE MAIN>DART FILE ?
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './student_portal/classview_student.dart';
import './teacher_portal/classview_teacher.dart';
import './auth/welcome.dart';
import './logic/auth.dart';
import './logic/revenue_cat.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _auth = Auth();
final _revenueCat = RevenueCat();

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
    Timer(
      Duration(milliseconds: 500),
      () async {
        _revenueCat.setupPurchases();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return isCheckedAccount == true
                  ? (accountType == 'Student')
                      ? ClassViewStudent()
                      : (accountType == 'Teacher')
                          ? ClassViewTeacher()
                          : Welcome()
                  : Welcome(
                      //this welcome screen never actually shows up
                      );
            },
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Splash');
    return Scaffold(
        // backgroundColor: Colors.white,
        // body: Center(
        //     child: Image.asset(
        //   'Loading/loading.gif',
        //   fit: BoxFit.contain,
        // )),
        );
  }
}
