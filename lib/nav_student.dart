import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'teacher_portal/classview_teacher.dart';
import 'teacher_portal/classview_teacher.dart';
import './teacher_portal/meetings_teacher.dart';
import './student_portal/profile_student.dart';
import './student_portal/meetings_student.dart';
import './student_portal/classview_student.dart';


class NavStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            // put image here
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('drawer header'),
          ),
          ListTile(
            title: Text('Student Classes'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassViewStudent(),
                ),
              );
            },
          ),
           ListTile(
            title: Text('Student Meetings'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeetingsStudent(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Student Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileStudent(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
