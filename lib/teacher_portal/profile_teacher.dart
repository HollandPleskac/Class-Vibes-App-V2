import 'dart:ui';

import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../nav_teacher.dart';
import '../constant.dart';
import '../logic/fire.dart';
import '../logic/auth.dart';
import '../auth/welcome.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _fire = Fire();
final _auth = Auth();

class ProfileTeacher extends StatefulWidget {
  @override
  _ProfileTeacherState createState() => _ProfileTeacherState();
}

class _ProfileTeacherState extends State<ProfileTeacher> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameEditController = TextEditingController();

  void _showModalSheetEditUserName(String email) {
    showModalBottomSheet(
        barrierColor: Colors.white.withOpacity(0),
        isScrollControlled: true,
        elevation: 0,
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Edit Username',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: TextFormField(
                              controller: _userNameEditController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(126, 126, 126, 1),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                ),
                                hintText: 'new username',
                                icon: FaIcon(
                                  FontAwesomeIcons.userAlt,
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value == '') {
                                  return 'Username cannot be blank';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: FlatButton(
                            color: kPrimaryColor,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                FirebaseUser user =
                                    await _firebaseAuth.currentUser();
                                UserUpdateInfo userUpdateInfo =
                                    new UserUpdateInfo();
                                userUpdateInfo.displayName =
                                    _userNameEditController.text;

                                await user.updateProfile(userUpdateInfo);

                                _fire.editUserName(
                                  newUserName: _userNameEditController.text,
                                  uid: email,
                                );
                                _userNameEditController.text = '';
                                Navigator.pop(context);
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Save',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  String _email;

  Future getTeacherEmail() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final email = user.email;

    _email = email;
  }

  @override
  void initState() {
    getTeacherEmail().then((_) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                : Scaffold(
                    drawer: NavTeacher(),
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      title: Text('Profile'),
                      backgroundColor: kWetAsphaltColor,
                      centerTitle: true,
                    ),
                    body: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.145,
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 7,
                                    color: Colors.grey[
                                        200] //                   <--- border width here
                                    ),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://www.kindpng.com/picc/m/404-4042814_facebook-no-profile-png-download-default-headshot-transparent.png'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.0525,
                            width: MediaQuery.of(context).size.width - 50,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Teacher",
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 18),
                                ),
                                Spacer(),
                                // Text(
                                //   "Created 16 Classes",
                                //   style: TextStyle(
                                //       color: Colors.grey[400], fontSize: 14),
                                // ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.0525,
                            width: MediaQuery.of(context).size.width - 50,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                StreamBuilder(
                                    stream: _firestore
                                        .collection('UserData')
                                        .document(_email)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('');
                                      } else {
                                        return Text(
                                          snapshot.data['email'],
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 18),
                                        );
                                      }
                                    }),
                                Spacer(),
                                Text(
                                  "Email Address",
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 14),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showModalSheetEditUserName(_email);
                            print('user name');
                          },
                          child: Center(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.0525,
                              width: MediaQuery.of(context).size.width - 50,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  FutureBuilder(
                                    future: _firebaseAuth.currentUser(),
                                    builder: (context, snapshot) {
                                      print(snapshot.data.toString());
                                      return Text(
                                        snapshot.data.displayName,
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 18),
                                      );
                                    },
                                  ),
                                  // Text(getDisplayName().toString()),
                                  // StreamBuilder(
                                  //     stream: _firestore
                                  //         .collection('UserData')
                                  //         .document(_email)
                                  //         .snapshots(),
                                  //     builder: (context, snapshot) {
                                  //       if (!snapshot.hasData) {
                                  //         return Text('');
                                  //       } else {
                                  //         return Text(
                                  //           snapshot.data['display name'],
                                  //           style: TextStyle(
                                  //               color: Colors.grey[800],
                                  //               fontSize: 18),
                                  //         );
                                  //       }
                                  //     }),
                                  Spacer(),
                                  Text(
                                    "UserName",
                                    style: TextStyle(
                                        color: Colors.grey[400], fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(140, 15, 140, 0),
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: () {
                              print('logging out');
                              _auth.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Welcome()));
                            },
                            child: Text(
                              'Log Out',
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          }
        });
  }
}
