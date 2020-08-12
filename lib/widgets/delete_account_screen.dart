import 'package:flutter/material.dart';

import '../constant.dart';
import '../logic/auth.dart';
import '../auth/welcome.dart';

final _auth = Auth();

class DeleteAccountScreen extends StatelessWidget {
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
            _auth.deleteAccount();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (Route<dynamic> route) => false);
          },
        ),
      ),
    );
  }
}
