import 'package:class_vibes_v2/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../logic/auth.dart';
import '../constant.dart';
import '../widgets/delete_account_screen.dart';

final _auth = Auth();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class AccountSettingsTeacherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Delete Account'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteAccountScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
