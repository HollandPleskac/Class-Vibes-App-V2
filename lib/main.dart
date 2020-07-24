import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './auth/welcome.dart';
import './student_portal/chat_student.dart';
import 'teacher_portal/view_class.dart';
import 'teacher_portal/class_settings.dart';
import './teacher_portal/chat_teacher.dart';
import './student_portal/view_class_student.dart';
import './splash.dart';

// void main() =>  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//     .then((_) {
//       runApp(new MyApp());
//     });

void main() => runApp((MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: {
        ViewClass.routeName: (context) => ViewClass(),
        ClassSettings.routeName: (context) => ClassSettings(),
        ChatStudent.routeName: (context) => ChatStudent(),
        ChatTeacher.routeName: (context) => ChatTeacher(),
        ViewClassStudent.routename: (context) => ViewClassStudent(),
      },
    );
  }
}
