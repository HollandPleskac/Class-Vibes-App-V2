import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

import './view_class.dart';
import '../constant.dart';
import '../widgets/pie_charts.dart';
import '../nav_teacher.dart';
import '../logic/fire.dart';
import '../widgets/no_documents_message.dart';
import '../widgets/server_down.dart';
import '../widgets/badges.dart';
import '../logic/revenue_cat.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _fire = Fire();
final _revenueCat = RevenueCat();

class ClassViewTeacher extends StatefulWidget {
  @override
  _ClassViewTeacherState createState() => _ClassViewTeacherState();
}

class _ClassViewTeacherState extends State<ClassViewTeacher> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String email = _firebaseAuth.currentUser.email;
  final String uid = _firebaseAuth.currentUser.uid;

  void _showModalSheetEditUserName(String email) {
    showModalBottomSheet(

        isScrollControlled: true,
        enableDrag: true,
        elevation: 0,
        context: context,
        builder: (builder) {
          return BuyClassPopUp(email, uid);
          // located at the bottom of the file
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Application Management')
          .doc('ServerManagement')
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
                    backgroundColor: kPrimaryColor,
                    title: Text(
                      'Classes',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          _showModalSheetEditUserName(email);
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
                          .where('teacher email', isEqualTo: email)
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
                                snapshot.data.docs.isEmpty == false) {
                              return Center(
                                child: GridView.count(
                                  physics: BouncingScrollPhysics(),
                                  primary: false,
                                  padding: const EdgeInsets.all(25),
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  children: snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    return Class(document);
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
    return GestureDetector(
      onTap: (DateTime.parse(document['expire date'].toDate().toString())
                  .compareTo(DateTime.now()) <=
              0)
          ? () {}
          : () {
              Navigator.pushNamed(
                context,
                ViewClass.routeName,
                arguments: {
                  'class name': document['class name'],
                  'class id': document.id,
                  'max days inactive': document['max days inactive'],
                },
              );
            },
      child: StreamBuilder(
        stream: _firestore
            .collection('Classes')
            .doc(document.id)
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
              // if the compareTo() result is negative or 0 class is expired
              // if compareTo() is negative then date on document is less than current date
              if (DateTime.parse(document['expire date'].toDate().toString())
                      .compareTo(DateTime.now()) <=
                  0) {
                // print(document['expire date'].toDate().toString());
                // print(DateTime.parse(document['expire date'].toDate().toString())
                //   .compareTo(DateTime.now()));
                // class is expired
                return ExpiredClass(document['class name']);
              } else {
                if (snapshot.data != null &&
                    snapshot.data.docs.isEmpty == false &&
                    snapshot.data.docs
                        .where((document) => document['accepted'] == true)
                        .isNotEmpty) {
                  // class has students
                  // increment teacher unread count
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    if (snapshot.data.docs[i]['accepted'] == true) {
                      unReadCount =
                          unReadCount + snapshot.data.docs[i]['teacher unread'];
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
                                studentDocuments: snapshot.data.docs,
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
                  // class does not have students
                  return NoStudentsClass(
                    className: document['class name'],
                  );
                }
              }
          }
        },
      ),
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
                  DateTime.parse(documentSnapshot['date'].toDate().toString()),
                )
                .inDays <
            classDocument['max days inactive'])
        .length
        .toDouble();

    double needHelpStudents = studentDocuments
        .where((documentSnapshot) => documentSnapshot['status'] == 'need help')
        .where((document) => document['accepted'] == true)
        .where((documentSnapshot) =>
            DateTime.now()
                .difference(
                  DateTime.parse(documentSnapshot['date'].toDate().toString()),
                )
                .inDays <
            classDocument['max days inactive'])
        .length
        .toDouble();
    double frustratedStudents = studentDocuments
        .where((documentSnapshot) => documentSnapshot['status'] == 'frustrated')
        .where((document) => document['accepted'] == true)
        .where((documentSnapshot) =>
            DateTime.now()
                .difference(
                  DateTime.parse(documentSnapshot['date'].toDate().toString()),
                )
                .inDays <
            classDocument['max days inactive'])
        .length
        .toDouble();
    double inactiveStudents = studentDocuments
        .where((documentSnapshot) =>
            DateTime.now()
                .difference(
                  DateTime.parse(documentSnapshot['date'].toDate().toString()),
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
            textAlign: TextAlign.center,
            softWrap: true,
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

class ExpiredClass extends StatelessWidget {
  final String className;

  ExpiredClass(this.className);
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
                    className + "\n(Expired)",
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    textAlign: TextAlign.center,
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

class BuyClassPopUp extends StatefulWidget {
  final String email;
  final String uid;
  BuyClassPopUp(this.email, this.uid);
  @override
  _BuyClassPopUpState createState() => _BuyClassPopUpState();
}

class _BuyClassPopUpState extends State<BuyClassPopUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _classNameController = TextEditingController();
  bool isCompletedPurchase = false;
  String completedPurchaseMessage = "";
  @override
  Widget build(BuildContext context) {
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: isCompletedPurchase == true
                      ? CompletedPurchase(completedPurchaseMessage)
                      : Column(
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
                                        color: kPrimaryColor,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '1. Purchasing this class will cost \$1.99',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '2. You will have access to this class for 1 year',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '3. After 1 year, your class will expire',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    '4. Classes can\'t be used after they expire',
                                    style: TextStyle(
                                        color: kPrimaryColor,
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
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    controller: _classNameController,
                                    cursorColor: kPrimaryColor,
                                    decoration: InputDecoration(
                                      
                                      errorStyle:
                                          TextStyle(color: kPrimaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[600]),),
                                      hintStyle: TextStyle(
                                        color: kPrimaryColor,
                                        // fontSize: 18,
                                      ),
                                      labelStyle: TextStyle(
                                        color: kPrimaryColor,
                                      ),
                                      hintText: 'Enter a class name',
                                    ),
                                    onChanged: (text) {
                                      setState(() {});
                                    },
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
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: FlatButton(
                                  height: 43,
                                  child: Center(
                                    child: Text(
                                      'Create Class',
                                      style: TextStyle(
                                          color: _classNameController.text == ""
                                              ? Colors.white
                                              : Colors.white,
                                          fontSize: 16,
                                          letterSpacing: 0.1,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  color: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  disabledColor: Colors.grey[600],
                                  onPressed: _classNameController.text == ""
                                      ? null
                                      : () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            List purchaseInfo =
                                                await _revenueCat
                                                    .makePurchase();
                                            // List purchaseInfo = ['success','success'];

                                            if (purchaseInfo[0] != 'success') {
                                              setState(() {
                                                isCompletedPurchase = true;
                                                completedPurchaseMessage =
                                                    purchaseInfo[1];
                                              });
                                            } else {
                                              // successfully made the purchase - now add a class
                                              List result =
                                                  await _fire.addClass(
                                                      className:
                                                          _classNameController
                                                              .text,
                                                      email: widget.email,
                                                      uid: widget.uid);

                                              print('RESULT : ' +
                                                  result.toString());
                                              if (result[0] != 'success') {
                                                setState(() {
                                                  isCompletedPurchase = true;
                                                  completedPurchaseMessage =
                                                      'An error occurred creating the class - Contact Class Vibes for a refund';
                                                });
                                              } else {
                                                _classNameController.clear();
                                                Navigator.pop(context);
                                              }
                                            }
                                          }
                                        },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                )),
          ),
        ],
      ),
    );
  }
}

class CompletedPurchase extends StatelessWidget {
  final String error;
  CompletedPurchase(this.error);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.error,
                  color: kPrimaryColor,
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  'An Error Occurred',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              error,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
