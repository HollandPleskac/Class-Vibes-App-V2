import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../teacher_portal/chat_teacher.dart';
import '../logic/fire.dart';
import './badges.dart';
import '../constant.dart';
import '../logic/class_vibes_server.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _fire = Fire();
final _classVibesServer = ClassVibesServer();

class AllTab extends StatelessWidget {
  final String classId;
  final String teacherEmail;
  final int maxDaysInactive;
  AllTab(this.classId, this.teacherEmail, this.maxDaysInactive);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .doc(classId)
          .collection('Students')
          .orderBy('date', descending: true)
          .where('accepted', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Container(),
            );
          default:
            if (snapshot.data != null && snapshot.data.docs.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.id,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
                    name: document['name'],
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text(
                  'There are no students in this class',
                  style: TextStyle(
                      height: 2,
                      color: Colors.grey[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              );
            }
        }
      },
    );
  }
}

class DoingGreatTab extends StatelessWidget {
  final String classId;
  final String teacherEmail;
  final int maxDaysInactive;
  DoingGreatTab(this.classId, this.teacherEmail, this.maxDaysInactive);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .doc(classId)
          .collection('Students')
          .orderBy('date', descending: true)
          .where("status", isEqualTo: 'doing great')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: maxDaysInactive),
            ),
          )
          .where('accepted', isEqualTo: true)
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
            if (snapshot.data != null && snapshot.data.docs.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.id,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
                    name: document['name'],
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text(
                  'No students are doing great',
                  style: TextStyle(
                      height: 2,
                      color: Colors.grey[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              );
            }
        }
      },
    );
  }
}

class NeedHelpTab extends StatelessWidget {
  final String classId;
  final String teacherEmail;
  final int maxDaysInactive;
  NeedHelpTab(this.classId, this.teacherEmail, this.maxDaysInactive);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .doc(classId)
          .collection('Students')
          .orderBy('date', descending: true)
          .where("status", isEqualTo: 'need help')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: maxDaysInactive),
            ),
          )
          .where('accepted', isEqualTo: true)
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
            if (snapshot.data != null && snapshot.data.docs.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.id,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
                    name: document['name'],
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text(
                  'No students need help',
                  style: TextStyle(
                      height: 2,
                      color: Colors.grey[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              );
            }
        }
      },
    );
  }
}

class FrustratedTab extends StatelessWidget {
  final String classId;
  final String teacherEmail;
  final int maxDaysInactive;
  FrustratedTab(this.classId, this.teacherEmail, this.maxDaysInactive);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .doc(classId)
          .collection('Students')
          .orderBy('date', descending: true)
          .where("status", isEqualTo: 'frustrated')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: maxDaysInactive),
            ),
          )
          .where('accepted', isEqualTo: true)
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
            if (snapshot.data != null && snapshot.data.docs.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.id,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
                    name: document['name'],
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text(
                  'No students are frustrated',
                  style: TextStyle(
                      height: 2,
                      color: Colors.grey[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              );
            }
        }
      },
    );
  }
}

class InactiveTab extends StatelessWidget {
  final String classId;
  final String teacherEmail;
  final int maxDaysInactive;

  InactiveTab(
    this.classId,
    this.teacherEmail,
    this.maxDaysInactive,
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .doc(classId)
          .collection('Students')
          .orderBy('date')
          .where(
            "date",
            isLessThan: DateTime.now().subtract(
              Duration(days: maxDaysInactive),
            ),
          )
          .where('accepted', isEqualTo: true)
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
            if (snapshot.data != null && snapshot.data.docs.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.id,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
                    name: document['name'],
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text(
                  'No students are inactive',
                  style: TextStyle(
                      height: 2,
                      color: Colors.grey[600],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              );
            }
        }
      },
    );
  }
}

class Student extends StatelessWidget {
  final String status;
  final String profilePictureLink;
  final String classId;
  final String teacherEmail;
  final String studentEmail;
  final Timestamp lastChangedStatus;
  final int teacherUnread;
  final int maxDaysInactive;
  final String name;

  Student({
    this.status,
    this.profilePictureLink,
    this.classId,
    this.teacherEmail,
    this.studentEmail,
    this.lastChangedStatus,
    this.teacherUnread,
    this.maxDaysInactive,
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          right: 3,
          child: UnreadMessageBadge(teacherUnread),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              StudentProfileInfo(
                name: name,
                lastUpdated: getLastUpdatedStatus(lastChangedStatus),
              ),
              StudentActionBtns(
                classId: classId,
                studentEmail: studentEmail,
                teacherEmail: teacherEmail,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StudentProfileInfo extends StatelessWidget {
  final String name;
  final String lastUpdated;

  StudentProfileInfo({this.name, this.lastUpdated});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.03,
              backgroundImage:
                  ExactAssetImage('assets/images/transparent-logo.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(fontSize: 16.5),
              ),
              SizedBox(height: 5),
              Text(
                lastUpdated,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StudentActionBtns extends StatelessWidget {
  final String classId;
  final String studentEmail;
  final String teacherEmail;

  StudentActionBtns({
    @required this.classId,
    @required this.studentEmail,
    @required this.teacherEmail,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.phone,
              size: 20.5,
              color: kWetAsphaltColor,
            ),
            onPressed: () {
              showMeetingPopUp(
                context: context,
                classId: classId,
                studentEmail: studentEmail,
                teacherEmail: teacherEmail,
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 12, left: 2),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidComments,
                size: 25,
                color: kPrimaryColor,
              ),
              onPressed: () {
                _fire.resetTeacherUnreadCount(
                  classId: classId,
                  studentEmail: studentEmail,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatTeacher(
                      classId: classId,
                      studentEmail: studentEmail,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String getLastUpdatedStatus(Timestamp lastUpdate) {
  if (DateTime.now()
          .difference(
            DateTime.parse(lastUpdate.toDate().toString()),
          )
          .inMinutes <=
      0) {
    return 'Updated a few seconds ago';
  } else if (DateTime.now()
          .difference(
            DateTime.parse(lastUpdate.toDate().toString()),
          )
          .inHours <=
      0) {
    return 'Updated ' +
        DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inMinutes
            .toString() +
        ' minutes ago';
  } else if (DateTime.now()
          .difference(
            DateTime.parse(lastUpdate.toDate().toString()),
          )
          .inDays ==
      0) {
    return 'Updated ' +
        DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inHours
            .toString() +
        ' hours ago';
  } else {
    return 'Updated ' +
        DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inDays
            .toString() +
        ' days ago';
  }
}

// for the meeting pop up

void showMeetingPopUp({
  BuildContext context,
  String classId,
  String studentEmail,
  String teacherEmail,
}) {
  showModalBottomSheet(
    barrierColor: Colors.grey[300].withOpacity(0.3),
    elevation: 0,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return MeetingPopUp(
        classId: classId,
        studentEmail: studentEmail,
        teacherEmail: teacherEmail,
      );
    },
  );
}

class MeetingPopUp extends StatefulWidget {
  final String classId;
  final String studentEmail;
  final String teacherEmail;

  MeetingPopUp({
    @required this.classId,
    @required this.studentEmail,
    @required this.teacherEmail,
  });

  @override
  _MeetingPopUpState createState() => _MeetingPopUpState();
}

class _MeetingPopUpState extends State<MeetingPopUp> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _dateAndTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ClipRect(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0125,
                ),
                Text(
                  'Setup a Meeting',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0125,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                            bottom:
                                MediaQuery.of(context).size.height * 0.0125),
                        child: TextFormField(
                          controller: _titleController,
                          // autofocus: true,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'meeting title is required';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(126, 126, 126, 1),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                            ),
                            hintText: 'Title',
                            icon: FaIcon(FontAwesomeIcons.speakerDeck),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                            bottom:
                                MediaQuery.of(context).size.height * 0.0125),
                        child: TextFormField(
                          controller: _dateAndTimeController,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'date/time (Thursday 11:55 pm) is requred';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(126, 126, 126, 1),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                            ),
                            hintText: 'Date/Time',
                            icon: FaIcon(FontAwesomeIcons.clock),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                            bottom:
                                MediaQuery.of(context).size.height * 0.0125),
                        child: TextFormField(
                          controller: _contentController,
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'message is requred';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(126, 126, 126, 1),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                            ),
                            hintText: 'Message',
                            icon: FaIcon(FontAwesomeIcons.facebookMessenger),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                            bottom:
                                MediaQuery.of(context).size.height * 0.0125),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'meeting length (ex. 2 hours) is required';
                            } else {
                              return null;
                            }
                          },
                          controller: _lengthController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(126, 126, 126, 1),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey[700],
                            ),
                            hintText: 'Length',
                            icon: FaIcon(FontAwesomeIcons.businessTime),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05,
                            bottom:
                                MediaQuery.of(context).size.height * 0.0125),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: kPrimaryColor,
                            onPressed: () async {
                              String courseName = await _firestore
                                  .collection('Classes')
                                  .doc(widget.classId)
                                  .get()
                                  .then((docSnap) => docSnap['class name']);
                              if (_formKey.currentState.validate()) {
                                _fire.setupMeeting(
                                  studentUid: widget.studentEmail,
                                  length: _lengthController.text,
                                  title: _titleController.text,
                                  content: _contentController.text,
                                  dateAndTime: _dateAndTimeController.text,
                                  teacherUid: widget.teacherEmail,
                                  classId: widget.classId,
                                  timestampId: DateTime.now(),
                                  courseName: courseName,
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Setup',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      // commented out this sized box
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.35,
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
