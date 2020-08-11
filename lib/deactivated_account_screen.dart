// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// final Firestore _firestore = Firestore.instance;

// class DeactivatedAccountScreen extends StatefulWidget {
//   final String teacherEmail;
//   DeactivatedAccountScreen({this.teacherEmail});
//   @override
//   _DeactivatedAccountScreenState createState() =>
//       _DeactivatedAccountScreenState();
// }

// class _DeactivatedAccountScreenState extends State<DeactivatedAccountScreen> {
//   @override
//   void initState() {
//     _firestore
//         .collection('UserData')
//         .document(widget.teacherEmail)
//         .snapshots()
//         .listen((docSnap) {
//       if (docSnap.data['Account Status'] == 'Deactivated') {
//         print('the account is now deactivated');
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
