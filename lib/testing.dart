import 'package:class_vibes_v2/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './logic/updates.dart';

final Firestore _firestore = Firestore.instance;

final updates = Updates();

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
    updates.handleAccountStatus(context, widget.teacherEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
