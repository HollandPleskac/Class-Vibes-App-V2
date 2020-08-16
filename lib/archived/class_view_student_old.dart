// class StudentClass extends StatelessWidget {
//   final String classId;
//   final String email;
//   final int unreadCount;

//   StudentClass({
//     this.classId,
//     this.email,
//     this.unreadCount,
//   });
//   @override
//   Widget build(BuildContext context) {
//     Future getClassName() async {
//       return await _firestore
//           .collection('Classes')
//           .document(classId)
//           .get()
//           .then(
//             (docSnap) => docSnap.data['class name'],
//           );
//     }

//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () async {
//             _fire.resetStudentUnreadCount(
//               classId: classId,
//               studentEmail: email,
//             );
//             Navigator.pushNamed(context, ViewClassStudent.routename,
//                 arguments: {
//                   'class id': classId,
//                   'class name': await getClassName(),
//                   'initial index': 0,
//                 });
//           },
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.14,
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.035,
//                 left: MediaQuery.of(context).size.width * 0.05,
//                 right: MediaQuery.of(context).size.width * 0.05,
//               ),
//               child: Card(
//                 child: StreamBuilder(
//                     stream: _firestore
//                         .collection('Classes')
//                         .document(classId)
//                         .snapshots(),
//                     builder: (BuildContext context, classSnapshot) {
//                       if (classSnapshot.data == null) {
//                         return Center(
//                           child: Container(),
//                         );
//                       }
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: MediaQuery.of(context).size.width * 0.05),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               child: Text(
//                                 classSnapshot.data['class name'],
//                                 overflow: TextOverflow.fade,
//                                 softWrap: false,
//                                 style: TextStyle(
//                                   fontSize:
//                                       MediaQuery.of(context).size.width * 0.046,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(right: 20),
//                             child: StreamBuilder(
//                               stream: _firestore
//                                   .collection('Classes')
//                                   .document(classId)
//                                   .collection('Students')
//                                   .document(email)
//                                   .snapshots(),
//                               builder: (BuildContext context, snapshot) {
//                                 if (snapshot.data == null) {
//                                   return Center(
//                                     child: Container(),
//                                   );
//                                 }
//                                 return SelectStatusRow(
//                                   classId: classId,
//                                   lastChangedStatus: snapshot.data['date'],
//                                   status: snapshot.data['status'],
//                                   email: email,
//                                   maxDaysInactive:
//                                       classSnapshot.data['max days inactive'],
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: MediaQuery.of(context).size.height * 0.03,
//           right: MediaQuery.of(context).size.width * 0.03,
//           child: UnreadMessageBadge(unreadCount),
//         ),
//       ],
//     );
//   }
// }


// class SelectStatusRow extends StatefulWidget {
//   final String classId;
//   final Timestamp lastChangedStatus;
//   final String status;
//   final String email;
//   final int maxDaysInactive;

//   SelectStatusRow(
//       {this.classId,
//       this.lastChangedStatus,
//       this.status,
//       this.email,
//       this.maxDaysInactive});
//   @override
//   _SelectStatusRowState createState() => _SelectStatusRowState();
// }

// class _SelectStatusRowState extends State<SelectStatusRow> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () {
//             _fire.updateStudentMood(
//                 uid: widget.email,
//                 classId: widget.classId,
//                 newMood: 'doing great');
//             print('changing status');
//           },
//           child: DateTime.now()
//                       .difference(
//                         DateTime.parse(
//                             widget.lastChangedStatus.toDate().toString()),
//                       )
//                       .inDays >=
//                   widget.maxDaysInactive
//               ? FaIcon(
//                   FontAwesomeIcons.smile,
//                   color: Colors.grey,
//                   size: MediaQuery.of(context).size.width * 0.0825,
//                   //used to be 36
//                 )
//               : FaIcon(
//                   widget.status == 'doing great'
//                       ? FontAwesomeIcons.solidSmile
//                       : FontAwesomeIcons.smile,
//                   color: Colors.green,
//                   size: MediaQuery.of(context).size.width * 0.0825,
//                   //used to be 36
//                 ),
//         ),
//         // FaIcon(
//         //   FontAwesomeIcons.smile,
//         //   color: Colors.green,
//         //   size: 36,
//         // ),
//         SizedBox(
//           width: 20,
//         ),
//         GestureDetector(
//           onTap: () {
//             _fire.updateStudentMood(
//                 uid: widget.email,
//                 classId: widget.classId,
//                 newMood: 'need help');
//             print('changing status');
//           },
//           child: DateTime.now()
//                       .difference(
//                         DateTime.parse(
//                             widget.lastChangedStatus.toDate().toString()),
//                       )
//                       .inDays >=
//                   widget.maxDaysInactive
//               ? FaIcon(
//                   FontAwesomeIcons.meh,
//                   color: Colors.grey,
//                   size: MediaQuery.of(context).size.width * 0.0825,
//                   //used to be 36
//                 )
//               : FaIcon(
//                   widget.status == 'need help'
//                       ? FontAwesomeIcons.solidMeh
//                       : FontAwesomeIcons.meh,
//                   color: Colors.yellow[800],
//                   size: MediaQuery.of(context).size.width * 0.0825,
//                   //used to be 36
//                 ),
//         ),
//         // FaIcon(
//         //   FontAwesomeIcons.meh,
//         //   color: Colors.yellow[800],
//         //   size: 36,
//         // ),
//         SizedBox(
//           width: 20,
//         ),
//         GestureDetector(
//           onTap: () {
//             _fire.updateStudentMood(
//                 uid: widget.email,
//                 classId: widget.classId,
//                 newMood: 'frustrated');
//             print('changing status');
//           },
//           child: DateTime.now()
//                       .difference(
//                         DateTime.parse(
//                             widget.lastChangedStatus.toDate().toString()),
//                       )
//                       .inDays >=
//                   widget.maxDaysInactive
//               ? FaIcon(
//                   FontAwesomeIcons.frown,
//                   color: Colors.grey,
//                   size: MediaQuery.of(context).size.width * 0.0825,
//                   //used to be 36
//                 )
//               : FaIcon(
//                   widget.status == 'frustrated'
//                       ? FontAwesomeIcons.solidFrown
//                       : FontAwesomeIcons.frown,
//                   color: Colors.red,
//                   size: MediaQuery.of(context).size.width * 0.0825,
//                   //used to be 36
//                 ),
//         ),
//         // FaIcon(
//         //   FontAwesomeIcons.frown,
//         //   color: Colors.red,
//         //   size: 36,
//         // ),
//       ],
//     );
//   }
// }