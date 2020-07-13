import 'package:flutter/material.dart';

import '../student_portal/classview_student.dart';
import '../teacher_portal/classview_teacher.dart';
import '../logic/auth.dart';

final _auth = Auth();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Username'),
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
                        ? MediaQuery.of(context).size.height * 0.08
                        : MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Email'),
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
                        ? MediaQuery.of(context).size.height * 0.08
                        : MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Password'),
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
                    height:isPasswordValidate == true
                        ? MediaQuery.of(context).size.height * 0.08
                        : MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
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
                  isSwitched ? "Student Account" : "Teacher Account",
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
              onTap: () {
                if (isSwitched == true) {
                  if (_formKey.currentState.validate()) {
                    // _auth.signUp();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassViewStudent(),
                      ),
                    );
                  }
                } else {
                  if (_formKey.currentState.validate()) {
                    // _auth.signUp();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassViewTeacher(),
                      ),
                    );
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
          )
        ],
      ),
    );
  }
}
