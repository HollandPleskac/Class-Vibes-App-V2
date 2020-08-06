import 'package:class_vibes_v2/teacher_portal/class_announcements.dart';
import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../logic/fire.dart';
import '../widgets/announcements.dart';

final Firestore _firestore = Firestore.instance;
final _fire = Fire();

class ClassAnnouncementsStudent extends StatelessWidget {
  final String classId;
  ClassAnnouncementsStudent({this.classId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection("Classes")
          .document(classId)
          .collection('Announcements')
          .orderBy("date", descending: true).limit(50)
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
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    child: StudentAnnouncement(
                      message: snapshot.data.documents[index]['message'],
                      title: snapshot.data.documents[index]['title'],
                      timestamp: DateTime.parse(snapshot
                          .data.documents[index]['date']
                          .toDate()
                          .toString()),
                    ),
                  );
                },
              );
              // return ListView(
              //   physics: BouncingScrollPhysics(),
              //   children:
              //       snapshot.data.documents.map((DocumentSnapshot document) {
              //     return Padding(
              //       padding: EdgeInsets.only(
              //           top: 20, left: 20, right: 20, bottom: 20),
              //       child: StudentAnnouncement(
              //         message:document['message'],
              //         title: document['title'],
              //         timestamp: DateTime.parse(document['date'].toDate().toString()),
              //       ),
              //     );
              //   }).toList(),
              // );
            } else {
              return Center(
                child: NoDocsAnnouncementsClassStudent(),
              );
            }
        }
      },
    );
  }
}
