import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './auth/welcome.dart';
import 'tab_page_teacher.dart';
import 'teacher_portal/view_class.dart';
import 'teacher_portal/class_settings.dart';

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
      home: WelcomeScreen(),
      routes: {
        ViewClass.routeName: (context) => ViewClass(),
        ClassSettings.routeName: (context) => ClassSettings(),
      },
    );
  }
}