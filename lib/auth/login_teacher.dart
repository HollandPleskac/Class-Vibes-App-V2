import 'package:class_vibes_v2/logic/fire.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../logic/auth.dart';
import '../teacher_portal/classview_teacher.dart';

final _auth = Auth();
final Firestore _firestore = Firestore.instance;

class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final _formKey = new GlobalKey<FormState>();
  bool isEmailValidate = false;
  bool isPasswordValidate = false;
  String _feedback = '';

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
                  ? ServersDown()
                  : ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                        ),
                        Center(
                          child: Text(
                            'Teacher',
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045),
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045),
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
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                List result = await _auth.loginAsTeacher(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );

                                if (result[0] == 'success') {
                                  //push to next screen
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClassViewTeacher(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    isEmailValidate = false;
                                    isPasswordValidate = false;
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
                                });
                              }
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.025,
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
