import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constant.dart';
import '../logic/class_vibes_server.dart';
import '../auth/welcome.dart';
import '../logic/auth.dart';

final classVibesServer = ClassVibesServer();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final _googleSignIn = GoogleSignIn();
final _auth = Auth();

class DeleteAccountScreen extends StatefulWidget {
  final String accountType;

  DeleteAccountScreen(this.accountType);

  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  String email;

  Future getUserEmail() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    String userEmail = user.email;
    email = userEmail;
  }

  @override
  void initState() {
    getUserEmail().then((_) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Delete Account'),
        centerTitle: true,
      ),
      body: Container(
        child: FlatButton(
          child: Text('Delete forever'),
          onPressed: () async {
            FirebaseUser user = await _firebaseAuth.currentUser();

            print('deleteing + ' + widget.accountType);

            await classVibesServer.deleteAccount(
                email: email, accountType: widget.accountType);

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
