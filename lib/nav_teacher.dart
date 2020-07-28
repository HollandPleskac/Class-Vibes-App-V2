import 'package:class_vibes_v2/constant.dart';
import 'package:class_vibes_v2/student_portal/classview_student.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'teacher_portal/classview_teacher.dart';
import 'teacher_portal/classview_teacher.dart';
import './teacher_portal/meetings_teacher.dart';
import './teacher_portal/profile_teacher.dart';

class NavTeacher extends StatelessWidget {
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
              color: kWetAsphaltColor,
            ),
            child: Center(
              child: Text(
                'Class Vibes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Classes'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassViewTeacher(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Meetings'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeetingsTeacher(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileTeacher(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
