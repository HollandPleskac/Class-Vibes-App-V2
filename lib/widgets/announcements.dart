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
    Future<void> _showAlert() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you wish to proceed?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This announcement will be deleted permanently.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  print('delete');
                  _fire.deleteAnnouncement(
                    classId: classId,
                    announcementId: announcementId,
                  );
                  Navigator.pop(context);
                  
                },
              ),
            ],
          );
        },
      );
    }

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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [Spacer()],
                  ),
                  Text(
                    DateFormat.Md('en_US')
                        .add_jm()
                        .format(timestamp)
                        .toString(),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500]),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _showAlert();
          },
          child: Container(
            decoration:
                BoxDecoration(color: Colors.red[600], shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'X',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[100]),
                softWrap: true,
              ),
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

  StudentAnnouncement({
    this.message,
    this.timestamp,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(235, 235, 235, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [Spacer()],
                  ),
                  Text(
                    DateFormat.Md('en_US')
                        .add_jm()
                        .format(timestamp)
                        .toString(),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500]),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
