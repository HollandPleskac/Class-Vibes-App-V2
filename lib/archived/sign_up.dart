// import 'package:class_vibes_v2/logic/fire.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../student_portal/classview_student.dart';
// import '../teacher_portal/classview_teacher.dart';
// import '../logic/auth.dart';
// import '../constant.dart';
// import '../widgets/google_signup_popup.dart';

// final _auth = Auth();
// final Firestore _firestore = Firestore.instance;

// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final _formKey = new GlobalKey<FormState>();

//   bool isSwitched = true;
//   String _feedback = '';
//   bool checkValue = false;

//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _districtIdController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.grey,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//       ),
//       backgroundColor: Colors.white,
//       body: StreamBuilder(
//           stream: _firestore
//               .collection('Application Management')
//               .document('ServerManagement')
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Text('');
//             } else {
//               return snapshot.data['serversAreUp'] == false
//                   ? Center(
//                       child: Text(
//                         'Servers are down',
//                         style: TextStyle(color: Colors.grey[800], fontSize: 18),
//                       ),
//                     )
//                   : ListView(
//                       physics: BouncingScrollPhysics(),
//                       children: [
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.05,
//                         ),
//                         Center(
//                           child: Text(
//                             'Register',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 46,
//                                 fontWeight: FontWeight.w300),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.15,
//                         ),
//                         Form(
//                           key: _formKey,
//                           child: Column(
//                             children: [
//                               Center(
//                                 child: Container(
//                                   child: Center(
//                                     child: Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 20),
//                                       child: TextFormField(
//                                         controller: _usernameController,
//                                         decoration: InputDecoration(
//                                             border: InputBorder.none,
//                                             hintText: 'Username'),
//                                         validator: (value) {
//                                           if (value == null || value == '') {
//                                             return 'Username cannot be blank';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.06,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.85,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.02,
//                               ),
//                               Center(
//                                 child: Container(
//                                   child: Center(
//                                     child: Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 20),
//                                       child: TextFormField(
//                                         controller: _emailController,
//                                         keyboardType:
//                                             TextInputType.emailAddress,
//                                         decoration: InputDecoration(
//                                             border: InputBorder.none,
//                                             hintText: 'Email'),
//                                         validator: (value) {
//                                           if (value == null || value == '') {
//                                             return 'Email cannot be blank';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.06,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.85,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.02,
//                               ),
//                               Center(
//                                 child: Container(
//                                   child: Center(
//                                     child: Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 20),
//                                       child: TextFormField(
//                                         controller: _passwordController,
//                                         obscureText: true,
//                                         decoration: InputDecoration(
//                                             border: InputBorder.none,
//                                             hintText: 'Password'),
//                                         validator: (value) {
//                                           if (value == null || value == '') {
//                                             return 'Password cannot be blank';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.06,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.85,
//                                 ),
//                               ),
//                               isSwitched == false
//                                   ? SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.02,
//                                     )
//                                   : Container(),
//                               isSwitched == false
//                                   ? Center(
//                                       child: Container(
//                                         child: Center(
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 20),
//                                             child: TextFormField(
//                                               controller: _districtIdController,
//                                               decoration: InputDecoration(
//                                                   border: InputBorder.none,
//                                                   hintText: 'District Id'),
//                                               validator: (value) {
//                                                 if (value == null ||
//                                                     value == '') {
//                                                   return 'District Id cannot be blank';
//                                                 }
//                                                 return null;
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.06,
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.85,
//                                       ),
//                                     )
//                                   : Container(),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.01,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             children: [
//                               Switch(
//                                 value: isSwitched,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     isSwitched = value;
//                                     print(isSwitched);
//                                   });
//                                 },
//                                 activeTrackColor: Colors.grey[200],
//                                 activeColor: Colors.grey[500],
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Text(
//                                 isSwitched
//                                     ? "Student Account"
//                                     : "Teacher Account",
//                                 style: TextStyle(color: Colors.grey[500]),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Checkbox(
//                               value: checkValue,
//                               onChanged: (value) {
//                                 setState(() {
//                                   checkValue = value;
//                                 });
//                               },
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 Text('I have read and accept the '),
//                                 InkWell(
//                                   onTap: () async {
//                                     String url =
//                                         'https://classvibes.net/privacy';
//                                     if (await canLaunch(url)) {
//                                       await launch(url);
//                                     } else {
//                                       throw 'Could not launch $url';
//                                     }
//                                   },
//                                   child: Text(
//                                     'Privacy Policy',
//                                     style: TextStyle(
//                                         color: kPrimaryColor,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02,
//                         ),
//                         Center(
//                           child: Container(
//                             child: new Material(
//                               child: new InkWell(
//                                 onTap: () async {
//                                   if (checkValue == false) {
//                                     setState(() {
//                                       _feedback =
//                                           'Accept the Privacy Policy to Continue';
//                                     });
//                                   } else {
//                                     if (isSwitched == true) {
//                                       //sign up as a student
//                                       if (_formKey.currentState.validate()) {
//                                         List result = await _auth.signUpStudent(
//                                           username: _usernameController.text,
//                                           email: _emailController.text,
//                                           password: _passwordController.text,
//                                         );
//                                         if (result[0] == 'success') {
//                                           //ste up account
//                                           _auth.setUpAccountStudent(
//                                             username: _usernameController.text,
//                                             password: _passwordController.text,
//                                             email: _emailController.text,
//                                           );

//                                           //push next screen
//                                           Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ClassViewStudent(),
//                                             ),
//                                           );
//                                         } else {
//                                           setState(() {
//                                             _feedback = result[1];
//                                           });
//                                         }
//                                       }
//                                     } else {
//                                       //sign up as a teacher
//                                       if (_formKey.currentState.validate()) {
//                                         List result = await _auth.signUpTeacher(
//                                           username: _usernameController.text,
//                                           email: _emailController.text,
//                                           password: _passwordController.text,
//                                           districtId:
//                                               _districtIdController.text,
//                                         );
//                                         if (result[0] == 'success') {
//                                           //set up account
//                                           _auth.setUpAccountTeacher(
//                                             districtId:
//                                                 _districtIdController.text,
//                                             username: _usernameController.text,
//                                             password: _passwordController.text,
//                                             email: _emailController.text,
//                                           );

//                                           //push next screen
//                                           Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ClassViewTeacher(),
//                                             ),
//                                           );
//                                         } else {
//                                           setState(() {
//                                             _feedback = result[1];
//                                           });
//                                         }
//                                       }
//                                     }
//                                   }
//                                 },
//                                 child: new Container(
//                                   child: Center(
//                                     child: Text(
//                                       'Register',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.06,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.85,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                               color: Colors.transparent,
//                             ),
//                             height: MediaQuery.of(context).size.height * 0.06,
//                             width: MediaQuery.of(context).size.width * 0.85,
//                             decoration: BoxDecoration(
//                               color: kAppBarColor,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.025,
//                         ),
//                         Center(
//                           child: Container(
//                             child: new Material(
//                               child: new InkWell(
//                                 onTap: () async {
//                                   print('google sign in');
//                                   if (checkValue == true) {
//                                     showDialog(
//                                         context: context,
//                                         builder: (context) =>
//                                             GoogleSignUpPopup());
//                                   } else {
//                                     setState(() {
//                                       _feedback =
//                                           'Accept the privacy policy to continue';
//                                     });
//                                   }
//                                 },
//                                 child: new Container(
//                                   child: Center(
//                                     child: Text(
//                                       'Sign up with Google',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ),
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.06,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.85,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               color: Colors.transparent,
//                             ),
//                             height: MediaQuery.of(context).size.height * 0.06,
//                             width: MediaQuery.of(context).size.width * 0.85,
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.025,
//                         ),
//                         Center(
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 15, right: 15),
//                             child: Text(
//                               _feedback,
//                               textAlign: TextAlign.center,
//                               style:
//                                   TextStyle(color: Colors.red, fontSize: 15.5),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//             }
//           }),
//     );
//   }
// }
