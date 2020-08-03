import 'package:class_vibes_v2/teacher_portal/class_announcements.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import './chat_student.dart';
import './class_meetings_student.dart';
import './class_announcements_student.dart';
import '../archived/class_overview.dart';
import '../logic/fire.dart';
import '../student_portal/classview_student.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final Firestore _firestore = Firestore.instance;

final _fire = Fire();

class ViewClassStudent extends StatefulWidget {
  static const routename = 'view-class-student-screen';
  @override
  _ViewClassStudentState createState() => _ViewClassStudentState();
}

class _ViewClassStudentState extends State<ViewClassStudent> {
  Future<void> _showAlert(String classId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you wish to proceed?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Chat History, Announcements, and Meetings will all be deleted.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Go Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Leave Class',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                _fire.leaveClass(
                  classId: classId,
                  studentEmail: _email,
                );
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClassViewStudent(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  String _email;

  Future getStudentEmail() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final email = user.email;

    _email = email;
  }

  Future getClassId() async {}

  @override
  void initState() {
    getStudentEmail().then((_) {
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
      length: 3,
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
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print(_email);
                          _fire.resetStudentUnreadCount(
                            classId: classId,
                            studentEmail: _email,
                            
                          );
                          Navigator.pop(context);
                        },
                      ),
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
                          onPressed: () {
                            _showAlert(classId);
                          },
                        ),
                      ],
                      bottom: TabBar(
                        isScrollable: true,
                        tabs: [
                          // Tab(text: 'Overview'),
                          Tab(text: 'Live Chat'),
                          Tab(text: 'Meetings'),
                          Tab(text: 'Announcements'),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        // Container(
                        //   child: ClassOverViewStudent(
                        //     classId: classId,
                        //     email: _email,
                        //   ),
                        // ),
                        Container(
                          child: ChatStudent(
                            email: _email,
                            classId: classId,
                          ),
                        ),
                        Container(
                          child: ClassMeetingsStudent(
                            classId: classId,
                            email: _email,
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
