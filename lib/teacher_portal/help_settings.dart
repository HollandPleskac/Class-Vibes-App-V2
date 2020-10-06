import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../logic/revenue_cat.dart';

import '../logic/class_vibes_server.dart';
import '../logic/auth.dart';
import '../logic/fcm.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final _auth = Auth();
final _fcm = FCM();

final _classVibesServer = ClassVibesServer();
final _revenueCat = RevenueCat();

class HelpScreen extends StatelessWidget {
  final String email;
  final String accountType;

  HelpScreen(this.email, this.accountType);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Contact support@classvibes.net with any questions!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
          FlatButton(
            child: Text('send notification'),
            onPressed: () async {
              await _fcm.sendDG();
              
            },
          ),
        ],
      ),
    );
  }
}
