import 'dart:async';
import 'dart:ui';

import 'package:class_vibes_v2/auth/welcome.dart';
import 'package:class_vibes_v2/logic/class_vibes_server.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../logic/fire.dart';
import '../logic/auth.dart';
import '../constant.dart';
import 'account_settings_teacher.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final _fire = Fire();
final _auth = Auth();
final _classVibesServer = ClassVibesServer();

class ProfileTab extends StatefulWidget {
  String teacherEmail;

  ProfileTab({
    this.teacherEmail,
  });
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameEditController = TextEditingController();

  var isUpdated = false;
  var feedback = "";
  Future getTeacherName() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final userName = user.displayName;

    _userNameEditController.text = userName;
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
          height: MediaQuery.of(context).size.width * 0.145,
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
                    width: MediaQuery.of(context).size.width * 0.51,
                    child: StreamBuilder(
                        stream: _firestore
                            .collection('UserData')
                            .document(widget.teacherEmail)
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
                    // update
                    Timer(Duration(milliseconds: 1500), () {
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
                  /*
              FirebaseUser user = await _firebaseAuth.currentUser();

              print('deleteing + ' + accountType);

              await _classVibesServer.deleteAccount(
                  email: teacherEmail, accountType: accountType);

              // only signs out google auth because otherwise there is no "user" to delete
              await _auth.signOutGoogle();
              await user.delete();

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Welcome()),
                  (Route<dynamic> route) => false);
                  */
                },
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.10,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text('Delete Account',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700),),
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
