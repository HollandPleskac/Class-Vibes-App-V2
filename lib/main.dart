import 'package:class_vibes_v2/student_portal/classview_student.dart';
import 'package:class_vibes_v2/teacher_portal/classview_teacher.dart';
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

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _revenueCat = RevenueCat();
final _auth = Auth();

//TODO : fix the little delary while initializing

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  String type;

  // Define an async function to initialize FlutterFire
  Future<void> initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();

      _initialized = true;
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails

      _error = true;
    }
  }

  // check if the user is a teacher or student
  Future<void> getAccountType() async {
    User user = _firebaseAuth.currentUser;
    if (user != null) {
      String accountType = await _auth.checkAccountType(user.email);
      // sign in with revenue cat to get correct past purchases
      await _revenueCat.signInRevenueCat(user.uid);

      if (accountType == 'Student') {
        type = 'student';
      } else {
        type = 'teacher';
      }
    }
  }

  @override
  void initState() {
    initializeFlutterFire().then((_) {
      getAccountType().then((_) {
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return SomethingWentWrong();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return MyAwesomeApp(type);
  }
}

class MyAwesomeApp extends StatelessWidget {
  final String type;

  MyAwesomeApp(this.type);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: type == 'student'
          ? ClassViewStudent()
          : type == 'teacher'
              ? ClassViewTeacher()
              : Welcome(),
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

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Something went wrong, please restart the app',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
