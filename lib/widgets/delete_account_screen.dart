import 'package:flutter/material.dart';

import '../constant.dart';
import '../logic/auth.dart';
import '../auth/welcome.dart';

final _auth = Auth();

class DeleteAccountScreen extends StatelessWidget {
  final String accountType;

  DeleteAccountScreen(this.accountType);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Delete Account'),
        centerTitle: true,
      ),
      body: Container(
        child: FlatButton(
          child: Text('Delete forever'),
          onPressed: () {
            accountType == 'Teacher' ? _auth.deleteTeacherAccount() : _auth.deleteStudentAccount();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (Route<dynamic> route) => false);
          },
        ),
      ),
    );
  }
}
