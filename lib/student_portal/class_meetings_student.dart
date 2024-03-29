import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/meetings.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            .doc(email)
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
                  snapshot.data.docs.isEmpty == false) {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children:
                      snapshot.data.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                          top: MediaQuery.of(context).size.height * 0.035,
                          bottom: MediaQuery.of(context).size.height * 0.032),
                      child: StudentMeeting(
                        dateAndTime: document['date and time'],
                        length: document['length'],
                        message: document['message'],
                        title: document['title'],
                        courseName: document['course'],
                        isAllDisplay: false,
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

