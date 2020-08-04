// import 'dart:convert';
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;

// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

// class Testing extends StatefulWidget {
//   @override
//   _TestingState createState() => _TestingState();
// }

// class _TestingState extends State<Testing> {
//   var title = 'asdf';
//   var helper = 'asdf';
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _firebaseMessaging.subscribeToTopic('puppies');

//     _firebaseMessaging.configure(
//       onMessage: (message) async {
//         // in app
//         setState(() {
//           title = message["notification"]["title"];
//           helper = "You have recieved a new notification";
//         });
//       },
//       onResume: (message) async {
//         // app open but on home screen or something
//         setState(() {
//           title = message["data"]["title"];
//           helper = "You have open the application from notification";
//           print('TITLE : ' + title);
//           print('HELPER : ' + helper);
//         });
//       },
//     );
//   }

//   // Replace with server token from firebase console settings.
//   final String serverToken =
//       'AAAA2miS9yY:APA91bEU74Nt7Ddt4HGq14lDMvh0Gar7vsc2SfiqTQWhS01xkQpF6QmALEYM6c-4CqD4RFdJFTIubtUZvPmZP4fwP3vvUbyIrXdbrpUYXMNWmVeq6r9lzYt2DfgLqYRsNdxKjuXnLrEl';

//   Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
//     print('request notification permissions');
//     await _firebaseMessaging.requestNotificationPermissions(
//       const IosNotificationSettings(
//           sound: true, badge: true, alert: true, provisional: false),
//     );
//     print('before http post');
//     await http.post(
//       'https://fcm.googleapis.com/fcm/send',
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'key=$serverToken',
//       },
//       body: jsonEncode(
//         <String, dynamic>{
//           'notification': <String, dynamic>{
//             'body': 'this is a body',
//             'title': 'this is a title'
//           },
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'title': 'some title',
//           },
//           'to': '/topics/puppies',
//         },
//       ),
//     );
//     print('after http request');

//     final Completer<Map<String, dynamic>> completer =
//         Completer<Map<String, dynamic>>();

//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         completer.complete(message);
//       },
//     );

//     return completer.future;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title),
//             Text(helper),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.plus_one),
//         onPressed: () async {
//           await _firebaseMessaging.subscribeToTopic('puppies');
//           var res = await sendAndRetrieveMessage();

//           print('RESULT : ' + res.toString());
//           setState(() {});
//         },
//       ),
//     );
//   }
// }
