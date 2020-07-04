import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './testing.dart';
import './tab_page.dart';
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
      home: TabPage(),
      routes: {
        ViewClass.routeName: (context) => ViewClass(),
        ClassSettings.routeName: (context) => ClassSettings(),
      },
    );
  }
}