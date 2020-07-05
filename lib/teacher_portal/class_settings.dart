import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';

class ClassSettings extends StatefulWidget {
  static const routeName = 'individual-class-settings-teacher';
  @override
  _ClassSettingsState createState() => _ClassSettingsState();
}

class _ClassSettingsState extends State<ClassSettings> {
  final TextEditingController _classNameController = TextEditingController();

  var isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context).settings.arguments as Map;
    final String className = routeArguments['class name'];

    return Scaffold(
      appBar: AppBar(
        title: Text(className),
        centerTitle: true,
        backgroundColor: kWetAsphaltColor,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            EditClassName(
              controller: _classNameController,
            ),
            IsAcceptingJoin(isSwitched),
          ],
        ),
      ),
    );
  }
}

class EditClassName extends StatelessWidget {
  final TextEditingController controller;

  EditClassName({this.controller});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Class Name',

              labelStyle: TextStyle(fontSize: 16),
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(width: 80),
              //   borderRadius: BorderRadius.circular(5),
              // ),
            ),
          ),
        ),
        SizedBox(
          width: 25,
        ),
        ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: kPrimaryColor, // inkwell color
              child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.check,
                  ),
                ),
              ),
              onTap: () {
                print('updated the class name');
              },
            ),
          ),
        ),
      ],
    );
  }
}

class IsAcceptingJoin extends StatefulWidget {
  bool isSwitched;

  IsAcceptingJoin(this.isSwitched);

  @override
  _IsAcceptingJoinState createState() => _IsAcceptingJoinState();
}

class _IsAcceptingJoinState extends State<IsAcceptingJoin> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: false,
    );
  }
}
