import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore _firestore = Firestore.instance;

class MeetingsStudent extends StatefulWidget {
  @override
  _MeetingsStudentState createState() => _MeetingsStudentState();
}

class _MeetingsStudentState extends State<MeetingsStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetings Student'),
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('UserData')
              .document('new@gmail.com')
              .collection('Meetings')
              .orderBy("date", descending: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(),
              );
            }

            return Center(
              child: ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 20, bottom: 30),
                    child: Meeting(
                      className: document['class name'],
                      dateAndTime: document['date and time'],
                      length: document['length'],
                      message: document['message'],
                      title: document['title'],
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }
}

class Meeting extends StatelessWidget {
  final String dateAndTime;
  final String className;
  final String title;
  final String length;
  final String message;

  Meeting({
    this.dateAndTime,
    this.className,
    this.title,
    this.length,
    this.message,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thursday 11:59',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'AP Biology',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 120,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 11,
                        ),
                        CircleAvatar(
                          radius: 7.5,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                    Container(
                      color: kPrimaryColor,
                      height: 90,
                      width: 3.5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Math Meet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      color: kPrimaryColor.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          '2 hours',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'I need to talk to you',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
