import 'dart:async';

import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';
import '../nav_student.dart';
import '../logic/fire.dart';
import '../logic/fcm.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _fire = Fire();
final _fcm = FCM();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class JoinClass extends StatefulWidget {
  @override
  _JoinClassState createState() => _JoinClassState();
}

class _JoinClassState extends State<JoinClass> {
  String pins = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _studentName;

  Future getStudentEmail() async {
    final User user = _firebaseAuth.currentUser;
    final email = user.email;

    _email = email;
  }

  Future getStudentName(String email) async {
    String nameOfStudent = await _firestore
        .collection('UserData')
        .doc(email)
        .get()
        .then((docSnap) => docSnap['display name']);

    _studentName = nameOfStudent;
  }

  @override
  void initState() {
    getStudentEmail().then((_) {
      getStudentName(_email).then((_) {
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                  key: _scaffoldKey,
                  drawer: NavStudent(),
                  appBar: AppBar(
                    title: Text('Join a Class'),
                    centerTitle: true,
                    backgroundColor: kPrimaryColor,
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Enter your class code below',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: PinCodeTextField(
                            appContext: context,
                            backgroundColor: Colors.transparent,
                            pinTheme: PinTheme.defaults(
                              activeColor: Colors.blue[600],
                              inactiveColor: kWetAsphaltColor,
                            ),
                            length: 4,
                            onChanged: null,
                            onCompleted: (completedPins) {
                              setState(() {
                                pins = completedPins;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 17.5,
                            right: 17.5,
                          ),
                          color: Color.fromRGBO(131, 158, 241, 1),
                          child: Text(
                            'Join Class',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () async {
                            String result = await _fire.joinClass(
                                pins, _email, _studentName);
                            print(result);

                            final snackBar = SnackBar(
                              content: Text(result),
                              action: SnackBarAction(
                                label: 'Hide',
                                onPressed: () {
                                  _scaffoldKey.currentState
                                      .hideCurrentSnackBar();
                                },
                              ),
                            );

                            _scaffoldKey.currentState.showSnackBar(snackBar);
                          },
                        ),
                      ],
                    ),
                  ),
                );
        }
      },
    );
  }
}
