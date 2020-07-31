import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../teacher_portal/chat_teacher.dart';
import '../logic/fire.dart';
import '../constant.dart';

final Firestore _firestore = Firestore.instance;
final _fire = Fire();

class AllTab extends StatelessWidget {
  final String classId;
  final String teacherEmail;
  AllTab(this.classId, this.teacherEmail);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document(classId)
          .collection('Students')
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
  DoingGreatTab(this.classId, this.teacherEmail);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document(classId)
          .collection('Students')
          .where("status", isEqualTo: 'doing great')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: 5),
            ),
          )
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
  NeedHelpTab(this.classId, this.teacherEmail);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document(classId)
          .collection('Students')
          .where("status", isEqualTo: 'need help')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: 5),
            ),
          )
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
  FrustratedTab(this.classId, this.teacherEmail);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document(classId)
          .collection('Students')
          .where("status", isEqualTo: 'frustrated')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: 5),
            ),
          )
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

  InactiveTab(
    this.classId,
    this.teacherEmail,
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document(classId)
          .collection('Students')
          .where(
            "date",
            isLessThan: DateTime.now().subtract(
              Duration(days: 5),
            ),
          )
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

  Student({
    this.status,
    this.profilePictureLink,
    this.context,
    this.classId,
    this.teacherEmail,
    this.studentEmail,
  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _dateAndTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showModalSheet() {
    showModalBottomSheet(
      barrierColor: Colors.white.withOpacity(0),
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
                    color: Colors.grey.shade300.withOpacity(0.5),
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
                                icon: FaIcon(FontAwesomeIcons.speakap),
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
                                icon: FaIcon(FontAwesomeIcons.speakap),
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
                                icon: FaIcon(FontAwesomeIcons.speakap),
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
                                icon: FaIcon(FontAwesomeIcons.speakap),
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
                                  print('COURSE NAME ::::::: ' + courseName);
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
      return 'Last updated: a few seconds ago';
    } else if (DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inHours <=
        0) {
      // date in minutes
      return 'Last updated: ' +
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
      return 'Last updated: ' +
          DateTime.now()
              .difference(
                DateTime.parse(lastUpdate.toDate().toString()),
              )
              .inHours
              .toString() +
          ' hours ago';
    } else {
      // date in days

      return 'Last updated: ' +
          DateTime.now()
              .difference(
                DateTime.parse(lastUpdate.toDate().toString()),
              )
              .inDays
              .toString() +
          ' days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: profilePictureLink == null
                ? Center(
                    child: FaIcon(
                      FontAwesomeIcons.userAlt,
                      color: kPrimaryColor,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                        profilePictureLink,
                      ),
                    ),
                  ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Column(
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
          Spacer(),
          GestureDetector(
            onTap: () => showModalSheet(),
            child: FaIcon(
              FontAwesomeIcons.paperPlane,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.075,
          ),
          GestureDetector(
            onTap: () {
              // final String classId = routeArguments['class id'];
              // final String teacherName = routeArguments['teacher name'];
              // final String teacherUid = routeArguments['student uid'];
              // final String studentName = routeArguments['student name'];
              print('press');
              Navigator.pushNamed(
                context,
                ChatTeacher.routeName,
                arguments: {
                  'class id': classId,
                  'student uid': studentEmail,
                },
              );
            },
            child: FaIcon(
              FontAwesomeIcons.solidComments,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          )
        ],
      ),
    );
  }
}
