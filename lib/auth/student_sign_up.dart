import 'package:class_vibes_v2/logic/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../student_portal/classview_student.dart';
import '../constant.dart';

final _authService = AuthenticationService();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignUpStudent extends StatefulWidget {
  @override
  _SignUpStudentState createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent> {
  final _formKey = new GlobalKey<FormState>();

  String _feedback = '';
  bool checkValue = false;

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  ? Center(
                      child: Text(
                        'Servers are down',
                        style: TextStyle(color: Colors.grey[800], fontSize: 18),
                      ),
                    )
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.035,
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
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Full Name'),
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return 'Full Name cannot be blank';
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
                                        controller: _confirmPasswordController,
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Confirm Password'),
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return 'Confirm password field cannot be blank';
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Checkbox(
                              value: checkValue,
                              onChanged: (value) {
                                setState(() {
                                  checkValue = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('I agree to the '),
                                    InkWell(
                                      onTap: () async {
                                        String url =
                                            'https://classvibes.net/legal';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Text(
                                        'Terms of Service',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text('.'),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('I have read and accept the '),
                                    InkWell(
                                      onTap: () async {
                                        String url =
                                            'https://classvibes.net/privacy';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Text(
                                        'Privacy Policy',
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text('.'),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
                                        await _authService.signUpEmailStudent(
                                      _emailController.text,
                                      _passwordController.text,
                                      _confirmPasswordController.text,
                                      _usernameController.text,
                                      checkValue,
                                    );

                                    if (res != 'Signed up') {
                                      setState(() {
                                        _feedback = res;
                                      });
                                    } else {
                                      // show success dialog
                                      showDialog(
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              FaIcon(
                                                FontAwesomeIcons.check,
                                                color: Colors.green,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Center(
                                                child: Text('Success!'),
                                              ),
                                              SizedBox(height: 5),
                                              Center(
                                                child: Text(
                                                    'Verify you email to continue'),
                                              ),
                                            ],
                                          ),
                                        ), context: context,
                                      );
                                    }
                                  }
                                },
                                child: new Container(
                                  child: Center(
                                    child: Text(
                                      'Sign up',
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
                                      await _authService.signUpGoogleStudent();

                                  if (res != 'Signed up') {
                                    setState(() {
                                      _feedback = res;
                                    });
                                  } else {
                                    // show success dialog
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ClassViewStudent(),
                                      ),
                                    );
                                    print('else');
                                  }
                                },
                                child: new Container(
                                  child: Center(
                                    child: Text(
                                      'Sign up with Google',
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
                      ],
                    );
            }
          }),
    );
  }
}
