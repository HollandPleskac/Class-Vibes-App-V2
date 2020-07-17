import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';
import '../nav_student.dart';
import '../logic/fire.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _fire = Fire();
final Firestore _firestore = Firestore.instance;

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
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final email = user.email;

    _email = email;
  }

  Future getStudentName(String email) async {
    String nameOfStudent = await _firestore
        .collection('UserData')
        .document(email)
        .get()
        .then((docSnap) => docSnap.data['display-name']);

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
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavStudent(),
      appBar: AppBar(
        title: Text('Join a Class'),
        centerTitle: true,
        backgroundColor: kWetAsphaltColor,
      ),
      body: Center(
        child: Column(
          children: [
            PinCodeTextField(
              length: 6,
              onChanged: null,
              onCompleted: (completedPins) {
                setState(() {
                  pins = completedPins;
                });
              },
            ),
            FlatButton(
              child: Text('Join'),
              onPressed: () async {
                String result =
                    await _fire.joinClass(pins, _email, _studentName);
                print(result);

                if (result == 'You have joined the class!') {
                  final snackBar = SnackBar(
                    content: Text(result),
                    action: SnackBarAction(
                      label: 'Hide',
                      onPressed: () {
                        _scaffoldKey.currentState.hideCurrentSnackBar();
                      },
                    ),
                  );

                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }
                final snackBar = SnackBar(
                  content: Text(result),
                  action: SnackBarAction(
                    label: 'Hide',
                    onPressed: () {
                      _scaffoldKey.currentState.hideCurrentSnackBar();
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
}
