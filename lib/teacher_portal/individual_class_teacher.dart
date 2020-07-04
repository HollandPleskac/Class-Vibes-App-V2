import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  child: Button(
                    name: 'All',
                    isTouched: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(
                    name: 'Doing Great',
                    isTouched: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(
                    name: 'Need Help',
                    isTouched: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Button(
                    name: 'Frustrated',
                    isTouched: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Button(
                    name: 'Inactive',
                    isTouched: false,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 360,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Student(name: 'Holland Pleskac', status: 'Doing Great'),
                Student(name: 'Shabd Veyyakula', status: 'Need Help'),
                Student(name: 'Kushagra Singh', status: 'Inactive'),
                Student(name: 'Pranav Krishna', status: 'Frustrated'),
                Student(name: 'Advithi Kethidi', status: 'Inactive'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String name;
  final bool isTouched;

  Button({this.name, this.isTouched});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isTouched == true
              ? Color.fromRGBO(225, 225, 225, 1)
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(20)),
      // height: 35,
      width: 92.5,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: isTouched == true ? Colors.blue[600] : Colors.grey[700],
              fontWeight: FontWeight.w600,
              fontSize: 13.5),
        ),
      ),
    );
  }
}

class Student extends StatelessWidget {
  final String name;
  final String status;

  Student({this.name, this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: FaIcon(FontAwesomeIcons.userAlt),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Container(),
              Text(
                name,
                style: TextStyle(fontSize: 16.5),
              ),
              Text(
                'Last updated: 7 days ago',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Container(),
              Container(),
            ],
          ),
          Spacer(),
          FaIcon(
            FontAwesomeIcons.solidComments,
            color: kPrimaryColor,
            size: 35,
          ),
          SizedBox(width: 20,)
        ],
      ),
    );
  }
}
