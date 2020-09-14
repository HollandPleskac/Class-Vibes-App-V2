import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'teacher_portal/classview_teacher.dart';
import './teacher_portal/meetings_teacher.dart';
import 'teacher_portal/settings_teacher.dart';
import './auth/welcome.dart';

class NavTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: Container(
        color: kPrimaryColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/transparent-logo.png',
                      width: MediaQuery.of(context).size.width * 0.275,
                    ),
                    Text(
                      'CLASS VIBES',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.white54,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 15),
              child: Text(
                'INTERFACE',
                style: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w500),
              ),
            ),
            DrawerTile(
              'Classes',
              FontAwesomeIcons.stream,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClassViewTeacher(),
                  ),
                );
              },
            ),
            DrawerTile(
              'Meetings',
              FontAwesomeIcons.phoneSquareAlt,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeetingsTeacher(),
                  ),
                );
              },
            ),
            DrawerTile(
              'Settings',
              FontAwesomeIcons.cog,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileTeacher(),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.white54,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 15),
              child: Text(
                'SIGN OUT',
                style: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w500),
              ),
            ),
            DrawerTile(
              'Log Out',
              FontAwesomeIcons.signOutAlt,
              () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Welcome()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  DrawerTile(this.title, this.icon, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor,
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.05),
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(
                  icon,
                  color: Colors.white54,
                  size: 15,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
