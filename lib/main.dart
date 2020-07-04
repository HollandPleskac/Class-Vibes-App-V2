import 'package:flutter/material.dart';

import './testing.dart';
import './tab_page.dart';
import './teacher_portal/individual_class_teacher.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabPage(),
      routes: {
        IndividualClassTeacher.routeName: (context) => IndividualClassTeacher(),
      },
    );
  }
}