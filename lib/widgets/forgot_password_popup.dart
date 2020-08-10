import 'package:flutter/material.dart';
import '../constant.dart';

class ForgotPasswordPopup extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
        title: Text('Reset Your Password'),
        content: Container(
          height: MediaQuery.of(context).size.height*0.1,
                  child: Center(
            child: Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top:15),
                  isDense: true,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email,size: 20),
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
        ),
        actions: <Widget>[
          FlatButton(
              color: kAppBarColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.pop(context);
                }
              })
        ],
      
    );
  }
}
