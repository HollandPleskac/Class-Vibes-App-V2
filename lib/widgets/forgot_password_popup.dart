import 'dart:async';

import 'package:flutter/material.dart';
import '../constant.dart';
import '../logic/auth_service.dart';

final _authService = AuthenticationService();

class ForgotPasswordPopup extends StatefulWidget {
  @override
  _ForgotPasswordPopupState createState() => _ForgotPasswordPopupState();
}

class _ForgotPasswordPopupState extends State<ForgotPasswordPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  bool submitEmail = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: submitEmail == false ? Text('Reset Your Password') : Container(),
      content: submitEmail == false
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Enter an email address';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Password Reset Email Sent!'),
                  SizedBox(height: 5,),
                  Text('This may take a few minutes.')
               
                ],
              ),
            ),
      actions: <Widget>[
        submitEmail == false
            ? FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  'Reset Password',
                  style: TextStyle(color: kPrimaryColor, fontSize: 15.5),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _authService.resetPassword(_emailController.text);
                    setState(() {
                      submitEmail = true;
                    });
                    Timer(Duration(seconds: 5), () {
                      Navigator.pop(context);
                    });
                  }
                })
            : Container()
      ],
    );
  }
}
