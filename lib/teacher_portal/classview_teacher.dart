import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import '../widgets/pie_charts.dart';
import '../nav_teacher.dart';
import '../logic/fire.dart';
import 'view_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'class_settings.dart';
import '../widgets/no_documents_message.dart';
import 'package:flutter_svg/svg.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _fire = Fire();

class ClassViewTeacher extends StatefulWidget {
  @override
  _ClassViewTeacherState createState() => _ClassViewTeacherState();
}

class _ClassViewTeacherState extends State<ClassViewTeacher> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _classNameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showModalSheetEditUserName(String email) {
    showModalBottomSheet(
        barrierColor: Colors.white.withOpacity(0),
        isScrollControlled: true,
        elevation: 0,
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Create a Class',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: TextFormField(
                              controller: _classNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(126, 126, 126, 1),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                ),
                                hintText: 'class name',
                                icon: FaIcon(
                                  FontAwesomeIcons.chalkboard,
                                  color: Colors.grey[500],
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value == '') {
                                  return 'Class name cannot be blank';
                                } else if (value.length > 16) {
                                  return 'Class name cannot be greater than 16 characters';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 20,
                          ),
                          child: FlatButton(
                            color: kPrimaryColor,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                print('validated');
                                List result = await _fire.addClass(
                                    className: _classNameController.text,
                                    uid: email);
                                print('RESULT : ' + result.toString());
                                if (result[0] != 'success') {
                                  Navigator.pop(context);
                                  final snackBar = SnackBar(
                                    content: Text(result[1]),
                                    action: SnackBarAction(
                                      label: 'Hide',
                                      onPressed: () {
                                        _scaffoldKey.currentState
                                            .hideCurrentSnackBar();
                                      },
                                    ),
                                  );

                                  _scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                } else {
                                  _classNameController.text = '';
                                  Navigator.pop(context);
                                }
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Create',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  String _email;

  Future getTeacherEmail() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final email = user.email;

    _email = email;
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
    return StreamBuilder(
      stream: _firestore
          .collection('Application Management')
          .document('ServerManagement')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        } else {
          return snapshot.data['serversAreUp'] == false
              ? Center(
                  child: Text(
                    'Servers are down',
                    style: TextStyle(color: Colors.grey[800], fontSize: 18),
                  ),
                )
              : Scaffold(
                  key: _scaffoldKey,
                  drawer: NavTeacher(),
                  // backgroundColor: Color.fromRGBO(252, 252, 252, 1.0),
                  appBar: AppBar(
                    backgroundColor: kWetAsphaltColor,
                    title: Text(
                      'Teacher Classes',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                    actions: [
                      StreamBuilder(
                        stream: _firestore
                            .collection('Application Management')
                            .document('ServerManagement')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('');
                          } else {
                            return snapshot.data['serversAreUp'] == false
                                ? Container()
                                : IconButton(
                                    onPressed: () {
                                      _showModalSheetEditUserName(_email);
                                    },
                                    icon: Icon(Icons.add),
                                  );
                          }
                        },
                      )
                    ],
                  ),
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder(
                      stream: _firestore
                          .collection('UserData')
                          .document(_email)
                          .collection('Classes')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              return Center(
                                child: GridView.count(
                                  physics: BouncingScrollPhysics(),
                                  primary: false,
                                  padding: const EdgeInsets.all(25),
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  children: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          ViewClass.routeName,
                                          arguments: {
                                            'class name':
                                                document['class name'],
                                            'class id': document.documentID,
                                            'max days inactive': document['max days inactive'],
                                          },
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            // color: Colors.red,
                                            width: double.infinity,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Card(
                                                child: Center(
                                                  child: DynamicPieChart(
                                                    classId:
                                                        document.documentID,
                                                        className: document['class name'],
                                                        maxDaysInactive: document['max days inactive'],
                                                  ),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            } else {
                              return Center(
                                child: NoDocsClassViewTeacher(),
                              );
                            }
                        }
                      },
                    ),
                  ),
                );
        }
      },
    );
  }
}

class DynamicPieChart extends StatelessWidget {
  final String classId;
  final String className;
  final int maxDaysInactive;

  DynamicPieChart({
    this.classId,
    this.className,
    this.maxDaysInactive,
  });
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document(classId)
          .collection('Students')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: AspectRatio(aspectRatio: 1.6),
            );
          default:
            if (snapshot.data != null &&
                snapshot.data.documents.isEmpty == false) {
              double doingGreatStudents = snapshot.data.documents
                  .where((document) => document["status"] == "doing great")
                  .where((documentSnapshot) =>
                      DateTime.now()
                          .difference(
                            DateTime.parse(documentSnapshot.data['date']
                                .toDate()
                                .toString()),
                          )
                          .inDays <
                      maxDaysInactive)
                  .length
                  .toDouble();

              double needHelpStudents = snapshot.data.documents
                  .where((documentSnapshot) =>
                      documentSnapshot.data['status'] == 'need help')
                  .where((documentSnapshot) =>
                      DateTime.now()
                          .difference(
                            DateTime.parse(documentSnapshot.data['date']
                                .toDate()
                                .toString()),
                          )
                          .inDays <
                      maxDaysInactive)
                  .length
                  .toDouble();
              double frustratedStudents = snapshot.data.documents
                  .where((documentSnapshot) =>
                      documentSnapshot.data['status'] == 'frustrated')
                  .where((documentSnapshot) =>
                      DateTime.now()
                          .difference(
                            DateTime.parse(documentSnapshot.data['date']
                                .toDate()
                                .toString()),
                          )
                          .inDays <
                      maxDaysInactive)
                  .length
                  .toDouble();
              double inactiveStudents = snapshot.data.documents
                  .where((documentSnapshot) =>
                      DateTime.now()
                          .difference(
                            DateTime.parse(documentSnapshot.data['date']
                                .toDate()
                                .toString()),
                          )
                          .inDays >=
                      maxDaysInactive)
                  .length
                  .toDouble();

              double totalStudents = doingGreatStudents +
                  needHelpStudents +
                  frustratedStudents +
                  inactiveStudents.toDouble();

              var doingGreatPercentage =
                  (doingGreatStudents / totalStudents * 100)
                          .toStringAsFixed(0) +
                      '%';
              var needHelpPercentage =
                  (needHelpStudents / totalStudents * 100).toStringAsFixed(0) +
                      '%';
              var frustratedPercentage =
                  (frustratedStudents / totalStudents * 100)
                          .toStringAsFixed(0) +
                      '%';
              var inactivePercentage =
                  (inactiveStudents / totalStudents * 100).toStringAsFixed(0) +
                      '%';

              print('doing great : ' + doingGreatStudents.toString());
              print('need help : ' + needHelpStudents.toString());
              print('frustrated : ' + frustratedStudents.toString());
              print('inactive : ' + inactiveStudents.toString());
              print('totla : ' + totalStudents.toString());
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PieChartSampleSmall(
                    //graph percentage
                    doingGreatStudents: doingGreatStudents,
                    needHelpStudents: needHelpStudents,
                    frustratedStudents: frustratedStudents,
                    inactiveStudents: inactiveStudents,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.0225,right: 10, left: 10),
                    child: Text(
                      className,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: kSubTextStyle.copyWith(fontSize:  MediaQuery.of(context).size.width*0.037),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/undraw_analytics_5pgy.svg',
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      className,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: kSubTextStyle.copyWith(fontSize: MediaQuery.of(context).size.width*0.037),
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }
}
