import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
                String result = await _fire.joinClass(pins);
                print(result);
                if (result == 'unique code') {
                  final snackBar = SnackBar(
                    content: Text('Successfully joined the class!'),
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
                    content: Text('That code does not exist'),
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
