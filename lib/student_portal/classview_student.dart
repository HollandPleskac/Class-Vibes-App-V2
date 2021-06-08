import 'dart:ui';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';
import '../logic/fire.dart';
import '../nav_student.dart';
import './view_class_student.dart';
import '../widgets/no_documents_message.dart';
import '../widgets/badges.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _fire = Fire();

class ClassViewStudent extends StatefulWidget {
  @override
  _ClassViewStudentState createState() => _ClassViewStudentState();
}

class _ClassViewStudentState extends State<ClassViewStudent> {
  String _email;

  Future getStudentEmail() async {
    final User user = _firebaseAuth.currentUser;
    final email = user.email;

    _email = email;
  }

  @override
  void initState() {
    getStudentEmail().then((_) {
      print(_email);
      setState(() {});
    });

    super.initState();
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
                  backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
                  appBar: AppBar(
                    backgroundColor: kPrimaryColor,
                    title: Text(
                      'Classes',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          print('press question');
                          showStudentInfoPopUp(context);
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.question,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: StreamBuilder(
                      stream: _firestore
                          .collection('UserData')
                          .doc(_email)
                          .collection('Classes')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: Container(),
                            );
                          default:
                            if (snapshot.data != null &&
                                snapshot.data.docs.isEmpty == false) {
                              return ListView(
                                physics: BouncingScrollPhysics(),
                                children: snapshot.data.docs
                                    .map((DocumentSnapshot document) {
                                  return StudentClass(
                                    classId: document.id,
                                    email: _email,
                                    unreadCount:
                                        document['student unread'] != null ? document['student unread'] : 0 ,
                                    accepted: document['accepted'],
                                  );
                                }).toList(),
                              );
                            } else {
                              return Scaffold(
                                backgroundColor: Colors.white,
                                appBar: AppBar(
                                  backgroundColor: Colors.blue[200],
                                  elevation: 6,
                                  leading: SizedBox(),
                                  centerTitle: true,
                                  title: Text(
                                    'Ask your teacher for the class code!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                body: Center(
                                  child: NoDocsClassViewStudent(),
                                ),
                              );
                            }
                        }
                      },
                    ),
                  ),
                );
        }
      },
    );
  }
}

class StudentClass extends StatelessWidget {
  final String classId;
  final String email;
  final int unreadCount;
  final bool accepted;

  StudentClass({
    this.classId,
    this.email,
    this.unreadCount,
    this.accepted,
  });
  @override
  Widget build(BuildContext context) {
    Future getClassName() async {
      return await _firestore.collection('Classes').doc(classId).get().then(
            (docSnap) => docSnap['class name'],
          );
    }

    Future<void> _showNotAcceptedMessage() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return NotAcceptedContent();
        },
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      // color: Colors.red,
      child: StreamBuilder(
        stream: _firestore.collection('Classes').doc(classId).snapshots(),
        builder: (BuildContext context, classSnapshot) {
          if (classSnapshot.data == null) {
            return Center(
              child: Container(),
            );
          }

          return Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      if (accepted == true) {
                        Navigator.pushNamed(context, ViewClassStudent.routename,
                            arguments: {
                              'class id': classId,
                              'class name': await getClassName(),
                              'initial index': 0,
                            });
                      } else {
                        _showNotAcceptedMessage();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.1,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.07,
                      ),
                      child: Center(
                        child: Text(
                          classSnapshot.data['class name'],
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            // fontFamily: 'Nunito',
                            wordSpacing: 2,
                            letterSpacing: 1.25,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: MediaQuery.of(context).size.width * 0.025,
                    child: UnreadMessageBadge(unreadCount),
                  ),
                ],
              ),
              accepted == true
                  ? StreamBuilder(
                      stream: _firestore
                          .collection('Classes')
                          .doc(classId)
                          .collection('Students')
                          .doc(email)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: Container(),
                          );
                        }
                        return SelectStatusRow(
                          classId: classId,
                          lastChangedStatus: snapshot.data['date'],
                          status: snapshot.data['status'],
                          email: email,
                          maxDaysInactive:
                              classSnapshot.data['max days inactive'],
                        );
                      },
                    )
                  : StatusRowLocked(
                      classId: classId,
                      studentEmail: email,
                    ),
            ],
          );
        },
      ),
    );
  }
}

void showStudentInfoPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(1)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Current Mood",
                        style: TextStyle(
                            fontSize: 24.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "How do you currently feel about class? ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.85 - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.smile,
                                  size: 43.0,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Doing Great",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.meh,
                                  size: 43.0,
                                  color: Colors.orange[600],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  " Need Help ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.orange[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.frown,
                                  size: 43.0,
                                  color: Colors.red[700],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Frustrated",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      );
    },
  );
}

class SelectStatusRow extends StatefulWidget {
  final String classId;
  final Timestamp lastChangedStatus;
  final String status;
  final String email;
  final int maxDaysInactive;

  SelectStatusRow(
      {this.classId,
      this.lastChangedStatus,
      this.status,
      this.email,
      this.maxDaysInactive});
  @override
  _SelectStatusRowState createState() => _SelectStatusRowState();
}

class _SelectStatusRowState extends State<SelectStatusRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            _fire.updateStudentMood(
                uid: widget.email,
                classId: widget.classId,
                newMood: 'doing great');
            print('changing status');
          },
          splashColor: Colors.green[100],
          child: Ink(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.1,
            color: DateTime.now()
                        .difference(
                          DateTime.parse(
                              widget.lastChangedStatus.toDate().toString()),
                        )
                        .inDays >=
                    widget.maxDaysInactive
                ? Colors.grey[200]
                : widget.status == 'doing great'
                    ? Colors.green[100]
                    : Colors.transparent,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.smile,
                color: DateTime.now()
                            .difference(
                              DateTime.parse(
                                  widget.lastChangedStatus.toDate().toString()),
                            )
                            .inDays >=
                        widget.maxDaysInactive
                    ? Colors.grey
                    : Colors.green,
                size: MediaQuery.of(context).size.width * 0.0825,
                //used to be 36
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _fire.updateStudentMood(
                uid: widget.email,
                classId: widget.classId,
                newMood: 'need help');
            print('changing status');
          },
          splashColor: Colors.orange[100],
          child: Ink(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.1,
            color: DateTime.now()
                        .difference(
                          DateTime.parse(
                              widget.lastChangedStatus.toDate().toString()),
                        )
                        .inDays >=
                    widget.maxDaysInactive
                ? Colors.grey[200]
                : widget.status == 'need help'
                    ? Colors.orange[100]
                    : Colors.transparent,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.meh,
                color: DateTime.now()
                            .difference(
                              DateTime.parse(
                                  widget.lastChangedStatus.toDate().toString()),
                            )
                            .inDays >=
                        widget.maxDaysInactive
                    ? Colors.grey
                    : Colors.yellow[800],
                size: MediaQuery.of(context).size.width * 0.0825,
                //used to be 36
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _fire.updateStudentMood(
                uid: widget.email,
                classId: widget.classId,
                newMood: 'frustrated');
            print('changing status');
          },
          splashColor: Colors.red[100],
          child: Ink(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.1,
            color: DateTime.now()
                        .difference(
                          DateTime.parse(
                              widget.lastChangedStatus.toDate().toString()),
                        )
                        .inDays >=
                    widget.maxDaysInactive
                ? Colors.grey[200]
                : widget.status == 'frustrated'
                    ? Colors.red[100]
                    : Colors.transparent,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.frown,
                color: DateTime.now()
                            .difference(
                              DateTime.parse(
                                  widget.lastChangedStatus.toDate().toString()),
                            )
                            .inDays >=
                        widget.maxDaysInactive
                    ? Colors.grey
                    : Colors.red,
                size: MediaQuery.of(context).size.width * 0.0825,
                //used to be 36
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StatusRowLocked extends StatelessWidget {
  final String classId;
  final String studentEmail;

  StatusRowLocked({this.classId, this.studentEmail});
  @override
  Widget build(BuildContext context) {
    return Ink(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.6,
      color: kPrimaryColor,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03,
          ),
          //maybe a row with some type of nice loading indicator here or something?
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pending Approval',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.25,
                ),
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.trash,
                  size: 19.5,
                  color: Colors.white,
                ),
                splashColor: Colors.transparent,
                onPressed: () {
                  _fire.leaveClass(
                    classId: classId,
                    studentEmail: studentEmail,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotAcceptedContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pending Approval'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'You will be able to click on this class after your teacher approves you',
            ),
          ],
        ),
      ),
    );
  }
}
