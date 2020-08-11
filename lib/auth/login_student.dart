import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../student_portal/classview_student.dart';
import '../logic/auth.dart';
import '../constant.dart';
import '../widgets/forgot_password_popup.dart';

final _auth = Auth();
final Firestore _firestore = Firestore.instance;

class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final _formKey = new GlobalKey<FormState>();

  String _feedback = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: _firestore
              .collection('Application Management')
              .document('ServerManagement')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              return snapshot.data['serversAreUp'] == false
                  ? ServersDown()
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                        ),
                        Center(
                          child: Text(
                            'Student',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 46,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Email'),
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return 'Email cannot be blank';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Center(
                                child: Container(
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Password'),
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return 'Password cannot be blank';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Center(
                          child: Container(
                            child: new Material(
                              child: new InkWell(
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    List result = await _auth.loginAsStudent(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                    if (result[0] == 'success') {
                                      //push next screen
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ClassViewStudent(),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        _feedback = result[1];
                                      });
                                    }
                                  }
                                },
                                child: new Container(
                                  
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context).size.height * 0.028,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                   
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.transparent,
                            ),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: kAppBarColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Center(
                          child: Container(
                            child: new Material(
                              child: new InkWell(
                                onTap: () async {
                                  print('google sign in');
                                  List result =
                                      await _auth.signInWithGoogleStudent();
                                  if (result[0] == 'failure') {
                                    setState(() {
                                      _feedback = result[1];
                                    });
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ClassViewStudent(),
                                      ),
                                    );
                                  }
                                  print(result[0]);
                                },
                                child: new Container(
                                  child: Center(
                                    child: Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context).size.height * 0.028,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.transparent,
                            ),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              _feedback,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 15.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.002,
                        ),
                        InkWell(
                          onTap: () {
                            print('sending');
                            showDialog(
                                context: context,
                                builder: (context) => ForgotPasswordPopup());
                          },
                          child: Center(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            }
          }),
    );
  }
}
