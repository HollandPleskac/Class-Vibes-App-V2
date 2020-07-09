import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/pie_charts.dart';
import '../widgets/filtered_tabs.dart';
import '../widgets/filter_btns.dart';
import '../constant.dart';

final Firestore _firestore = Firestore.instance;

class ViewClass extends StatefulWidget {
  static const routeName = 'individual-class-teacher';
  @override
  _ViewClassState createState() => _ViewClassState();
}

class _ViewClassState extends State<ViewClass> {
  bool _isTouchedAll = true;
  bool _isTouchedDoingGreat = false;
  bool _isTouchedNeedHelp = false;
  bool _isTouchedFrustrated = false;
  bool _isTouchedInactive = false;

  

  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context).settings.arguments as Map;
    final String className = routeArguments['class name'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text(className),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DynamicPieChart(),
          Container(
            height: 32.5,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: FilterAll(
                    isTouched: _isTouchedAll,
                    onClick: () => setState(() {
                      _isTouchedAll = true;
                      _isTouchedDoingGreat = false;
                      _isTouchedNeedHelp = false;
                      _isTouchedFrustrated = false;
                      _isTouchedInactive = false;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterDoingGreat(
                    isTouched: _isTouchedDoingGreat,
                    onClick: () => setState(() {
                      _isTouchedAll = false;
                      _isTouchedDoingGreat = true;
                      _isTouchedNeedHelp = false;
                      _isTouchedFrustrated = false;
                      _isTouchedInactive = false;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterNeedHelp(
                    isTouched: _isTouchedNeedHelp,
                    onClick: () => setState(() {
                      _isTouchedAll = false;
                      _isTouchedDoingGreat = false;
                      _isTouchedNeedHelp = true;
                      _isTouchedFrustrated = false;
                      _isTouchedInactive = false;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterFrustrated(
                    isTouched: _isTouchedFrustrated,
                    onClick: () => setState(() {
                      _isTouchedAll = false;
                      _isTouchedDoingGreat = false;
                      _isTouchedNeedHelp = false;
                      _isTouchedFrustrated = true;
                      _isTouchedInactive = false;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 10),
                  child: FilterInactive(
                    isTouched: _isTouchedInactive,
                    onClick: () => setState(() {
                      _isTouchedAll = false;
                      _isTouchedDoingGreat = false;
                      _isTouchedNeedHelp = false;
                      _isTouchedFrustrated = false;
                      _isTouchedInactive = true;
                    }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 390,
            child: _isTouchedAll == true
                ? AllTab()
                : _isTouchedDoingGreat
                    ? DoingGreatTab()
                    : _isTouchedNeedHelp
                        ? NeedHelpTab()
                        : _isTouchedFrustrated
                            ? FrustratedTab()
                            : _isTouchedInactive
                                ? InactiveTab()
                                : Text(
                                    'IMPORTANT - this text will never show since one of the first values will always be true'),
          ),
        ],
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
                      .inDays >
                  5)
              .length
              .toDouble();
          var totalStudents = doingGreatStudents +
              needHelpStudents +
              frustratedStudents +
              inactiveStudents.toDouble();

          var doingGreatPercentage =
              (doingGreatStudents / totalStudents * 100).toStringAsFixed(0) +
                  '%';
          var needHelpPercentage =
              (needHelpStudents / totalStudents * 100).toStringAsFixed(0) + '%';
          var frustratedPercentage =
              (frustratedStudents / totalStudents * 100).toStringAsFixed(0) +
                  '%';
          var inactivePercentage =
              (inactiveStudents / totalStudents * 100).toStringAsFixed(0) + '%';

          if (!snapshot.hasData) {
            return Text('no data');
          }

          // if (snapshot.data != null &&
          //     snapshot.data.documents.isEmpty == false) {
          return PieChartSampleBig(
            //graph percentage
            doingGreatStudents: doingGreatStudents,
            needHelpStudents: needHelpStudents,
            frustratedStudents: frustratedStudents,
            inactiveStudents: inactiveStudents,
            //graph titles
            doingGreatPercentage: doingGreatPercentage,
            needHelpPercentage: needHelpPercentage,
            frustratedPercentage: frustratedPercentage,
            inactivePercentage: inactivePercentage,
          );
          // } else {
          //   return Center(
          //     child: Text('no data'),
          //   );
          // }
        });
  }
}
