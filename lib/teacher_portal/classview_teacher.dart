import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';
import '../widgets/pie_charts.dart';

final Firestore _firestore = Firestore.instance;

class ClassViewTeacher extends StatefulWidget {
  @override
  _ClassViewTeacherState createState() => _ClassViewTeacherState();
}

class _ClassViewTeacherState extends State<ClassViewTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              PieChartSampleSmall(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 25),
                                child: Text(
                                  'Ap Biology',
                                  style: kSubTextStyle.copyWith(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
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
