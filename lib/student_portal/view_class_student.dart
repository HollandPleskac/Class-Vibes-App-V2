import 'package:class_vibes_v2/teacher_portal/class_announcements.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import './chat_student.dart';
import './class_meetings_student.dart';
import './class_announcements_student.dart';
import './class_overview.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final Firestore _firestore = Firestore.instance;

class ViewClassStudent extends StatefulWidget {
  static const routename = 'view-class-student-screen';
  @override
  _ViewClassStudentState createState() => _ViewClassStudentState();
}

class _ViewClassStudentState extends State<ViewClassStudent> {
  String _email;

  Future getTeacherEmail() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final email = user.email;

    _email = email;
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
    final String className = routeArguments['class name'];
    final int initialIndex = routeArguments['initial index'];

    return DefaultTabController(
      length: 4,
      initialIndex: initialIndex,
      child: StreamBuilder(
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
                    appBar: AppBar(
                      backgroundColor: kWetAsphaltColor,
                      title: Text(className),
                      centerTitle: true,
                      actions: [
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.trash,
                            size: 19.5,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                      bottom: TabBar(
                        isScrollable: true,
                        tabs: [
                          Tab(text: 'Overview'),
                          Tab(text: 'Chat'),
                          Tab(text: 'Meetings'),
                          Tab(text: 'Announcements'),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        Container(
                          child: ClassOverViewStudent(
                            classId: classId,
                            email: _email,
                          ),
                        ),
                        Container(
                          child: ChatStudent(
                            email: _email,
                            classId: classId,
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
                      ],
                    ),
                  );
          }
        },
      ),
    );
  }
}
