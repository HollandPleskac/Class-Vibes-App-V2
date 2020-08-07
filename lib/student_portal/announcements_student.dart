import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../nav_student.dart';
import '../constant.dart';
import '../widgets/no_documents_message.dart';
import '../widgets/announcements.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class AnnouncementsStudent extends StatefulWidget {
  @override
  _AnnouncementsStudentState createState() => _AnnouncementsStudentState();
}

class _AnnouncementsStudentState extends State<AnnouncementsStudent> {
  List classIds = [];
  List announcements = [];
  String _email;
  bool waiting = true;

  Future getTeacherEmail() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final email = user.email;

    _email = email;
  }

  Future getAnnouncements(String email) async {
    //change this setup to be double streambuilder ??
    List<DocumentSnapshot> classDocuments = await _firestore
        .collection('UserData')
        .document(email)
        .collection('Classes')
        .getDocuments()
        .then((querySnap) => querySnap.documents);

    classDocuments.forEach((DocumentSnapshot document) {
      classIds.add(document.documentID);
    });

    for (var i = 0; i < classIds.length; i++) {
      List announcementDocuments = await _firestore
          .collection('Classes')
          .document(classIds[i])
          .collection('Announcements')
          .getDocuments()
          .then((querySnap) => querySnap.documents);

      announcementDocuments.forEach((document) {
        announcements.add(document.data);
      });

      announcements.sort((a, b) {
        return b['date'].compareTo(a['date']);
      });
    }
    waiting = false;
  }

  @override
  void initState() {
    getTeacherEmail().then((_) {
      getAnnouncements(_email).then((_) {
        setState(() {});
        print('Announcements : ' + announcements.toString());
      });
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
                    title: Text('Announcements'),
                    centerTitle: true,
                    backgroundColor: kWetAsphaltColor,
                  ),
                  body: waiting == true
                      ? Center(
                          child: Container(),
                        )
                      : Center(
                          child: announcements.length != 0
                              ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                  itemCount: announcements.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          left: 40,
                                          right: 40,
                                          bottom: 20),
                                      child: StudentAnnouncement(
                                        message: announcements[index]
                                            ['message'],
                                        title: announcements[index]['title'],
                                        timestamp: DateTime.parse(
                                            announcements[index]['date']
                                                .toDate()
                                                .toString()),
                                      ),
                                    );
                                  },
                                )
                              // ? ListView(
                              //     children: announcements.map(
                              //       (announcement) {
                              //         return Padding(
                              //           padding: EdgeInsets.only(
                              //               top: 20,
                              //               left: 40,
                              //               right: 40,
                              //               bottom: 20),
                              //           child: StudentAnnouncement(
                              //             message: announcement['message'],
                              //             title: announcement['title'],
                              //             timestamp: DateTime.parse(
                              //                 announcement['date']
                              //                     .toDate()
                              //                     .toString()),

                              //           ),
                              //         );
                              //       },
                              //     ).toList(),
                              //   )
                              : Center(
                                  child: NoDocsAnnouncementsStudent(),
                                ),
                        ),
                );
        }
      },
    );
  }
}
