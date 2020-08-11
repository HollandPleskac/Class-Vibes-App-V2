import 'package:class_vibes_v2/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore _firestore = Firestore.instance;

class DeactivatedAccountScreen extends StatefulWidget {
  final String teacherEmail;
  DeactivatedAccountScreen({this.teacherEmail});
  @override
  _DeactivatedAccountScreenState createState() =>
      _DeactivatedAccountScreenState();
}

class _DeactivatedAccountScreenState extends State<DeactivatedAccountScreen> {
  @override
  void initState() {
    _firestore
        .collection('UserData')
        .document(widget.teacherEmail)
        .snapshots()
        .listen((docSnap) {
      if (docSnap.data['account status'] == 'Activated') {
        print('the account is now deactivated');
        // gets rid of the entire screen stack
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Welcome()),
            (Route<dynamic> route) => false);
      } else {
        print(docSnap.data['account status']);
        print('something');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
