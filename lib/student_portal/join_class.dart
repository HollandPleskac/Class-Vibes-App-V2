import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../nav_student.dart';
import '../logic/fire.dart';

final _fire = Fire();

class JoinClass extends StatefulWidget {
  @override
  _JoinClassState createState() => _JoinClassState();
}

class _JoinClassState extends State<JoinClass> {
  String pins = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;

  Future getTeacherEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String uid = prefs.getString('email');

    _email = uid;
    print(_email);
  }

  @override
  void initState() {
    getTeacherEmail().then((_) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavStudent(),
      appBar: AppBar(
        title: Text('Join a Class'),
        centerTitle: true,
        backgroundColor: kWetAsphaltColor,
      ),
      body: Center(
        child: Column(
          children: [
            PinCodeTextField(
              length: 6,
              onChanged: null,
              onCompleted: (completedPins) {
                setState(() {
                  pins = completedPins;
                });
              },
            ),
            FlatButton(
              child: Text('Join'),
              onPressed: () async {
                String result = await _fire.joinClass(pins, _email);
                print(result);

                if (result == 'You have joined the class!') {
                  final snackBar = SnackBar(
                    content: Text(result),
                    action: SnackBarAction(
                      label: 'Hide',
                      onPressed: () {
                        _scaffoldKey.currentState.hideCurrentSnackBar();
                      },
                    ),
                  );

                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }
                final snackBar = SnackBar(
                  content: Text(result),
                  action: SnackBarAction(
                    label: 'Hide',
                    onPressed: () {
                      _scaffoldKey.currentState.hideCurrentSnackBar();
                    },
                  ),
                );

                _scaffoldKey.currentState.showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ),
    );
  }
}
