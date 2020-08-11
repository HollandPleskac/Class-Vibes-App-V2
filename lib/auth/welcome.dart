import 'package:class_vibes_v2/auth/register_choice.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_student.dart';
import 'login_teacher.dart';
import '../archived/sign_up.dart';
import '../constant.dart';
import './register_choice.dart';

final Firestore _firestore = Firestore.instance;

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
                  : Column(
                      children: [
                        Container(
                          child: Image.network('https://i.imgur.com/UNzfHQm.png',fit: BoxFit.cover,),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 46,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                         Center(
                            child: Container(
                              child: new Material(
                                child: new InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StudentLogin()),
                                    );
                                  },
                                  child: new Container(
                                    child: Center(
                                      child: Text(
                                        'Student',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: MediaQuery.of(context).size.height*0.028,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
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
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                         Center(
                            child: Container(
                              child: new Material(
                                child: new InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TeacherLogin()),
                                    );
                                  },
                                  child: new Container(
                                    child: Center(
                                      child: Text(
                                        'Teacher',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: MediaQuery.of(context).size.height*0.028,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
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
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Center(
                            child: Container(
                              child: new Material(
                                child: new InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterChoice()),
                                    );
                                  },
                                  child: new Container(
                                    child: Center(
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context).size.height*0.028,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
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
                      ],
                    );
            }
          }),
    );
  }
}
