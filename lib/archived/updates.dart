// call updates.handleAnnounctStatus in the init state!


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../auth/welcome.dart';

// final Firestore _firestore = Firestore.instance;

// class Updates {
//   Future<void> handleServerStatus() {}

//   void handleAccountStatus(BuildContext context, String teacherEmail) {
//     _firestore
//         .collection('UserData')
//         .document(teacherEmail)
//         .snapshots()
//         .listen((docSnap) {
//       if (docSnap.data['account status'] == 'Deactivated') {
//         print('the account is now deactivated');
//         // gets rid of the entire screen stack
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => Welcome()),
//             (Route<dynamic> route) => false);
//       } else {
//         print(docSnap.data['account status']);
//         print('something');
//       }
//     });
//   }
// }
