import 'package:class_vibes_v2/constant.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../logic/fire.dart';
import '../nav_teacher.dart';
import '../widgets/no_documents_message.dart';

final _fire = Fire();

final Firestore _firestore = Firestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class MeetingsTeacher extends StatefulWidget {
  @override
  _MeetingsTeacherState createState() => _MeetingsTeacherState();
}

class _MeetingsTeacherState extends State<MeetingsTeacher> {
  String _teacherEmail;

  Future getTeacherEmail() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
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
                  appBar: AppBar(
                    title: Text('Meetings Teacher'),
                    backgroundColor: kWetAsphaltColor,
                    centerTitle: true,
                  ),
                  body: StreamBuilder(
                    stream: _firestore
                        .collection('UserData')
                        .document(_teacherEmail)
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
                                  child: Meeting(
                                    className: document['class name'],
                                    dateAndTime: document['date and time'],
                                    length: document['time'],
                                    message: document['content'],
                                    studentName: document['student name'],
                                    title: document['title'],
                                    teacherEmail: _teacherEmail,
                                    classId: document['class id'],
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

class Meeting extends StatelessWidget {
  final String dateAndTime;
  final String className;
  final String title;
  final String length;
  final String message;
  String studentName;
  final String teacherEmail;
  final String classId;

  Meeting({
    this.dateAndTime,
    this.className,
    this.title,
    this.length,
    this.message,
    this.studentName,
    this.teacherEmail,
    this.classId,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateAndTime,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          className + ' with ' + studentName,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.165,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.125,
                height: MediaQuery.of(context).size.height * 0.165,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 11,
                        ),
                        CircleAvatar(
                          radius: 7.5,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      color: kPrimaryColor,
                      height: MediaQuery.of(context).size.height * 0.115,
                      width: 3.5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.165,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.225,
                      color: kPrimaryColor.withOpacity(0.5),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 7.5, right: 7.5),
                          child: Text(
                            length,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  print('delete meeting');
                  _fire.deleteMeeting(
                    studentUid: 'new@gmail.com',
                    teacherUid: teacherEmail,
                    meetingId: 'random meeting id',
                    classId: classId,
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.trash,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
