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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
