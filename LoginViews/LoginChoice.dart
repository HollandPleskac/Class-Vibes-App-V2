// import 'package:flutter/material.dart';

// import 'Register.dart';
// import 'StudentLogin.dart';
// import 'TeacherLogin.dart';

// class LoginChoice extends StatefulWidget {
//   @override
//   _LoginChoiceState createState() => _LoginChoiceState();
// }

// class _LoginChoiceState extends State<LoginChoice> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.25,
//           ),
//           Center(
//             child: Text(
//               'Login',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 46,
//                   fontWeight: FontWeight.w300),
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.15,
//           ),
//           Center(
//             child: GestureDetector(
//               onTap: (){
//               Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => StudentLogin()),
//             );
//             },
//               child: Container(
//                 child: Center(
//                   child: Text(
//                     'Student',
//                     style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 24,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 height: MediaQuery.of(context).size.height * 0.06,
//                 width: MediaQuery.of(context).size.width * 0.85,
//                 decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           Center(
//             child: GestureDetector(
//               onTap: (){
//               Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => TeacherLogin()),
//             );
//             },
//               child: Container(
//                 child: Center(
//                   child: Text(
//                     'Teacher',
//                     style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 24,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 height: MediaQuery.of(context).size.height * 0.06,
//                 width: MediaQuery.of(context).size.width * 0.85,
//                 decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           Center(
//             child: GestureDetector(
//                onTap: (){
//               Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Register()),
//             );
//             },
//               child: Container(
//                 child: Center(
//                   child: Text(
//                     'Register',
//                     style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 24,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ),
//                 height: MediaQuery.of(context).size.height * 0.06,
//                 width: MediaQuery.of(context).size.width * 0.85,
//                 decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
