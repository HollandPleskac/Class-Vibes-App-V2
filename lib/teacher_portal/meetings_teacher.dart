import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logic/fire.dart';

final _fire = Fire();

final Firestore _firestore = Firestore.instance;

class MeetingsTeacher extends StatefulWidget {
  @override
  _MeetingsTeacherState createState() => _MeetingsTeacherState();
}

class _MeetingsTeacherState extends State<MeetingsTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetings Teacher'),
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('UserData')
              .document('new1@gmail.com')
              .collection('Meetings')
              .orderBy("timestamp", descending: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(),
              );
            }

            return Center(
              child: ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 20, bottom: 30),
                    child: Meeting(
                      className: document['class name'],
                      dateAndTime: document['date and time'],
                      length: document['time'],
                      message: document['content'],
                      studentName: document['student name'],
                      title: document['title'],
                    ),
                  );
                }).toList(),
              ),
            );
          }),
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

  Meeting({
    this.dateAndTime,
    this.className,
    this.title,
    this.length,
    this.message,
    this.studentName,
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
          height: 120,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 120,
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
                      height: 90,
                      width: 3.5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 120,
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
                      height: 40,
                      width: 100,
                      color: kPrimaryColor.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          length,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 19,
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
                    teacherUid: 'new1@gmail.com',
                    meetingId: 'random meeting id',
                    classId: 'test class app ui',
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
