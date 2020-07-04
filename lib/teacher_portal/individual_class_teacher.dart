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
          Container(
            height: 32.5,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Button(name: 'All',isTouched: false,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(name: 'Doing Great',isTouched: false,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(name: 'Need Help',isTouched: true,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(name: 'Frustrated',isTouched: false,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Button(name: 'Inactive',isTouched: false,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String name;
  final bool isTouched;

  Button({this.name,this.isTouched});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isTouched == true? Color.fromRGBO(225, 225, 225, 1) : Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      // height: 35,
      width: 92.5,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: isTouched == true? Colors.blue[600] : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 13.5),
        ),
      ),
    );
  }
}
