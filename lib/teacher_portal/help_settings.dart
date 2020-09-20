import 'package:class_vibes_v2/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../logic/class_vibes_server.dart';
import '../logic/auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final _auth = Auth();

final _classVibesServer = ClassVibesServer();

class HelpScreen extends StatelessWidget {
  final String email;
  final String accountType;

  HelpScreen(this.email,this.accountType);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: FlatButton(
          child: Text('Delete forever'),
          onPressed: () async {
            FirebaseUser user = await _firebaseAuth.currentUser();

            print('deleteing + ' + accountType);

            await _classVibesServer.deleteAccount(
                email: email, accountType: accountType);

            // only signs out google auth because otherwise there is no "user" to delete
            await _auth.signOutGoogle();
            await user.delete();

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Welcome()),
                (Route<dynamic> route) => false);
          },
        ),
      ),
    );
  }
}
