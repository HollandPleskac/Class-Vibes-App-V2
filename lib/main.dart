import 'package:class_vibes_v2/logic/auth_service.dart';
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

final _db = DatabaseService();
final _fire = Fire();

// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// final _revenueCat = RevenueCat();
// final _auth = Auth();

// //TODO : fix the little delary while initializing

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // Set default `_initialized` and `_error` state to false
//   bool _initialized = false;
//   bool _error = false;
//   String type;

//   // Define an async function to initialize FlutterFire
//   Future<void> initializeFlutterFire() async {
//     try {
//       // Wait for Firebase to initialize and set `_initialized` state to true
//       await Firebase.initializeApp();

//       _initialized = true;
//     } catch (e) {
//       // Set `_error` state to true if Firebase initialization fails

//       _error = true;
//     }
//   }

//   // check if the user is a teacher or student
//   Future<void> getAccountType() async {
//     User user = _firebaseAuth.currentUser;
//     if (user != null) {
//       String accountType = await _auth.checkAccountType(user.email);
//       // sign in with revenue cat to get correct past purchases
//       await _revenueCat.signInRevenueCat(user.uid);

//       if (accountType == 'Student') {
//         type = 'student';
//       } else {
//         type = 'teacher';
//       }
//     }
//   }

//   @override
//   void initState() {
//     initializeFlutterFire().then((_) {
//       getAccountType().then((_) {
//         setState(() {});
//       });
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Show error message if initialization failed
//     if (_error) {
//       return SomethingWentWrong();
//     }

//     // Show a loader until FlutterFire is initialized
//     if (!_initialized) {
//       return Loading();
//     }

//     return MyAwesomeApp(type);
//   }
// }

// class MyAwesomeApp extends StatelessWidget {
//   final String type;

//   MyAwesomeApp(this.type);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: type == 'student'
//           ? ClassViewStudent()
//           : type == 'teacher'
//               ? ClassViewTeacher()
//               : Welcome(),
//       routes: {
//         ViewClass.routeName: (context) => ViewClass(),
//         ClassSettings.routeName: (context) => ClassSettings(),
//         ChatStudent.routeName: (context) => ChatStudent(),
//         ChatTeacher.routeName: (context) => ChatTeacher(),
//         ViewClassStudent.routename: (context) => ViewClassStudent(),
//       },
//     );
//   }
// }

// class Loading extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }

// class SomethingWentWrong extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: Text(
//             'Something went wrong, please restart the app',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              // context.read() gets the current state but doesn't ask flutter for future rebuilds
              // for use outside of build method
              context.read<AuthenticationService>().authStateChanges,
          // Provider.of<AuthenticationService>(context, listen: false).authStateChanges,
        ),
      ],
      child: MaterialApp(
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // call context.watch<User>() in a build method to access the current state of User,
    // and to ask flutter to rebuild to widget anyting User changes.
    final user = context.watch<User>();
    // final user = Provider.of<User>(context);

    if (user != null && user.emailVerified == true) {
      return Home(user);
    }

    return Login();
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed out'),
            RaisedButton(
              child: Text('sign in'),
              onPressed: () {
                context
                    .read<AuthenticationService>()
                    .signin('pleskac510@gmail.com', 'password123');
              },
            ),
            RaisedButton(
              child: Text('sign up'),
              onPressed: () {
                context
                    .read<AuthenticationService>()
                    .signUp('new3@gmail.com', 'password123');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final User user;

  Home(this.user);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String accountType;

  Future<void> getAccountType() async {
    String accType = await _fire.getAccountType(widget.user.email);
    accountType = accType;
  }

  @override
  void initState() {
    getAccountType().then(
      (_) => setState(() {}),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (accountType == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (accountType == 'Student') {
      return ClassViewStudent();
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Signed in teacher'),
            Text('Account Type : ' + 'accountType'.toString()),
            RaisedButton(
              child: Text('sign out'),
              onPressed: () {
                context.read<AuthenticationService>().signout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
