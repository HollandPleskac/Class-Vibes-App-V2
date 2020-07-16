import 'package:class_vibes_v2/teacher_portal/class_announcements.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import './chat_student.dart';
import './class_meetings_student.dart';
import './class_announcements_student.dart';
import './class_overview.dart';

class ViewClassStudent extends StatefulWidget {
  static const routename = 'view-class-student-screen';
  @override
  _ViewClassStudentState createState() => _ViewClassStudentState();
}

class _ViewClassStudentState extends State<ViewClassStudent> {
  String _email;

  Future getTeacherEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String uid = prefs.getString('email');

    _email = uid;
    print(_email);
  }

  Future getClassId() async {}

  @override
  void initState() {
    getTeacherEmail().then((_) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context).settings.arguments as Map;
    final String classId = routeArguments['class id'];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kWetAsphaltColor,
          title: Text('className'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Meetings'),
              Tab(text: 'Announcements'),
              Tab(
                text: 'Chat',
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(
            child: ClassOverViewStudent(
              classId: classId,
              email: _email,
            ),
          ),
          Container(
            child: ClassMeetingsStudent(
              classId: classId,
            ),
          ),
          Container(
            child: ClassAnnouncementsStudent(
              classId: classId,
            ),
          ),
          Container(
            child: ChatStudent(
              email: _email,
              classId: classId,
            ),
          ),
        ]),
      ),
    );
  }
}
