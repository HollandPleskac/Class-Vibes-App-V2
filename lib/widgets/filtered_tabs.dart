import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../teacher_portal/chat_teacher.dart';
import '../logic/fire.dart';
import './badges.dart';
import '../constant.dart';
import '../logic/class_vibes_server.dart';

final Firestore _firestore = Firestore.instance;
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
          .document(classId)
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
            if (snapshot.data != null &&
                snapshot.data.documents.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.documentID,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
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
          .document(classId)
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
            if (snapshot.data != null &&
                snapshot.data.documents.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.documentID,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
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
          .document(classId)
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
            if (snapshot.data != null &&
                snapshot.data.documents.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.documentID,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
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
          .document(classId)
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
            if (snapshot.data != null &&
                snapshot.data.documents.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.documentID,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
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
          .document(classId)
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
            if (snapshot.data != null &&
                snapshot.data.documents.isEmpty == false) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                    studentEmail: document.documentID,
                    lastChangedStatus: document['date'],
                    teacherUnread: document['teacher unread'],
                    maxDaysInactive: maxDaysInactive,
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
  final BuildContext context;
  final String classId;
  final String teacherEmail;
  final String studentEmail;
  final Timestamp lastChangedStatus;
  final int teacherUnread;
  final int maxDaysInactive;

  Student({
    this.status,
    this.profilePictureLink,
    this.context,
    this.classId,
    this.teacherEmail,
    this.studentEmail,
    this.lastChangedStatus,
    this.teacherUnread,
    this.maxDaysInactive,
  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _dateAndTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showModalSheet() {
    showModalBottomSheet(
      barrierColor: Colors.grey[300].withOpacity(0.3),
      elevation: 0,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                bottom: MediaQuery.of(context).size.height *
                                    0.0125),
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
                                bottom: MediaQuery.of(context).size.height *
                                    0.0125),
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
                                bottom: MediaQuery.of(context).size.height *
                                    0.0125),
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
                                icon:
                                    FaIcon(FontAwesomeIcons.facebookMessenger),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.05,
                                right: MediaQuery.of(context).size.width * 0.05,
                                bottom: MediaQuery.of(context).size.height *
                                    0.0125),
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
                                bottom: MediaQuery.of(context).size.height *
                                    0.0125),
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
                                      .document(classId)
                                      .get()
                                      .then((docSnap) =>
                                          docSnap.data['class name']);
                                  if (_formKey.currentState.validate()) {
                                    _fire.setupMeeting(
                                      studentUid: studentEmail,
                                      length: _lengthController.text,
                                      title: _titleController.text,
                                      content: _contentController.text,
                                      dateAndTime: _dateAndTimeController.text,
                                      teacherUid: teacherEmail,
                                      classId: classId,
                                      timestampId: DateTime.now(),
                                      courseName: courseName,
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'Setup',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
      },
    );
  }

  String lastUpdatedStatus(Timestamp lastUpdate) {
    if (DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inMinutes <=
        0) {
      // date in seconds
      return 'Updated a few seconds ago';
    } else if (DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inHours <=
        0) {
      // date in minutes
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
      // date in hours
      return 'Updated ' +
          DateTime.now()
              .difference(
                DateTime.parse(lastUpdate.toDate().toString()),
              )
              .inHours
              .toString() +
          ' hours ago';
    } else {
      // date in days

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

  Future<void> _showInfo() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Email : ' + studentEmail),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Remove',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      print('remove student from class');
                      _classVibesServer.removeFromClass(
                        classId: classId,
                        studentEmail: studentEmail,
                        teacherEmail: teacherEmail,
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showInfo();
      },
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.01,
            right: MediaQuery.of(context).size.width * 0.02,
            child: UnreadMessageBadge(teacherUnread),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.09,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.height * 0.075,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: DateTime.now()
                              .difference(
                                DateTime.parse(
                                    lastChangedStatus.toDate().toString()),
                              )
                              .inDays >=
                          maxDaysInactive
                      ? Center(
                          child: FaIcon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.grey,
                          ),
                        )
                      : status == 'doing great'
                          ? Center(
                              child: FaIcon(
                                FontAwesomeIcons.userAlt,
                                color: Colors.green,
                              ),
                            )
                          : status == 'need help'
                              ? Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.userAlt,
                                    color: Colors.yellow[800],
                                  ),
                                )
                              : Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.userAlt,
                                    color: Colors.red,
                                  ),
                                ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(),
                      Container(),
                      StreamBuilder(
                          stream: _firestore
                              .collection('UserData')
                              .document(studentEmail)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('');
                            } else {
                              return Text(
                                snapshot.data['display name'],
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(fontSize: 16.5),
                              );
                            }
                          }),
                      StreamBuilder(
                          stream: _firestore
                              .collection('Classes')
                              .document(classId)
                              .collection('Students')
                              .document(studentEmail)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('');
                            } else {
                              return Text(
                                lastUpdatedStatus(snapshot.data['date']),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              );
                            }
                          }),
                      Container(),
                      Container(),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => showModalSheet(),
                  child: FaIcon(
                    FontAwesomeIcons.calendarAlt,
                    color: kPrimaryColor,
                    size: MediaQuery.of(context).size.width * 0.075,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.055,
                ),
                GestureDetector(
                  onTap: () {
                    _fire.resetTeacherUnreadCount(
                      classId: classId,
                      studentEmail: studentEmail,
                    );
                    print('going to chat as a teacher');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatTeacher(
                            classId: classId,
                            studentEmail: studentEmail,
                          ),
                        ));
                  },
                  child: FaIcon(
                    FontAwesomeIcons.solidComments,
                    color: kPrimaryColor,
                    size: MediaQuery.of(context).size.width * 0.075,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.07,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
