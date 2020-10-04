import 'package:class_vibes_v2/constant.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../nav_teacher.dart';
import '../widgets/no_documents_message.dart';
import '../widgets/meetings.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


class MeetingsTeacher extends StatefulWidget {
  @override
  _MeetingsTeacherState createState() => _MeetingsTeacherState();
}

class _MeetingsTeacherState extends State<MeetingsTeacher> {
  String _teacherEmail;

  Future getTeacherEmail() async {
    final User user = _firebaseAuth.currentUser;
    final email = user.email;

    _teacherEmail = email;
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
          .doc('ServerManagement')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        } else {
          return snapshot.data['serversAreUp'] == false
              ? ServersDown()
              : Scaffold(
                  drawer: NavTeacher(),
                  appBar: AppBar(
                    title: Text('Meetings'),
                    backgroundColor: kPrimaryColor,
                    centerTitle: true,
                  ),
                  body: StreamBuilder(
                    stream: _firestore
                        .collection('UserData')
                        .doc(_teacherEmail)
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
                              snapshot.data.docs.isEmpty == false) {
                            return ListView(
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.05,
                                      right: MediaQuery.of(context).size.width *
                                          0.05,
                                      top: MediaQuery.of(context).size.height *
                                          0.035,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.032),
                                  child: TeacherMeeting(
                                    dateAndTime: document['date and time'],
                                    length: document['length'],
                                    message: document['message'],
                                    title: document['title'],
                                    teacherEmail: _teacherEmail,
                                    classId: document['class id'],
                                    meetingId: document.id,
                                    studentEmail: document['recipient'],
                                    courseName: document['course'],
                                    isAllDisplay: true,
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return Center(
                              child: NoDocsMeetingsTeacher(),
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

