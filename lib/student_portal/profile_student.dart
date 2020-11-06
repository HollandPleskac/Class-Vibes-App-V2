import 'dart:async';
import 'dart:ui';

import 'package:class_vibes_v2/logic/auth_service.dart';
import 'package:class_vibes_v2/logic/class_vibes_server.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../nav_student.dart';
import '../constant.dart';
import '../logic/fire.dart';
import '../auth/welcome.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _authService = AuthenticationService();
final _classVibesServer = ClassVibesServer();
final _fire = Fire();

class ProfileStudent extends StatefulWidget {
  @override
  _ProfileStudentState createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
  var isUpdated = false;
  var feedback = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameEditController = TextEditingController();

  String _email = _firebaseAuth.currentUser.email;

  Future getStudentName() async {
    final userName = await _firestore
        .collection('UserData')
        .doc(_email)
        .get()
        .then((docSnap) => docSnap.data()['display name']);
        _userNameEditController.text = userName;
  }

  @override
  void initState() {
    getStudentName().then((_) {
      setState(() {});
    });

    super.initState();
  }

  Future<void> _deleteAccount() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteAccountPopUp(
          _email,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
              : Scaffold(
                  drawer: NavStudent(),
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: Text('Profile'),
                    backgroundColor: kPrimaryColor,
                    centerTitle: true,
                  ),
                  body: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 30,
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
                                      // 'https://www.kindpng.com/picc/m/404-4042814_facebook-no-profile-png-download-default-headshot-transparent.png'
                                      'https://i.pinimg.com/736x/9e/e8/9f/9ee89f7623acc78fc33fc0cbaf3a014b.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 10),
                        child: Text(
                          "Email Address",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: StreamBuilder(
                                      stream: _firestore
                                          .collection('UserData')
                                          .doc(_email)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('');
                                        } else {
                                          return Text(
                                            snapshot.data['email'],
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 18),
                                          );
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[100].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 10),
                        child: Text(
                          "User Name",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Form(
                            key: _formKey,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.51,
                                  child: TextFormField(
                                    controller: _userNameEditController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 18),
                                      labelStyle: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                      hintText: 'Full Name',
                                    ),
                                    validator: (value) {
                                      if (value == null || value == '') {
                                        return 'Username cannot be blank';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        isUpdated = true;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blueGrey[50], width: 3),
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 10),
                        child: Text(
                          "Account Type",
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
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
                              color: Colors.blueGrey[100].withOpacity(0.5),
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ),
                      isUpdated == false
                          ? Container()
                          : Center(
                              child: FlatButton(
                                color: kPrimaryColor,
                                child: Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  _fire.editUserName(
                                      uid: _firebaseAuth.currentUser.email,
                                      newUserName:
                                          _userNameEditController.text);
                                  Timer(Duration(milliseconds: 500), () {
                                    setState(() {
                                      isUpdated = false;
                                      feedback = "";
                                    });
                                  });
                                },
                              ),
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.08,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            _deleteAccount();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.10,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Delete Account',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        }
      },
    );
  }
}

class DeleteAccountPopUp extends StatelessWidget {
  final String studentEmail;

  DeleteAccountPopUp(this.studentEmail);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Delete Account',
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'We hate to see you go. You will be removed from all of your classes. All data will be deleted. Remeber this action can not be undone.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: new Container(
                child: new Material(
                  child: new InkWell(
                    onTap: () async {
                      User user = _firebaseAuth.currentUser;

                      await _classVibesServer.deleteAccount(
                          email: studentEmail, accountType: 'Student');

                      print('server delete');
                      print(user);
                      await _authService.signOutGoogle();
                      await user.delete();

                      print('successfully deleted');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Welcome()),
                          (Route<dynamic> route) => false);
                      print('navigated to welcome screen');
                    },
                    child: new Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      width: 180.0,
                      height: 40.0,
                      child: Center(
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                ),
                color: Colors.transparent,
              ),
            ),
          ],
        ));
  }
}
