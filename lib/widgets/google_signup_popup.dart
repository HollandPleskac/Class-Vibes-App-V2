import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import '../logic/fire.dart';
import '../logic/auth.dart';

final _fire = Fire();
final _auth = Auth();

class GoogleSignUpPopup extends StatefulWidget {
  @override
  _GoogleSignUpPopupState createState() => _GoogleSignUpPopupState();
}

class _GoogleSignUpPopupState extends State<GoogleSignUpPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();

  String feedback = '';
  String googleAuthFeedback = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: googleAuthFeedback != ''
          ? Container()
          : Text('Enter your District Code'),
      content: googleAuthFeedback != ''
          ? Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.exclamationCircle,
                    size: 35,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    googleAuthFeedback,
                    style: TextStyle(),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "District Code",
                      ),
                      controller: _codeController,
                      validator: (districtCode) {
                        if (districtCode == null || districtCode == '') {
                          return 'Enter a district code';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: feedback == '' ? 0 : 10,
                ),
                Text(
                  feedback,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
      actions: <Widget>[
        googleAuthFeedback != ''
            ? Container()
            : FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: kPrimaryColor, fontSize: 15.5),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (await _fire
                            .doesDistrictCodeExist(_codeController.text) ==
                        true) {
                      print('district code valid');
                      setState(() {
                        feedback = '';
                      });
                      List result = await _auth
                          .signUpWithGoogleTeacher(_codeController.text);
                      print(result);
                      if (result[0] == 'failure') {
                        setState(() {
                          googleAuthFeedback = result[1];
                        });
                      }
                    } else {
                      print('invalid');
                      setState(() {
                        feedback = 'District Code Invalid';
                      });
                    }
                  }
                })
      ],
    );
  }
}
