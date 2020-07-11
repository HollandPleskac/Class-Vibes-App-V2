import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import '../widgets/pie_charts.dart';
import '../nav_teacher.dart';
import 'view_class.dart';
import 'class_settings.dart';

final Firestore _firestore = Firestore.instance;

class ClassViewTeacher extends StatefulWidget {
  @override
  _ClassViewTeacherState createState() => _ClassViewTeacherState();
}

class _ClassViewTeacherState extends State<ClassViewTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavTeacher(),
      // backgroundColor: Color.fromRGBO(252, 252, 252, 1.0),
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text(
          'Teacher Classes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
            stream: _firestore
                .collection('UserData')
                .document('new1@gmail.com')
                .collection('Classes')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Container(),
                );
              }

              return Center(
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.all(40),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,

                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ViewClass.routeName,
                          arguments: {
                            'class name': document['class name'],
                          },
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            // color: Colors.red,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DynamicPieChart(),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: Text(
                                        document['class name'],
                                        style: kSubTextStyle.copyWith(
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   top: 0,
                          //   right: 0,
                          //   child: GestureDetector(
                          //     onTap: () => Navigator.pushNamed(
                          //       context,
                          //       ClassSettings.routeName,
                          //       arguments: {
                          //         'class name': document['class name']
                          //       },
                          //     ),
                          //     child: Container(
                          //       height: 38,
                          //       width: 38,
                          //       decoration: BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         color: kPrimaryColor,
                          //       ),
                          //       child: Center(
                          //         child: FaIcon(
                          //           FontAwesomeIcons.cog,
                          //           color: Colors.white,
                          //           size: 20,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
      ),
    );
  }
}

class DynamicPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('Classes')
            .document('test class app ui')
            .collection('Students')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(),
            );
          }

          final double doingGreatStudents = snapshot.data.documents
              .where((document) => document["status"] == "doing great")
              .where((documentSnapshot) =>
                  DateTime.now()
                      .difference(
                        DateTime.parse(
                            documentSnapshot.data['date'].toDate().toString()),
                      )
                      .inDays <
                  5)
              .length
              .toDouble();
          var needHelpStudents = snapshot.data.documents
              .where((documentSnapshot) =>
                  documentSnapshot.data['status'] == 'need help')
              .where((documentSnapshot) =>
                  DateTime.now()
                      .difference(
                        DateTime.parse(
                            documentSnapshot.data['date'].toDate().toString()),
                      )
                      .inDays <
                  5)
              .length
              .toDouble();
          var frustratedStudents = snapshot.data.documents
              .where((documentSnapshot) =>
                  documentSnapshot.data['status'] == 'frustrated')
              .where((documentSnapshot) =>
                  DateTime.now()
                      .difference(
                        DateTime.parse(
                            documentSnapshot.data['date'].toDate().toString()),
                      )
                      .inDays <
                  5)
              .length
              .toDouble();
          var inactiveStudents = snapshot.data.documents
              .where((documentSnapshot) =>
                  DateTime.now()
                      .difference(
                        DateTime.parse(
                            documentSnapshot.data['date'].toDate().toString()),
                      )
                      .inDays >=
                  5)
              .length
              .toDouble();
          return PieChartSampleSmall(
            //graph percentage
            doingGreatStudents: doingGreatStudents,
            needHelpStudents: needHelpStudents,
            frustratedStudents: frustratedStudents,
            inactiveStudents: inactiveStudents,
          );
        });
  }
}
