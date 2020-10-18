import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';
import '../logic/fire.dart';
import './classview_teacher.dart';

final _fire = Fire();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ClassSettings extends StatefulWidget {
  static const routeName = 'individual-class-settings-teacher';
  final String classId;
  final String email;
  ClassSettings({
    this.classId,
    this.email,
  });
  @override
  _ClassSettingsState createState() => _ClassSettingsState();
}

class _ClassSettingsState extends State<ClassSettings> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        .doc(widget.classId)
        .get()
        .then((docSnap) => docSnap['allow join']);
    print('initial val of switch ' + initialSwitchVal.toString());
    isSwitched = initialSwitchVal;
  }

  Future getDaysInactive() async {
    int daysInactive = await _firestore
        .collection("Classes")
        .doc(widget.classId)
        .get()
        .then((docSnap) => docSnap['max days inactive']);
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
          ClassCode(widget.classId),
          SizedBox(height: 25),
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
            height: 20,
          ),
          InactiveDaysPicker(maxDaysInactive, widget.email, widget.classId,
              (int value) {
            setState(() {
              isUpdated = true;
              maxDaysInactive = value;
            });
          }),
          SizedBox(
            height: 20,
          ),
          IsAcceptingJoin(
            isSwitched: isSwitched,
            updateSwitch: () {
              setState(() {
                isSwitched == false ? isSwitched = true : isSwitched = false;
                isUpdated = true;
              });
            },
            classId: widget.classId,
            email: widget.email,
          ),
          Spacer(),
          isUpdated == false
              ? Container()
              : UpdateClassDetails(
                  classId: widget.classId,
                  teacherEmail: widget.email,
                  isClassNameUpdated: isClassNameUpdated,
                  allowJoin: isSwitched,
                  maxDaysInactive: maxDaysInactive,
                  updateClassNameAndFeedback: () {
                    if (isClassNameUpdated) {
                      setState(() {
                        if (_classNameController.text == null ||
                            _classNameController.text == '') {
                          feedback = "Class name cannot be blank";
                        } else if (_classNameController.text.length > 25) {
                          feedback =
                              "Class name cannot be greater than 25 characters";
                        } else {
                          feedback = "";
                          _fire.updateClassName(widget.email, widget.classId,
                              _classNameController.text);
                        }
                      });
                    } else {
                      setState(() {
                        feedback = "";
                      });
                    }
                    // Timer(Duration(milliseconds: 250), () {
                    setState(() {
                      isUpdated = false;
                      isClassNameUpdated = false;
                      // feedback = "";
                    });
                    // });
                  },
                ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            feedback,
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DeleteClass(
                classId: widget.classId,
                teacherEmail: widget.email,
              ),
              StreamBuilder(
                stream: _firestore
                    .collection("Classes")
                    .doc(widget.classId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('no data');
                  } else {
                    return Text(
                      'Class Expires on : ' +
                          DateFormat.yMMMd('en_US')
                              .format(DateTime.parse(snapshot
                                  .data['expire date']
                                  .toDate()
                                  .toString()))
                              .toString(),
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    );
                  }
                },
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
        SizedBox(width: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.725,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Edit Class Name',
              labelStyle: TextStyle(fontSize: 16, color: kWetAsphaltColor),
              icon: FaIcon(FontAwesomeIcons.globe),
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
          width: 60,
        ),
      ],
    );
  }
}

class UpdateClassDetails extends StatelessWidget {
  final String classId;
  final String teacherEmail;
  final bool isClassNameUpdated;
  final int maxDaysInactive;
  final bool allowJoin;
  final Function updateClassNameAndFeedback;

  UpdateClassDetails({
    this.classId,
    this.teacherEmail,
    this.isClassNameUpdated,
    this.maxDaysInactive,
    this.allowJoin,
    this.updateClassNameAndFeedback,
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
        color: kPrimaryColor,
        onPressed: () async {
          _fire.updateAllowJoin(teacherEmail, classId, allowJoin);
          _fire.updateMaxDaysInactive(teacherEmail, classId, maxDaysInactive);
          updateClassNameAndFeedback();
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
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.red,
        onPressed: () async {
          _showAlert();
        },
      ),
    );
  }
}

class InactiveDaysPicker extends StatefulWidget {
  final int maxDaysInactive;
  final String email;
  final String classId;
  final Function updateMaxDaysInactive;
  InactiveDaysPicker(
    this.maxDaysInactive,
    this.email,
    this.classId,
    this.updateMaxDaysInactive,
  );
  @override
  _InactiveDaysPickerState createState() => _InactiveDaysPickerState();
}

class _InactiveDaysPickerState extends State<InactiveDaysPicker> {
  Future<void> _showExplainMaxInactiveDaysPopup() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Information'),
          content: Text(
            'Set the minimum number of days for your students to choose a status. Students who don\'t select will show up as gray on your graph.',
            style: TextStyle(
              height: 1.75,
            ),
          ),
        );
      },
    );
  }

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
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: FaIcon(
            FontAwesomeIcons.questionCircle,
            color: kWetAsphaltColor,
          ),
          onTap: _showExplainMaxInactiveDaysPopup,
        ),
        Spacer(),
        widget.maxDaysInactive == null
            ? CircularProgressIndicator()
            : NumberPicker.integer(
                initialValue: widget.maxDaysInactive,
                minValue: 7,
                maxValue: 14,
                onChanged: (value) {
                  widget.updateMaxDaysInactive(value);
                },
              ),
        Spacer(),
      ],
    );
  }
}

class ClassCode extends StatefulWidget {
  final String classId;

  ClassCode(this.classId);
  @override
  _ClassCodeState createState() => _ClassCodeState();
}

class _ClassCodeState extends State<ClassCode> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Class Code',
          style: TextStyle(
            color: kWetAsphaltColor,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.classId.split("").map((letter) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.5),
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
