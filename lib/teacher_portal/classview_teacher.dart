import 'dart:ui';

import 'package:class_vibes_v2/teacher_portal/paywall.dart';
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
import '../widgets/server_down.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/badges.dart';
import '../logic/revenue_cat.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _fire = Fire();
final _revenueCat = RevenueCat();

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
        enableDrag: true,
        elevation: 0,
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Create a Class',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '1. Purchasing this class will cost \$1.99',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '2. You will have access to this class for 1 year',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '3. After 1 year, your class will expire',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '4. Classes can\'t be used after they expire',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[300],
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: _classNameController,
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.white),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        hintText: 'Class Name',
                                      ),
                                      validator: (value) {
                                        if (value == null || value == '') {
                                          return 'Class name cannot be blank';
                                        } else if (value.length > 25) {
                                          return 'Class name cannot be greater than 25 characters';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    print('validated');

                                    await _revenueCat.makePurchase();
                                    List result = await _fire.addClass(
                                        className: _classNameController.text,
                                        uid: email);
                                    _classNameController.text = '';
                                    Navigator.pop(context);
                                    print('RESULT : ' + result.toString());
                                    // if (result[0] != 'success') {
                                    //   Navigator.pop(context);
                                    //   final snackBar = SnackBar(
                                    //     content: Text(result[1]),
                                    //     action: SnackBarAction(
                                    //       label: 'Hide',
                                    //       onPressed: () {
                                    //         _scaffoldKey.currentState
                                    //             .hideCurrentSnackBar();
                                    //       },
                                    //     ),
                                    //   );

                                    //   _scaffoldKey.currentState
                                    //       .showSnackBar(snackBar);
                                    // } else {
                                    //   _classNameController.text = '';
                                    //   Navigator.pop(context);
                                    //   await _revenueCat.makePurchase();
                                    // }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                    height: 43,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          'Create Class',
                                          style: TextStyle(
                                              color: Colors.blueGrey[600],
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: kAppBarColor.withOpacity(1),
                            borderRadius: BorderRadius.circular(8)),
                      )),
                ),
              ],
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
              ? ServersDown()
              : Scaffold(
                  key: _scaffoldKey,
                  drawer: NavTeacher(),
                  // backgroundColor: Color.fromRGBO(252, 252, 252, 1.0),
                  appBar: AppBar(
                    backgroundColor: kAppBarColor,
                    title: Text(
                      'Classes',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          _showModalSheetEditUserName(_email);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder(
                      stream: _firestore
                          .collection('Classes')
                          .where('teacher email', isEqualTo: _email)
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
                                            'max days inactive':
                                                document['max days inactive'],
                                          },
                                        );
                                      },
                                      child: Class(document),
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

class Class extends StatelessWidget {
  final DocumentSnapshot document;

  Class(this.document);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document(document.documentID)
          .collection('Students')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        int unReadCount = 0;
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
                snapshot.data.documents.isEmpty == false &&
                snapshot.data.documents
                    .where((document) => document['accepted'] == true)
                    .isNotEmpty) {
              for (int i = 0; i < snapshot.data.documents.length; i++) {
                if (snapshot.data.documents[i]['accepted'] == true) {
                  unReadCount = unReadCount +
                      snapshot.data.documents[i]['teacher unread'];
                }
              }
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: DynamicPieChart(
                            // the document is class document
                            // student documents is all the student email documents in class
                            studentDocuments: snapshot.data.documents,
                            classDocument: document,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.015,
                    right: MediaQuery.of(context).size.width * 0.03,
                    child: UnreadMessageBadge(unReadCount),
                  ),
                ],
              );
            } else {
              return NoStudentsClass(
                className: document['class name'],
              );
            }
        }
      },
    );
  }
}

class DynamicPieChart extends StatelessWidget {
  // student documents are from classes --> class --> students
  final List<DocumentSnapshot> studentDocuments;
  // classDocument is from classes --> class
  final DocumentSnapshot classDocument;

  DynamicPieChart({
    this.studentDocuments,
    this.classDocument,
  });
  @override
  Widget build(BuildContext context) {
    double doingGreatStudents = studentDocuments
        .where((document) => document["status"] == "doing great")
        .where((document) => document['accepted'] == true)
        .where((documentSnapshot) =>
            DateTime.now()
                .difference(
                  DateTime.parse(
                      documentSnapshot.data['date'].toDate().toString()),
                )
                .inDays <
            classDocument['max days inactive'])
        .length
        .toDouble();

    double needHelpStudents = studentDocuments
        .where((documentSnapshot) =>
            documentSnapshot.data['status'] == 'need help')
        .where((document) => document['accepted'] == true)
        .where((documentSnapshot) =>
            DateTime.now()
                .difference(
                  DateTime.parse(
                      documentSnapshot.data['date'].toDate().toString()),
                )
                .inDays <
            classDocument['max days inactive'])
        .length
        .toDouble();
    double frustratedStudents = studentDocuments
        .where((documentSnapshot) =>
            documentSnapshot.data['status'] == 'frustrated')
        .where((document) => document['accepted'] == true)
        .where((documentSnapshot) =>
            DateTime.now()
                .difference(
                  DateTime.parse(
                      documentSnapshot.data['date'].toDate().toString()),
                )
                .inDays <
            classDocument['max days inactive'])
        .length
        .toDouble();
    double inactiveStudents = studentDocuments
        .where((documentSnapshot) =>
            DateTime.now()
                .difference(
                  DateTime.parse(
                      documentSnapshot.data['date'].toDate().toString()),
                )
                .inDays >=
            classDocument['max days inactive'])
        .where((document) => document['accepted'] == true)
        .length
        .toDouble();

    double totalStudents = doingGreatStudents +
        needHelpStudents +
        frustratedStudents +
        inactiveStudents.toDouble();
    print(doingGreatStudents);
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
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.0225,
              right: 10,
              left: 10),
          child: Text(
            classDocument['class name'],
            overflow: TextOverflow.fade,
            softWrap: false,
            style: kSubTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.037),
          ),
        ),
      ],
    );
  }
}

class NoStudentsClass extends StatelessWidget {
  final String className;

  NoStudentsClass({this.className});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/svg/undraw_empty_xct9.svg',
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
                    style: kSubTextStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.037),
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
