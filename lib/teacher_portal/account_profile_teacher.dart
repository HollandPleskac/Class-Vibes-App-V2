import 'dart:async';
import 'dart:ui';

import 'package:class_vibes_v2/auth/welcome.dart';
import 'package:class_vibes_v2/logic/auth_service.dart';
import 'package:class_vibes_v2/logic/class_vibes_server.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';
import '../logic/fire.dart';

final _fire = Fire();

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final _classVibesServer = ClassVibesServer();
final _authService = AuthenticationService();

class ProfileTab extends StatefulWidget {
  final String teacherEmail;

  ProfileTab({this.teacherEmail});
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameEditController = TextEditingController();

  var isUpdated = false;
  var feedback = "";
  Future getTeacherName() async {
    final User user = _firebaseAuth.currentUser;
    final userName = user.displayName;

    _userNameEditController.text = userName;
  }

  Future<void> _deleteAccount() async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return DeleteAccountPopUpT(
          widget.teacherEmail,
        );
      },
    );
  }

  @override
  void initState() {
    getTeacherName().then((_) {
      setState(() {});
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.07,
        ),
        //
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 7,
                    color: Colors
                        .grey[200] //                   <--- border width here
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
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: StreamBuilder(
                        stream: _firestore
                            .collection('UserData')
                            .doc(widget.teacherEmail)
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
                                  color: Colors.grey[800], fontSize: 18),
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

        GestureDetector(
          onTap: () {
            //_showModalSheetEditUserName(widget.teacherEmail);
            //print('user name');
          },
          child: Center(
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
                      width: MediaQuery.of(context).size.width * 0.51,
                      child: TextFormField(
                        controller: _userNameEditController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey[800], fontSize: 18),
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
                  border: Border.all(color: Colors.blueGrey[50], width: 3),
                  borderRadius: BorderRadius.circular(7)),
            ),
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
                  style: TextStyle(color: Colors.grey[800], fontSize: 18),
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
                    _fire.editUserName(uid: _firebaseAuth.currentUser.email,newUserName: _userNameEditController.text);
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
                ))),

        // Center(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Container(
        //         width: MediaQuery.of(context).size.width * 0.4,
        //         padding: EdgeInsets.only(top: 20),
        //         child: FlatButton(
        //           color: Colors.grey[200],
        //           onPressed: () async {
        //             print('logging out');
        //             print('google log out too');
        //             // await _googleSignIn.signOut();
        //             // await _googleSignIn.signOut();

        //             await _auth.signOut();

        //             Navigator.push(context,
        //                 MaterialPageRoute(builder: (context) => Welcome()));
        //           },
        //           child: Text(
        //             'Log Out',
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         width: 20,
        //       ),
        //       Container(
        //         width: MediaQuery.of(context).size.width * 0.4,
        //         padding: EdgeInsets.only(top: 20),
        //         child: FlatButton(
        //           color: Colors.grey[200],
        //           onPressed: () {
        //             print('deleteing account');

        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) =>
        //                         AccountSettingsTeacherPage()));
        //           },
        //           child: Text(
        //             'Acount Settings',
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }
}

class DeleteAccountPopUpT extends StatelessWidget {
  final String teacherEmail;

  DeleteAccountPopUpT(this.teacherEmail);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 0,
        title: Text(
          'Delete Account',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'All of your data will be deleted and you will not be able to retrieve your deleted account. Purchased classes cannot be recovered.',
              style: TextStyle(height: 2),
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

                      print('deleteing + ' + 'Teacher');

                      await _classVibesServer.deleteAccount(
                          email: teacherEmail, accountType: 'Teacher');

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
                    splashColor: kPrimaryColor,
                  ),
                ),
                color: Colors.redAccent,
              ),
            ),
          ],
        ));
  }
}
