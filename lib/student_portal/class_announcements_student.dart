import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/announcements.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ClassAnnouncementsStudent extends StatelessWidget {
  final String classId;
  ClassAnnouncementsStudent({this.classId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection("Classes")
          .doc(classId)
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
                snapshot.data.docs.isEmpty == false) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    child: StudentAnnouncement(
                      message: snapshot.data.docs[index]['message'],
                      title: snapshot.data.docs[index]['title'],
                      timestamp: DateTime.parse(snapshot
                          .data.docs[index]['date']
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
