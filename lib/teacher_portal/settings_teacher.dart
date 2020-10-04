import 'dart:ui';

import 'package:class_vibes_v2/teacher_portal/account_settings_teacher.dart';
import 'package:class_vibes_v2/teacher_portal/help_settings.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../nav_teacher.dart';
import '../constant.dart';
import './billing_settings.dart';
import './account_profile_teacher.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ProfileTeacher extends StatefulWidget {
  @override
  _ProfileTeacherState createState() => _ProfileTeacherState();
}

class _ProfileTeacherState extends State<ProfileTeacher> {
  String _email;
  String _accountType;

  Future getTeacherEmail() async {
    final User user = _firebaseAuth.currentUser;
    final email = user.email;

    _email = email;
  }

  Future getAccountType(String email) async {
    String type = await _firestore
        .collection('UserData')
        .doc(email)
        .get()
        .then((docSnap) => docSnap['account type']);
    _accountType = type;
  }

  @override
  void initState() {
    getTeacherEmail().then((_) {
      getAccountType(_email).then((_) {
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: StreamBuilder(
          stream: _firestore
              .collection('Application Management')
              .document('ServerManagement')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              return snapshot.data['serversAreUp'] == false
                  ? ServersDown()
                  : Scaffold(
                      drawer: NavTeacher(),
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        title: Text('Settings'),
                        backgroundColor: kPrimaryColor,
                        centerTitle: true,
                        bottom: TabBar(
                          indicatorColor: Colors.white,
                          isScrollable: true,
                          tabs: [
                            Tab(text: 'Account'),
                            Tab(text: 'Payment'),
                            Tab(text: 'Help'),
                          ],
                        ),
                      ),
                      body: Theme(
                        data: ThemeData(
                          backgroundColor: Colors.white,
                          canvasColor: Colors.transparent,
                        ),
                        child: TabBarView(
                          children: [
                            Container(
                              child: ProfileTab(
                                teacherEmail: _email,
                                accountType: _accountType,
                              ),
                            ),
                            Container(
                              child: BillingTab(),
                            ),
                            Container(
                              child: HelpScreen(_email, _accountType),
                            ),
                          ],
                        ),
                      ),
                    );
            }
          }),
    );
  }
}
