import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../nav_student.dart';

final Firestore _firestore = Firestore.instance;

class AnnouncementsStudent extends StatefulWidget {
  @override
  _AnnouncementsStudentState createState() => _AnnouncementsStudentState();
}

class _AnnouncementsStudentState extends State<AnnouncementsStudent> {
  List classIds = [];
  List announcements = [];
  Future getAnnouncements() async {
    List<DocumentSnapshot> classDocuments = await _firestore
        .collection('UserData')
        .document('new@gmail.com')
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
    }
  }

  @override
  void initState() {
    getAnnouncements().then((_) {
      setState(() {});
      print(announcements);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavStudent(),
      appBar: AppBar(
        title: Text('Student Announcements'),
        centerTitle: true,
        backgroundColor: kWetAsphaltColor,
      ),
      body: Text('view announcements that are sent to you'),
    );
  }
}
