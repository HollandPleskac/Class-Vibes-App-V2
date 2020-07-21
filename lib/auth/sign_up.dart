import 'package:class_vibes_v2/logic/fire.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../student_portal/classview_student.dart';
import '../teacher_portal/classview_teacher.dart';
import '../logic/auth.dart';

final _auth = Auth();
final Firestore _firestore = Firestore.instance;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = new GlobalKey<FormState>();
  bool isEmailValidate = false;
  bool isPasswordValidate = false;
  bool isUserNameValidate = false;
  bool isSwitched = true;
  String _feedback = '';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ? Center(
                      child: Text(
                        'Servers are down',
                        style: TextStyle(color: Colors.grey[800], fontSize: 18),
                      ),
                    )
                  : ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                        ),
                        Center(
                          child: Text(
                            'Register',
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
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Username'),
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            setState(() {
                                              isUserNameValidate = true;
                                            });

                                            return 'Username cannot be blank';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  height: isUserNameValidate == true
                                      ? MediaQuery.of(context).size.height *
                                          0.08
                                      : MediaQuery.of(context).size.height *
                                          0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10)),
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
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Email'),
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            setState(() {
                                              isEmailValidate = true;
                                            });

                                            return 'Email cannot be blank';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  height: isEmailValidate == true
                                      ? MediaQuery.of(context).size.height *
                                          0.08
                                      : MediaQuery.of(context).size.height *
                                          0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10)),
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
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Password'),
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            setState(() {
                                              isPasswordValidate = true;
                                            });

                                            return 'Password cannot be blank';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  height: isPasswordValidate == true
                                      ? MediaQuery.of(context).size.height *
                                          0.08
                                      : MediaQuery.of(context).size.height *
                                          0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    print(isSwitched);
                                  });
                                },
                                activeTrackColor: Colors.grey[200],
                                activeColor: Colors.grey[500],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                isSwitched
                                    ? "Student Account"
                                    : "Teacher Account",
                                style: TextStyle(color: Colors.grey[500]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (isSwitched == true) {
                                //sign up as a student
                                if (_formKey.currentState.validate()) {
                                  List result = await _auth.signUp(
                                      username: _usernameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      accountType: 'student');
                                  if (result[0] == 'success') {
                                    //ste up account
                                    _auth.setUpAccount(
                                      accountType: 'Student',
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                      email: _emailController.text,
                                    );

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
                                      isEmailValidate = false;
                                      isPasswordValidate = false;
                                      isUserNameValidate = false;
                                      _feedback = result[1];
                                    });
                                  }
                                } else {
                                  // determines if the textfield is big to accomodate a validator message
                                  setState(() {
                                    isEmailValidate == true
                                        ? isEmailValidate = true
                                        : isEmailValidate = false;
                                    isPasswordValidate == true
                                        ? isPasswordValidate = true
                                        : isPasswordValidate = false;
                                    isUserNameValidate == true
                                        ? isUserNameValidate = true
                                        : isUserNameValidate = false;
                                  });
                                }
                              } else {
                                //sign up as a teacher
                                if (_formKey.currentState.validate()) {
                                  List result = await _auth.signUp(
                                      username: _usernameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      accountType: 'teacher');
                                  if (result[0] == 'success') {
                                    //set up account
                                    _auth.setUpAccount(
                                      accountType: 'Teacher',
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                      email: _emailController.text,
                                    );

                                    //push next screen
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ClassViewTeacher(),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      isEmailValidate = false;
                                      isPasswordValidate = false;
                                      isUserNameValidate = false;
                                      _feedback = result[1];
                                    });
                                  }
                                } else {
                                  // determines if the textfield is big to accomodate a validator message
                                  setState(() {
                                    isEmailValidate == true
                                        ? isEmailValidate = true
                                        : isEmailValidate = false;
                                    isPasswordValidate == true
                                        ? isPasswordValidate = true
                                        : isPasswordValidate = false;
                                    isUserNameValidate == true
                                        ? isUserNameValidate = true
                                        : isUserNameValidate = false;
                                  });
                                }
                              }
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                      color: Colors.grey[100],
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(left:15,right:15),
                            child: Text(
                              _feedback,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red, fontSize: 15.5),
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
