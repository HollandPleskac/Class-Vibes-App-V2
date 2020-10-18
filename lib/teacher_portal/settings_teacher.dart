import 'package:class_vibes_v2/teacher_portal/help_settings.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../nav_teacher.dart';
import '../constant.dart';
import './billing_settings.dart';
import './account_profile_teacher.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _firebaseMessaging = FirebaseMessaging();
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

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: StreamBuilder(
          stream: _firestore
              .collection('Application Management')
              .doc('ServerManagement')
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
