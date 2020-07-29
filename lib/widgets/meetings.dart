// meetings
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logic/fire.dart';
import '../constant.dart';


final _fire = Fire();

class TeacherMeeting extends StatelessWidget {
  final String dateAndTime;
  final String className;
  final String title;
  final String length;
  final String message;
  String studentName;
  final String teacherEmail;
  final String classId;

  TeacherMeeting({
    this.dateAndTime,
    this.className,
    this.title,
    this.length,
    this.message,
    this.studentName,
    this.teacherEmail,
    this.classId,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateAndTime,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          className + ' with ' + studentName,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.165,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.125,
                height: MediaQuery.of(context).size.height * 0.165,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 11,
                        ),
                        CircleAvatar(
                          radius: 7.5,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      color: kPrimaryColor,
                      height: MediaQuery.of(context).size.height * 0.115,
                      width: 3.5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.165,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.225,
                      color: kPrimaryColor.withOpacity(0.5),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 7.5, right: 7.5),
                          child: Text(
                            length,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  print('delete meeting');
                  _fire.deleteMeeting(
                    studentUid: 'new@gmail.com',
                    teacherUid: teacherEmail,
                    meetingId: 'random meeting id',
                    classId: classId,
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.trash,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class StudentMeeting extends StatelessWidget {
  final String dateAndTime;
  final String className;
  final String title;
  final String length;
  final String message;
  final String studentName;
  final String teacherName;

  StudentMeeting({
    this.dateAndTime,
    this.className,
    this.title,
    this.length,
    this.message,
    this.studentName,
    this.teacherName,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateAndTime,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'With ' + teacherName,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.165,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.125,
                height: MediaQuery.of(context).size.height * 0.165,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 11,
                        ),
                        CircleAvatar(
                          radius: 7.5,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      color: kPrimaryColor,
                      height: MediaQuery.of(context).size.height * 0.115,
                      width: 3.5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.165,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.225,
                      color: kPrimaryColor.withOpacity(0.5),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 7.5, right: 7.5),
                          child: Text(
                            length,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}