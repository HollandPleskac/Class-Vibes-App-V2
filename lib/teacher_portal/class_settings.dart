import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';
import '../logic/fire.dart';
import './classview_teacher.dart';

final _fire = Fire();
final Firestore _firestore = Firestore.instance;

class ClassSettings extends StatefulWidget {
  static const routeName = 'individual-class-settings-teacher';
  String classId;
  String email;
  ClassSettings({
    this.classId,
    this.email,
  });
  @override
  _ClassSettingsState createState() => _ClassSettingsState();
}

class _ClassSettingsState extends State<ClassSettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _classNameController = TextEditingController();
  bool isSwitched;
  int maxDaysInactive;

  // is updated for updated class btn
  bool isUpdated = false;
  bool isClassNameUpdated = false;
  String feedback = '';

  Future getInitialSwitchValue() async {
    bool initialSwitchVal = await _firestore
        .collection("Classes")
        .document(widget.classId)
        .get()
        .then((docSnap) => docSnap.data['allow join']);
    print('initial val of switch ' + initialSwitchVal.toString());
    isSwitched = initialSwitchVal;
  }

  Future getDaysInactive() async {
    int daysInactive = await _firestore
        .collection("Classes")
        .document(widget.classId)
        .get()
        .then((docSnap) => docSnap.data['max days inactive']);
    maxDaysInactive = daysInactive;
  }

  @override
  void initState() {
    getInitialSwitchValue().then((_) {
      print(isSwitched);
      getDaysInactive().then((_) {
        print(maxDaysInactive);
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          EditClassName(
            controller: _classNameController,
            classId: widget.classId,
            teacherEmail: widget.email,
            updateIsUpdated: () {
              setState(() {
                isClassNameUpdated = true;
                isUpdated = true;
              });
            },
          ),
          SizedBox(
            height: 50,
          ),
          IsAcceptingJoin(
            isSwitched: isSwitched,
            updateSwitch: () {
              setState(() {
                isSwitched == false ? isSwitched = true : isSwitched = false;
              });
            },
            classId: widget.classId,
            email: widget.email,
          ),
          SizedBox(
            height: 50,
          ),
          ClassCode(widget.classId),
          SizedBox(
            height: 25,
          ),
          InactiveDaysPicker(maxDaysInactive, widget.email, widget.classId,
              (int newDaysInactive) {
            // setState(() {
            maxDaysInactive = newDaysInactive;
            print('LOCAL + ' + maxDaysInactive.toString());
            // });
          }),
          Spacer(),
          Text(feedback),
          Spacer(),
          UpdateClassDetails(
            classId: widget.classId,
            teacherEmail: widget.email,
            isUpdated: isUpdated,
            isClassNameUpdated: isClassNameUpdated,
            classNameController: _classNameController,
            updateFeedback: () {
              setState(() {
                if (_classNameController.text == null ||
                    _classNameController.text == '') {
                  feedback = "Class name cannot be blank";
                } else if (_classNameController.text.length > 25) {
                  feedback = "Class name cannot be greater than 25 characters";
                } else {
                  feedback = "updated";
                }
              });
            },
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DeleteClass(
                classId: widget.classId,
                teacherEmail: widget.email,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class EditClassName extends StatelessWidget {
  final TextEditingController controller;
  final String teacherEmail;
  final String classId;
  final Function updateIsUpdated;

  EditClassName({
    this.controller,
    this.teacherEmail,
    this.classId,
    this.updateIsUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.725,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Class Name',
              labelStyle: TextStyle(fontSize: 16, color: kWetAsphaltColor),
            ),
            onChanged: (String value) {
              updateIsUpdated();
            },
          ),
        ),
      ],
    );
  }
}

class IsAcceptingJoin extends StatefulWidget {
  final bool isSwitched;
  final Function updateSwitch;
  final String classId;
  final String email;
  IsAcceptingJoin({
    this.isSwitched,
    this.updateSwitch,
    this.classId,
    this.email,
  });
  @override
  _IsAcceptingJoinState createState() => _IsAcceptingJoinState();
}

class _IsAcceptingJoinState extends State<IsAcceptingJoin> {
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
        widget.isSwitched == null
            ? CircularProgressIndicator()
            : CupertinoSwitch(
                value: widget.isSwitched,
                onChanged: (value) {
                  widget.updateSwitch();
                  _fire.updateAllowJoin(widget.email, widget.classId, value);
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

class UpdateClassDetails extends StatelessWidget {
  final String classId;
  final String teacherEmail;
  final bool isUpdated;
  final bool isClassNameUpdated;
  final TextEditingController classNameController;
  final Function updateFeedback;

  UpdateClassDetails({
    this.classId,
    this.teacherEmail,
    this.isUpdated,
    this.isClassNameUpdated,
    this.classNameController,
    this.updateFeedback,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text(
          'Update Class Details',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: isUpdated ? kPrimaryColor : Color.fromRGBO(200, 200, 200, 1),
        onPressed: () async {
          //            class name feedback
          updateFeedback();
          // _fire.updateClassName(teacherEmail, classId, classNameController.text);
          print('validated');

          // _fire.updateClassName(teacherEmail, classId, controller.text);
          // _fire.updateAllowJoin(widget.email, widget.classId, value);
          // _fire.updateMaxDaysInactive(
          //           widget.email, widget.classId, widget.maxDaysInactive);
          // print('updating details');
        },
      ),
    );
  }
}

class DeleteClass extends StatefulWidget {
  final String classId;
  final String teacherEmail;

  DeleteClass({this.classId, this.teacherEmail});
  @override
  _DeleteClassState createState() => _DeleteClassState();
}

class _DeleteClassState extends State<DeleteClass> {
  Future<void> _showAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you wish to proceed?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deleting the class is final.'),
                Text(
                    'There is no way to recover your class after it has been deleted.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Go Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Delete Class',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await _fire.deleteClass(
                    classId: widget.classId, teacherEmail: widget.teacherEmail);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClassViewTeacher(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

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
        onPressed: () async {
          _showAlert();
        },
      ),
    );
  }
}

class InactiveDaysPicker extends StatefulWidget {
  int maxDaysInactive;
  String email;
  String classId;
  final Function updateLocalMaxInactive;
  InactiveDaysPicker(
    this.maxDaysInactive,
    this.email,
    this.classId,
    this.updateLocalMaxInactive,
  );
  @override
  _InactiveDaysPickerState createState() => _InactiveDaysPickerState();
}

class _InactiveDaysPickerState extends State<InactiveDaysPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          'Max Inactive Days',
          style: TextStyle(fontSize: 18, color: kWetAsphaltColor),
        ),
        Spacer(),
        widget.maxDaysInactive == null
            ? CircularProgressIndicator()
            : NumberPicker.integer(
                initialValue: widget.maxDaysInactive,
                scrollDirection: Axis.vertical,
                minValue: 7,
                maxValue: 14,
                onChanged: (value) {
                  setState(() {
                    widget.maxDaysInactive = value;
                  });
                },
              ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
        ),
      ],
    );
  }
}

class ClassCode extends StatefulWidget {
  String classId;

  ClassCode(this.classId);
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
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: Row(
            children: widget.classId.split("").map((letter) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      letter,
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
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
