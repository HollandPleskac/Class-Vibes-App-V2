import 'package:class_vibes_v2/auth/welcome.dart';
import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../logic/revenue_cat.dart';

import '../logic/class_vibes_server.dart';
import '../logic/auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final _auth = Auth();

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
            style: TextStyle(color: kPrimaryColor,fontSize: 15,fontWeight: FontWeight.w500),
          ),
          FlatButton(
            child: Text('Delete Account'),
            onPressed: () async {
              FirebaseUser user = await _firebaseAuth.currentUser();

              print('deleteing + ' + accountType);

              await _classVibesServer.deleteAccount(
                  email: email, accountType: accountType);

              // only signs out google auth because otherwise there is no "user" to delete
              // await _auth.signOutGoogle();
              await _revenueCat.signOutRevenueCat();
              await user.delete();

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
