import 'package:class_vibes_v2/logic/auth_service.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../logic/auth.dart';
import '../teacher_portal/classview_teacher.dart';
import '../constant.dart';
import '../widgets/forgot_password_popup.dart';

final _authService = AuthenticationService();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final _formKey = new GlobalKey<FormState>();

  bool isPasswordValidate = false;
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
              .doc('ServerManagement')
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: TextFormField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                    String res =
                                        await _authService.signInEmailTeacher(
                                            _emailController.text,
                                            _passwordController.text);
                                    print('RESULT : ' + res.toString());
                                    // notify feedback model listeners
                                    if (res != 'Signed in') {
                                      setState(() {
                                        _feedback = res;
                                      });
                                    } else {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ClassViewTeacher(),
                                        ),
                                      );
                                      print('else');
                                    }
                                  }
                                },
                                child: new Container(
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
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
                              color: kPrimaryColor,
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
                                  String res =
                                      await _authService.signInGoogleTeacher();
                                  print('RESULT : ' + res.toString());
                                  // notify feedback model listeners
                                  if (res != 'Signed in') {
                                    setState(() {
                                      _feedback = res;
                                    });
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ClassViewTeacher(),
                                      ),
                                    );
                                    print('else');
                                  }
                                },
                                child: new Container(
                                  child: Center(
                                    child: Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
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
