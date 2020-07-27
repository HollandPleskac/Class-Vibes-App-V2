import 'package:class_vibes_v2/teacher_portal/class_announcements.dart';
import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../logic/fire.dart';

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
          .orderBy("date", descending: true)
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
                        top: 20, left: 40, right: 40, bottom: 20),
                    child: Announcement(
                      message:document['title'],
                      timestamp: DateTime.parse(document['date'].toDate().toString()),
                      announcementId: document.documentID,
                    ),
                  );
                }).toList(),
              );
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

class Announcement extends StatelessWidget {
  final String message;
  final DateTime timestamp;
  final String announcementId;

  Announcement({this.message, this.timestamp,this.announcementId});
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(235, 235, 235, 1),
      ),
      child: Row(
        children: [
          Container(
            height:MediaQuery.of(context).size.height*0.15,
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
