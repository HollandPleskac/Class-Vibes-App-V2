//Announcements
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logic/fire.dart';
import '../constant.dart';

final _fire = Fire();

class TeacherAnnouncement extends StatelessWidget {
  final String message;
  final DateTime timestamp;
  final String announcementId;
  final String classId;
  final String title;

  TeacherAnnouncement({
    this.message,
    this.timestamp,
    this.announcementId,
    this.classId,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(235, 235, 235, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  message,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Text(
            DateFormat.yMMMMd('en_US').add_jm().format(timestamp).toString(),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              print('delete');
              _fire.deleteAnnouncement(
                classId: classId,
                announcementId: announcementId,
              );
            },
            child: FaIcon(
              FontAwesomeIcons.trash,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class StudentAnnouncement extends StatelessWidget {
  final String message;
  final String title;
  final DateTime timestamp;
  final String announcementId;

  StudentAnnouncement({
    this.message,
    this.timestamp,
    this.announcementId,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(235, 235, 235, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  message,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Text(
            DateFormat.yMMMMd('en_US').add_jm().format(timestamp).toString(),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
         
        ],
      ),
    );
  }
}
