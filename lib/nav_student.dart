import 'package:class_vibes_v2/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './student_portal/profile_student.dart';
import './student_portal/meetings_student.dart';
import './student_portal/classview_student.dart';
import './student_portal/announcements_student.dart';
import './student_portal/join_class.dart';
import 'package:provider/provider.dart';
import 'auth/welcome.dart';
import './logic/auth.dart';
import 'logic/auth_service.dart';

final _auth = Auth();

class NavStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthenticationService>(
      create: (_) => AuthenticationService(),
      child: Drawer(
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
              DrawerTile(
                'Join a Class',
                FontAwesomeIcons.solidPlusSquare,
                () {
                  // Update the state of the app.
                  // ...
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JoinClass(),
                    ),
                  );
                },
              ),
              DrawerTile(
                'Meetings',
                FontAwesomeIcons.phoneSquareAlt,
                () {
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
              DrawerTile(
                'Announcements',
                FontAwesomeIcons.bullhorn,
                () {
                  // Update the state of the app.
                  // ...
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnnouncementsStudent(),
                    ),
                  );
                },
              ),
              DrawerTile(
                'Settings',
                FontAwesomeIcons.cog,
                () {
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
                () async {
                  context.read<AuthenticationService>().signout();
                },
              ),
            ],
          ),
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
