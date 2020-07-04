import 'package:flutter/material.dart';

import '../widgets/pie_charts.dart';
import '../constant.dart';

class IndividualClassTeacher extends StatefulWidget {
  static final routeName = 'individual-class-teacher';
  @override
  _IndividualClassTeacherState createState() => _IndividualClassTeacherState();
}

class _IndividualClassTeacherState extends State<IndividualClassTeacher> {
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
          PieChartSampleBig(),
        ],
      ),
    );
  }
}
