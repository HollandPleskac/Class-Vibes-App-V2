import 'package:class_vibes_v2/constant.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/no_documents_message.dart';
import '../nav_student.dart';
import '../widgets/meetings.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class MeetingsStudent extends StatefulWidget {
  @override
  _MeetingsStudentState createState() => _MeetingsStudentState();
}

class _MeetingsStudentState extends State<MeetingsStudent> {
  String _email;

  Future getTeacherEmail() async {
    final User user = _firebaseAuth.currentUser;
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
                  drawer: NavStudent(),
                  appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: kPrimaryColor,
                    title: Text('Meetings'),
                  ),
                  body: StreamBuilder(
                    stream: _firestore
                        .collection('UserData')
                        .document(_email)
                        .collection('Meetings')
                        .orderBy("timestamp", descending: false)
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
                              snapshot.data.documents.isEmpty == false) {
                            return ListView(
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.1,
                                      right: MediaQuery.of(context).size.width *
                                          0.1,
                                      top: MediaQuery.of(context).size.height *
                                          0.035,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.032),
                                  child: StudentMeeting(
                                    dateAndTime: document['date and time'],
                                    length: document['length'],
                                    message: document['message'],
                                    title: document['title'],
                                    courseName: document['course'],
                                    isAllDisplay: true,
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return Center(
                              child: NoDocsMeetingsStudent(),
                            );
                          }
                      }
                    },
                  ),
                );
        }
      },
    );
  }
}
