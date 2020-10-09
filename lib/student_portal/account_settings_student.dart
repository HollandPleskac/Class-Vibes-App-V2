import 'package:flutter/material.dart';
import '../constant.dart';
import '../widgets/delete_account_screen.dart';

class AccountSettingsStudentPage extends StatefulWidget {
  @override
  _AccountSettingsStudentPageState createState() =>
      _AccountSettingsStudentPageState();
}

class _AccountSettingsStudentPageState
    extends State<AccountSettingsStudentPage> {
  Future<void> _deleteAccount() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteAccountPopUp();
      },
    );
  }

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
              _deleteAccount();
              //Navigator.push(
              //  context,
              // MaterialPageRoute(
              //    builder: (context) => DeleteAccountScreen('Student'),
              //  ),
              //);
            },
          ),
        ],
      ),
    );
  }
}

class DeleteAccountPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: kPrimaryColor,
        title: Text(
              'Delete Account',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w700),
            ),
        content: Column(
           mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'We hate to see you go, but if you are sure press the button below. Remeber this action can not be undone.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: new Container(
                child: new Material(
                  child: new InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeleteAccountScreen('Student'),
                        ),
                      );
                    },
                    child: new Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      width: 180.0,
                      height: 40.0,
                      child: Center(
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                ),
                color: Colors.transparent,
              ),
            ),
          ],
        ));
  }
}
