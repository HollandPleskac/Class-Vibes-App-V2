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
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no students'),
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
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no students'),
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
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no students'),
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
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no students'),
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
  InactiveTab(this.classId, this.teacherEmail);
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
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                    context: context,
                    classId: classId,
                    teacherEmail: teacherEmail,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no students'),
              );
            }
        }
      },
    );
  }
}

class Student extends StatelessWidget {
  final String name;
  final String status;
  final String profilePictureLink;
  final BuildContext context;
  final String classId;
  final String teacherEmail;

  Student({
    this.name,
    this.status,
    this.profilePictureLink,
    this.context,
    this.classId,
    this.teacherEmail,
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
                      height: 20,
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
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
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
                                left: 20, right: 20, bottom: 10),
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
                                left: 20, right: 20, bottom: 10),
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
                                left: 20, right: 20, bottom: 10),
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
                            padding: EdgeInsets.only(right: 20, bottom: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: kPrimaryColor,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _fire.setupMeeting(
                                      studentUid: 'new@gmail.com',
                                      length: _lengthController.text,
                                      title: _titleController.text,
                                      content: _contentController.text,
                                      dateAndTime: _dateAndTimeController.text,
                                      studentName: 'student name',
                                      teacherUid: teacherEmail,
                                      className: 'AP Physics',
                                      classId: classId,
                                      teacherName: 'teacher name',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            height: 60,
            width: 60,
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
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Container(),
              Text(
                name,
                style: TextStyle(fontSize: 16.5),
              ),
              Text(
                'Last updated: 7 days ago',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Container(),
              Container(),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () => showModalSheet(),
            child: FaIcon(
              FontAwesomeIcons.handshake,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
          SizedBox(
            width: 20,
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
                  'teacher name': 'Mr.Shea',
                  'student uid': 'new@gmail.com',
                  'student name': name
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
            width: 15,
          )
        ],
      ),
    );
  }
}
