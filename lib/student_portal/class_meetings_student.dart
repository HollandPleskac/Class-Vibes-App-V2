import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import '../logic/fire.dart';

final _fire = Fire();

final Firestore _firestore = Firestore.instance;

class ClassMeetingsStudent extends StatelessWidget {
  final String classId;
  final String email;

  ClassMeetingsStudent({this.classId,this.email});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: StreamBuilder(
        stream: _firestore
            .collection("UserData")
            .document(email)
            .collection('Meetings')
            .where('class id', isEqualTo: classId)
            .orderBy("timestamp")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.height * 0.035,
                          bottom: MediaQuery.of(context).size.height * 0.032),
                      child: Meeting(
                        className: document['class name'],
                        dateAndTime: document['date and time'],
                        length: document['time'],
                        message: document['content'],
                        studentName: document['student name'],
                        title: document['title'],
                        teacherName: document['teacher name'],
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: NoDocsMeetingsClassStudent(),
                );
              }
          }
        },
      ),
    );
  }
}

class Meeting extends StatelessWidget {
  final String dateAndTime;
  final String className;
  final String title;
  final String length;
  final String message;
  final String studentName;
  final String teacherName;

  Meeting({
    this.dateAndTime,
    this.className,
    this.title,
    this.length,
    this.message,
    this.studentName,
    this.teacherName,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateAndTime,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'With ' + teacherName,
          overflow: TextOverflow.fade,
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
                      overflow: TextOverflow.fade,
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
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
