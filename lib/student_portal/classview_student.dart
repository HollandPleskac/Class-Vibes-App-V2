import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import '../logic/fire.dart';
import '../nav_student.dart';
import './view_class_student.dart';
import './chat_student.dart';

final Firestore _firestore = Firestore.instance;
final _fire = Fire();

class ClassViewStudent extends StatefulWidget {
  @override
  _ClassViewStudentState createState() => _ClassViewStudentState();
}

class _ClassViewStudentState extends State<ClassViewStudent> {
  String _email;

  Future getTeacherEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String uid = prefs.getString('email');

    _email = uid;
    print(_email);
  }

  @override
  void initState() {
    getTeacherEmail().then((_) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavStudent(),
      backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text(
          'Screen 3',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                print('press question');
                showStudentInfoPopUp(context);
              },
              child: FaIcon(
                FontAwesomeIcons.question,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: GridView.count(
      //     primary: false,
      //     padding: const EdgeInsets.all(30),
      //     crossAxisSpacing: 15,
      //     mainAxisSpacing: 10,
      //     crossAxisCount: 2,
      //     children: <Widget>[

      //     ],
      //   ),
      // ),
      body: StreamBuilder(
          stream: _firestore
              .collection('UserData')
              .document(_email)
              .collection('Classes')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print('SNAP : ' + snapshot.data.toString());
            if (!snapshot.hasData) {
              return Center(
                child: Container(),
              );
            }

            return Center(
              child: ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return StudentClass(
                    className: document['class name'],
                    classId: document.documentID,
                    email: _email,
                  );
                }).toList(),
              ),
            );
          }),
      // body: Column(
      //   children: classes.map((DocumentSnapshot document) {
      //     return Text(document['class name'].toString());
      //   }).toList(),
      // ),
    );
  }
}

class StudentClass extends StatelessWidget {
  final String className;
  final String classId;
  final String email;

  StudentClass({
    this.className,
    this.classId,
    this.email,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, ViewClassStudent.routename, arguments: {
        'class id': classId,
      }),
      child: Container(
        height: 115,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: 25,
            right: 25,
          ),
          child: Card(
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  className,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                StreamBuilder(
                    stream: _firestore
                        .collection('UserData')
                        .document(email)
                        .collection('Classes')
                        .document(classId)
                        .snapshots(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.data == null) {
                        return Center(
                          child: Container(),
                        );
                      }
                      return SelectStatusRow(
                        classId: classId,
                        lastChangedStatus: snapshot.data['date'],
                        status: snapshot.data['status'],
                        email: email,
                      );
                    }),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
      // Positioned(
      //   top: 0,
      //   right: 0,
      //   child: GestureDetector(
      //     onTap: () {
      //       //           final String classId = routeArguments['class id'];
      //       // final String teacherName = routeArguments['teacher name'];
      //       // final String studentUid = routeArguments['student uid'];
      //       print('tap');
      //       Navigator.pushNamed(context, ChatStudent.routeName, arguments: {
      //         'class id': 'test class app ui',
      //         'teacher name': 'Mr.Shea',
      //         'student uid': 'new@gmail.com',
      //         'student name': 'Kushagra',
      //       });
      //     },
      //     child: FaIcon(
      //       FontAwesomeIcons.solidComments,
      //       size: 50,
      //       color: kPrimaryColor,
      //     ),
      //   ),
      // ),
    );
  }
}

void showStudentInfoPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: Container(
                  width: 300.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(01)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Current Mood",
                        style: TextStyle(
                            fontSize: 24.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "How do you currently feel about class? ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 3 + 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.smile,
                                  size: 43.0,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Doing Great",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.meh,
                                  size: 43.0,
                                  color: Colors.orange[600],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  " Need Help ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.orange[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.frown,
                                  size: 43.0,
                                  color: Colors.red[700],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Frustrated",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[500].withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      );
    },
  );
}

class SelectStatusRow extends StatefulWidget {
  final String classId;
  final Timestamp lastChangedStatus;
  final String status;
  final String email;

  SelectStatusRow({
    this.classId,
    this.lastChangedStatus,
    this.status,
    this.email,
  });
  @override
  _SelectStatusRowState createState() => _SelectStatusRowState();
}

class _SelectStatusRowState extends State<SelectStatusRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _fire.updateStudentMood(
                uid: widget.email,
                classId: widget.classId,
                newMood: 'doing great');
            print('changing status');
          },
          child: DateTime.now()
                      .difference(
                        DateTime.parse(
                            widget.lastChangedStatus.toDate().toString()),
                      )
                      .inDays >=
                  5
              ? FaIcon(
                  FontAwesomeIcons.smile,
                  color: Colors.grey,
                  size: 36,
                )
              : FaIcon(
                  widget.status == 'doing great'
                      ? FontAwesomeIcons.solidSmile
                      : FontAwesomeIcons.smile,
                  color: Colors.green,
                  size: 36,
                ),
        ),
        // FaIcon(
        //   FontAwesomeIcons.smile,
        //   color: Colors.green,
        //   size: 36,
        // ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            _fire.updateStudentMood(
                uid: widget.email,
                classId: widget.classId,
                newMood: 'need help');
            print('changing status');
          },
          child: DateTime.now()
                      .difference(
                        DateTime.parse(
                            widget.lastChangedStatus.toDate().toString()),
                      )
                      .inDays >=
                  5
              ? FaIcon(
                  FontAwesomeIcons.meh,
                  color: Colors.grey,
                  size: 36,
                )
              : FaIcon(
                  widget.status == 'need help'
                      ? FontAwesomeIcons.solidMeh
                      : FontAwesomeIcons.meh,
                  color: Colors.yellow[800],
                  size: 36,
                ),
        ),
        // FaIcon(
        //   FontAwesomeIcons.meh,
        //   color: Colors.yellow[800],
        //   size: 36,
        // ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            _fire.updateStudentMood(
                uid: widget.email,
                classId: widget.classId,
                newMood: 'frustrated');
            print('changing status');
          },
          child: DateTime.now()
                      .difference(
                        DateTime.parse(
                            widget.lastChangedStatus.toDate().toString()),
                      )
                      .inDays >=
                  5
              ? FaIcon(
                  FontAwesomeIcons.frown,
                  color: Colors.grey,
                  size: 36,
                )
              : FaIcon(
                  widget.status == 'frustrated'
                      ? FontAwesomeIcons.solidFrown
                      : FontAwesomeIcons.frown,
                  color: Colors.red,
                  size: 36,
                ),
        ),
        // FaIcon(
        //   FontAwesomeIcons.frown,
        //   color: Colors.red,
        //   size: 36,
        // ),
      ],
    );
  }
}
