import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import '../logic/fire.dart';
import '../widgets/meetings.dart';

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
                      child: StudentMeeting(
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

