// meetings
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logic/fire.dart';
import '../constant.dart';

final _fire = Fire();

class TeacherMeeting extends StatelessWidget {
  final String dateAndTime;
  final String title;
  final String length;
  final String message;
  final String teacherEmail;
  final String classId;
  final String studentEmail;
  final String meetingId;
  final String courseName;
  final bool isAllDisplay;

  TeacherMeeting({
    this.dateAndTime,
    this.title,
    this.length,
    this.message,
    this.teacherEmail,
    this.classId,
    this.studentEmail,
    this.meetingId,
    this.courseName,
    this.isAllDisplay,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isAllDisplay == true
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    courseName,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            : Container(),
        Row(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.135,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  width: 7,
                ),
              ],
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dateAndTime,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('delete meeting');
                            _fire.deleteMeeting(
                              studentUid: studentEmail,
                              teacherUid: teacherEmail,
                              meetingId: meetingId,
                              classId: classId,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red[600], shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'X',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[100]),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      message,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
 
  }
}

class StudentMeeting extends StatelessWidget {
  final String dateAndTime;
  final String title;
  final String length;
  final String message;
  final String courseName;
  final bool isAllDisplay;

  StudentMeeting({
    this.dateAndTime,
    this.title,
    this.length,
    this.message,
    this.courseName,
    this.isAllDisplay,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isAllDisplay == true
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    courseName,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            : Container(),
        Row(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.115,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  width: 7,
                ),
              ],
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      dateAndTime,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      message,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
