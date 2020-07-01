import 'package:class_vibes_v2/StudentDashv2.dart';
import 'package:class_vibes_v2/student_portal/classview_student.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'screen1.dart';
import './teacher_portal/classview_teacher.dart';
import './teacher_portal/classview_teacher.dart';
import 'screen3.dart';
import 'constant.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int selectedIndex = 1;

  PageController controller = PageController(initialPage: 1);

  var screens = [
    Screen1(),
    ClassViewTeacher(),
    ClassViewStudent(),
  ];

  List<FaIcon> items = [
    // Icon(
    //   Icons.verified_user,
    //   size: 25,
    //   color: Colors.black,
    // ),
    FaIcon(
      FontAwesomeIcons.graduationCap,
      size: 20,
      color: Colors.white,
    ),
    // Icon(
    //   Icons.verified_user,
    //   size: 25,
    //   color: Colors.black,
    // ),
    FaIcon(
      FontAwesomeIcons.stream,
      size: 20,
      color: Colors.white,
     
    ),
    // Icon(
    //   Icons.verified_user,
    //   size: 25,
    //   color: Colors.black,
    // ),
    FaIcon(
      FontAwesomeIcons.userAlt,
      size: 20,
      color: Colors.white,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView.builder(
        onPageChanged: (page) {
          setState(() {
            selectedIndex = page;
          });
        },
        controller: controller,
        itemBuilder: (context, index) {
 
          return Container(
            child: screens[index],
          );
        },
        physics: BouncingScrollPhysics(),
        itemCount:
            screens.length, //Can be null - prevents overflow w/ page view
      ),
      bottomNavigationBar: SafeArea(
        child: CurvedNavigationBar(
          color: kWetAsphaltColor,
          backgroundColor: Colors.white,
          buttonBackgroundColor: kPrimaryColor,

          height: 60,
          items: items, // list of items above
          index:
              selectedIndex, //Do not need to specify index - only if using page controller
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            controller.jumpToPage(index);
          },
          animationDuration: Duration(
            milliseconds: 200,
          ),
          animationCurve: Curves.bounceInOut,
        ),
      ),
    );
  }
}
