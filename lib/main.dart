import 'package:class_vibes_v2/auth/login_student.dart';
import 'package:class_vibes_v2/logic/auth_service.dart';
import 'package:class_vibes_v2/models/models.dart';
import 'package:class_vibes_v2/student_portal/classview_student.dart';
import 'package:class_vibes_v2/teacher_portal/classview_teacher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import './student_portal/chat_student.dart';
import 'auth/welcome.dart';
import 'teacher_portal/view_class.dart';
import 'teacher_portal/class_settings.dart';
import './teacher_portal/chat_teacher.dart';
import './student_portal/view_class_student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './logic/auth.dart';
import './logic/revenue_cat.dart';
import 'package:provider/provider.dart';
import './logic/db_service.dart';
import './logic/fire.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

final _db = DatabaseService();
final _fire = Fire();
final _revenueCat = RevenueCat();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Router(),
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

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  String accountType = 'nothing yet';
  bool loading = true;

  Future<void> getUserData() async {
    final User user = _firebaseAuth.currentUser;

    if (user != null) {
      try {
        await _revenueCat.signInRevenueCat(user.uid);
        
        String type = await _fire.getAccountType(user.email);
        await _fire.subscribeToClasses(user.email, type);
        accountType = type;
      } catch (e) {
        print(e);
        print('no user');
      }
    }
  }

  @override
  void initState() {
    getUserData().then(
      (_) => setState(() {
        loading = false;
        print(accountType);
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      print('loading...');
      return Scaffold(
        body: Center(
          child: Container(),
        ),
      );
    }

    if (accountType == 'Student') {
      return ClassViewStudent();
    }

    if (accountType == 'Teacher') {
      return ClassViewTeacher();
    }

    return Welcome();
  }
}
