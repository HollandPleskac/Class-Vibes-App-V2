// //testing file
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter/material.dart';

// final Firestore _firestore = Firestore.instance;

// class Testing extends StatefulWidget {
//   @override
//   _TestingState createState() => _TestingState();
// }

// class _TestingState extends State<Testing> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var first = _firestore.collection('UserData').orderBy('email').limit(2);

//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Testing Screen'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Container(
//               height: 500,
//               child: StreamBuilder(
//                 stream: first.snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   return ListView(
//                     children: snapshot.data.documents
//                         .map(
//                           (DocumentSnapshot document) => Text(
//                             document['email'],
//                           ),
//                         )
//                         .toList(),
//                   );
//                 },
//               ),
//             ),
//             RaisedButton(
//               child: Text('fetch more'),
//               onPressed: () async {
//                 first.getDocuments().then(
//                   (value) async {
//                     DocumentSnapshot lastVisible =
//                         value.documents[value.documents.length - 1];
//                     setState(() {
//                       first.startAfterDocument(lastVisible).limit(4);
//                     });

//                     print(await first
//                         .getDocuments()
//                         .then((value) => value.documents.length));
//                   },
//                 );
//               },
//             )
//           ],
//         ));
//   }
// }
