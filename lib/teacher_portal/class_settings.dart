import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';
import '../logic/fire.dart';

final _fire = Fire();
final Firestore _firestore = Firestore.instance;

class ClassSettings extends StatefulWidget {
  static const routeName = 'individual-class-settings-teacher';
  final String classId;
  ClassSettings({this.classId});
  @override
  _ClassSettingsState createState() => _ClassSettingsState();
}

class _ClassSettingsState extends State<ClassSettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _classNameController = TextEditingController();
  bool isSwitched;
  int maxDaysInactive;

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
            height: 50,
          ),
          EditClassName(
            controller: _classNameController,
          ),
          SizedBox(
            height: 50,
          ),
          IsAcceptingJoin(isSwitched, () {
            setState(() {
              isSwitched == false ? isSwitched = true : isSwitched = false;
            });
          }),
          SizedBox(
            height: 50,
          ),
          ClassCode(),
          SizedBox(
            height: 25,
          ),
          InactiveDaysPicker(maxDaysInactive),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GenerateNewClassCode(_scaffoldKey),
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
                _fire.updateClassName(
                    'new1@gmail.com', 'test class app ui', controller.text);
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
  Function updateSwitch;
  IsAcceptingJoin(this.isSwitched, this.updateSwitch);
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
        widget.isSwitched == null ? CircularProgressIndicator() : CupertinoSwitch(
          value: widget.isSwitched,
          onChanged: (value) {
            widget.updateSwitch();
            _fire.updateAllowJoin('new1@gmail.com', 'test class app ui', value);
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
  final GlobalKey<ScaffoldState> scaffoldKey;
  GenerateNewClassCode(this.scaffoldKey);

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
        onPressed: () async {
          var result = await _fire.generateNewClassCode(
              'new1@gmail.com', 'test class app ui');
          print(result);
          if (result != 'success') {
            print('failed');
            final snackBar = SnackBar(
              content: Text('Code Already Taken. Try Again!'),
              action: SnackBarAction(
                label: 'Hide',
                onPressed: () {
                  widget.scaffoldKey.currentState.hideCurrentSnackBar();
                },
              ),
            );

            widget.scaffoldKey.currentState.showSnackBar(snackBar);
          }
        },
      ),
    );
  }
}

class InactiveDaysPicker extends StatefulWidget {
  int maxDaysInactive;
  InactiveDaysPicker(this.maxDaysInactive);
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
          'Max Student Inactive Days',
          style: TextStyle(fontSize: 18, color: kWetAsphaltColor),
        ),
        Spacer(),
        widget.maxDaysInactive == null
            ? CircularProgressIndicator()
            : NumberPicker.integer(
                initialValue: widget.maxDaysInactive,
                minValue: 1,
                maxValue: 7,
                onChanged: (value) {
                  setState(() {
                    widget.maxDaysInactive = value;
                  });
                },
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
                _fire.updateMaxDaysInactive('new1@gmail.com',
                    'test class app ui', widget.maxDaysInactive);
              },
            ),
          ),
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
        StreamBuilder(
            stream: _firestore
                .collection('Classes')
                .document('test class app ui')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else {
                String code = snapshot.data['class code'];
                List codeLetters = code.split("");

                return Row(
                  children: codeLetters.map((letter) {
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
                );
              }
            }),
      ],
    );
  }
}
