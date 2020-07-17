import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../nav_student.dart';
import '../constant.dart';

final Firestore _firestore = Firestore.instance;

class AnnouncementsStudent extends StatefulWidget {
  @override
  _AnnouncementsStudentState createState() => _AnnouncementsStudentState();
}

class _AnnouncementsStudentState extends State<AnnouncementsStudent> {
  List classIds = [];
  List announcements = [];
  String _email;

  Future getTeacherEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String uid = prefs.getString('email');

    _email = uid;
    print(_email);
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
        return b['timestamp'].compareTo(a['timestamp']);
      });
    }
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
    return Scaffold(
      drawer: NavStudent(),
      appBar: AppBar(
        title: Text('Student Announcements'),
        centerTitle: true,
        backgroundColor: kWetAsphaltColor,
      ),
      // body: Column(
      //   children: announcements
      //       .map(
      //         (announcement) => Text(
      //           announcement['title'],
      //         ),
      //       )
      //       .toList(),
      // ),
      body: Center(
        child: announcements.length != 0
            ? ListView(
                children: announcements.map(
                  (announcement) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: 20, left: 40, right: 40, bottom: 20),
                      child: Announcement(
                        announcement['content'],
                        DateTime.parse(
                            announcement['timestamp'].toDate().toString()),
                      ),
                    );
                  },
                ).toList(),
              )
            : Center(
                child: Text('no announcements'),
              ),
      ),
    );
  }
}

class Announcement extends StatelessWidget {
  final String message;
  final DateTime timestamp;

  Announcement(this.message, this.timestamp);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(235, 235, 235, 1),
      ),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 8,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7.5,
                ),
                Text(
                  DateFormat.yMMMMd('en_US')
                      .add_jm()
                      .format(timestamp)
                      .toString(),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
