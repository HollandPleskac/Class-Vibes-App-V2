import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';

import '../constant.dart';

class ClassSettings extends StatefulWidget {
  static const routeName = 'individual-class-settings-teacher';
  @override
  _ClassSettingsState createState() => _ClassSettingsState();
}

class _ClassSettingsState extends State<ClassSettings> {
  final TextEditingController _classNameController = TextEditingController();

  var isSwitched = false;
  int daysInactive = 3;
  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context).settings.arguments as Map;
    final String className = routeArguments['class name'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(className),
        centerTitle: true,
        backgroundColor: kWetAsphaltColor,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            EditClassName(
              controller: _classNameController,
            ),
            SizedBox(
              height: 50,
            ),
            IsAcceptingJoin(isSwitched),
            SizedBox(
              height: 50,
            ),
            ClassCode(),
            // SizedBox(
            //   height: 25,
            // ),
            InactiveDaysPicker(daysInactive),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenerateNewClassCode(),
                SizedBox(
                  width: 20,
                ),
                DeleteClass(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
          width: MediaQuery.of(context).size.width * 0.725,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Class Name',
              labelStyle: TextStyle(fontSize: 16, color: kWetAsphaltColor),
            ),
          ),
        ),
        Spacer(),
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color

            child: InkWell(
              splashColor: Colors.blue,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.check,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              onTap: () {
                print('updated the class name');
              },
            ),
          ),
        ),
        SizedBox(
          width: 25,
        ),
      ],
    );
  }
}

class IsAcceptingJoin extends StatefulWidget {
  final bool isSwitched;

  IsAcceptingJoin(
    this.isSwitched,
  );

  @override
  _IsAcceptingJoinState createState() => _IsAcceptingJoinState(isSwitched);
}

class _IsAcceptingJoinState extends State<IsAcceptingJoin> {
  bool isSwitched;

  _IsAcceptingJoinState(this.isSwitched);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          'Allow students to join',
          style: TextStyle(
            color: kWetAsphaltColor,
            fontSize: 18,
          ),
        ),
        Spacer(),
        CupertinoSwitch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
          activeColor: kPrimaryColor,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

class DeleteClass extends StatefulWidget {
  @override
  _DeleteClassState createState() => _DeleteClassState();
}

class _DeleteClassState extends State<DeleteClass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text(
          'Delete Class',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.grey[300],
        onPressed: () {
          print('deleting class');
        },
      ),
    );
  }
}

class GenerateNewClassCode extends StatefulWidget {
  @override
  _GenerateNewClassCodeState createState() => _GenerateNewClassCodeState();
}

class _GenerateNewClassCodeState extends State<GenerateNewClassCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text(
          'New Class Code',
          style: TextStyle(color: kPrimaryColor, fontSize: 16),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.grey[300],
        onPressed: () {
          print('new class code');
        },
      ),
    );
  }
}

class InactiveDaysPicker extends StatefulWidget {
  final int daysInactive;
  InactiveDaysPicker(this.daysInactive);
  @override
  _InactiveDaysPickerState createState() =>
      _InactiveDaysPickerState(daysInactive);
}

class _InactiveDaysPickerState extends State<InactiveDaysPicker> {
  int daysInactive;
  _InactiveDaysPickerState(this.daysInactive);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          'Student Inactive Days',
          style: TextStyle(fontSize: 18, color: kWetAsphaltColor),
        ),
        Spacer(),
        NumberPicker.integer(
          scrollDirection: Axis.horizontal,
          initialValue: daysInactive,
          minValue: 1,
          maxValue: 7,
          onChanged: (newValue) {
            setState(() {
              daysInactive = newValue;
            });
          },
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

class ClassCode extends StatefulWidget {
  @override
  _ClassCodeState createState() => _ClassCodeState();
}

class _ClassCodeState extends State<ClassCode> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          'Class Code',
          style: TextStyle(
            color: kWetAsphaltColor,
            fontSize: 18,
          ),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'L',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              color: kPrimaryColor,
              height: 2,
              width: 25,
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'K',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              color: kPrimaryColor,
              height: 2,
              width: 25,
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '1',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              color: kPrimaryColor,
              height: 2,
              width: 25,
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'D',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              color: kPrimaryColor,
              height: 2,
              width: 25,
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '9',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              color: kPrimaryColor,
              height: 2,
              width: 25,
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              color: kPrimaryColor,
              height: 2,
              width: 25,
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
