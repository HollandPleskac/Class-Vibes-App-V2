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
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(235, 235, 235, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                  DateFormat.Md('en_US').add_jm().format(timestamp).toString(),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                  Text(title,style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                      ),softWrap: true,),
                  SizedBox(height: 5,),
                  Text(message,style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500]
                      ),softWrap: true,),
                ],
              ),
            ),
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[600],
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child:  Text('X',style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[100]
                      ),softWrap: true,),
              ),
            ),
          ),
      ],
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
