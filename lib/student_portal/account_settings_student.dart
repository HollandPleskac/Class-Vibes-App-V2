import 'package:flutter/material.dart';
import '../constant.dart';
import '../widgets/delete_account_screen.dart';

class AccountSettingsStudentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
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
                  builder: (context) => DeleteAccountScreen('Student'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
