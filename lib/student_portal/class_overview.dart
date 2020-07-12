import 'dart:ui';

import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../logic/fire.dart';

final Firestore _firestore = Firestore.instance;
final _fire = Fire();

class ClassOverViewStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: _firestore
                  .collection('UserData')
                  .document('new@gmail.com')
                  .collection('Classes')
                  .document('class id')
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Container(),
                  );
                }
                return StatusRow(
                  className: snapshot.data['class name'],
                  status: snapshot.data['status'],
                  lastChangedStatus: snapshot.data['date'],
                );
              }),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Note : Status\'s appear grey if you changed it in a while',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusRow extends StatefulWidget {
  final String className;
  final String status;
  final Timestamp lastChangedStatus;
  StatusRow({
    this.className,
    this.status,
    this.lastChangedStatus,
  });
  @override
  _StatusRowState createState() => _StatusRowState();
}

class _StatusRowState extends State<StatusRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                _fire.updateStudentMood(
                    uid: 'new@gmail.com',
                    classId: 'class id',
                    newMood: 'doing great');
                print('touched happy face');
              },
              child: DateTime.now()
                          .difference(
                            DateTime.parse(
                                widget.lastChangedStatus.toDate().toString()),
                          )
                          .inDays >=
                      5
                  ? FaIcon(
                      FontAwesomeIcons.smile,
                      color: Colors.grey,
                      size: 50,
                    )
                  : FaIcon(
                      widget.status == 'doing great'
                          ? FontAwesomeIcons.solidSmile
                          : FontAwesomeIcons.smile,
                      color: Colors.green,
                      size: 50,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Doing Great",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                _fire.updateStudentMood(
                    uid: 'new@gmail.com',
                    classId: 'class id',
                    newMood: 'need help');
                print('tapped meh');
              },
              child: DateTime.now()
                          .difference(
                            DateTime.parse(
                                widget.lastChangedStatus.toDate().toString()),
                          )
                          .inDays >=
                      5
                  ? FaIcon(
                      FontAwesomeIcons.meh,
                      color: Colors.grey,
                      size: 50,
                    )
                  : FaIcon(
                      widget.status == 'need help'
                          ? FontAwesomeIcons.solidMeh
                          : FontAwesomeIcons.meh,
                      color: Colors.yellow[800],
                      size: 50,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Need Help",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.orange[600],
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                _fire.updateStudentMood(
                    uid: 'new@gmail.com',
                    classId: 'class id',
                    newMood: 'frustrated');
                print('tapped frown');
              },
              child: DateTime.now()
                          .difference(
                            DateTime.parse(
                                widget.lastChangedStatus.toDate().toString()),
                          )
                          .inDays >=
                      5
                  ? FaIcon(
                      FontAwesomeIcons.meh,
                      color: Colors.grey,
                      size: 50,
                    )
                  : FaIcon(
                      widget.status == 'frustrated'
                          ? FontAwesomeIcons.solidFrown
                          : FontAwesomeIcons.frown,
                      color: Colors.red,
                      size: 50,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Frustrated",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.red[700],
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ],
    );
  }
}
