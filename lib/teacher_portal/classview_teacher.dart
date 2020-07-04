import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import '../widgets/pie_charts.dart';
import 'individual_class_teacher.dart';

final Firestore _firestore = Firestore.instance;

class ClassViewTeacher extends StatefulWidget {
  @override
  _ClassViewTeacherState createState() => _ClassViewTeacherState();
}

class _ClassViewTeacherState extends State<ClassViewTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(252, 252, 252, 1.0),
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text(
          'Screen 2',
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
                      primary: false,
                      padding: const EdgeInsets.all(40),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              IndividualClassTeacher.routeName,
                              arguments: {
                                'class name': document['ClassName'],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        PieChartSampleSmall(),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 25),
                                          child: Text(
                                            document['ClassName'],
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
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    print('tap');
                                  },
                                  borderRadius: BorderRadius.circular(3000),
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kPrimaryColor,
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.cog,
                                        color: Colors.white,
                                        size: 20,
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
                    child: Text('no data'),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
