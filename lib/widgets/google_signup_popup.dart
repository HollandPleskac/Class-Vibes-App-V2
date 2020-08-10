// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../constant.dart';
// import '../logic/fire.dart';
// import '../logic/auth.dart';

// final _fire = Fire();
// final _auth = Auth();

// class GoogleSignUpPopup extends StatefulWidget {
//   @override
//   _GoogleSignUpPopupState createState() => _GoogleSignUpPopupState();
// }

// class _GoogleSignUpPopupState extends State<GoogleSignUpPopup> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController _codeController = TextEditingController();
//   bool checkValue = false;
//   String accountType = '';
//   String feedback = '';

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       title: accountType == 'Teacher'
//           ? Text('Enter your District Code')
//           : Container(),
//       content: checkValue == false
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Checkbox(
//                   value: checkValue,
//                   onChanged: (value) {
//                     setState(() {
//                       checkValue = value;
//                     });
//                   },
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Text('I have read and accept the '),
//                     InkWell(
//                       onTap: () async {
//                         String url = 'https://classvibes.net/privacy';
//                         if (await canLaunch(url)) {
//                           await launch(url);
//                         } else {
//                           throw 'Could not launch $url';
//                         }
//                       },
//                       child: Text(
//                         'Privacy Policy',
//                         style: TextStyle(
//                             color: kPrimaryColor, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           : accountType == ''
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     FlatButton(
//                       color: Colors.blue,
//                       child: Text(
//                         'Student',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           accountType = 'Student';
//                         });
//                       },
//                     ),
//                     FlatButton(
//                       color: Colors.red,
//                       child: Text(
//                         'Teacher',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           accountType = 'Teacher';
//                         });
//                       },
//                     ),
//                   ],
//                 )
//               : accountType == 'Teacher'
//                   ? Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Center(
//                           child: Form(
//                             key: _formKey,
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 hintText: "District Code",
//                               ),
//                               controller: _codeController,
//                               validator: (districtCode) {
//                                 if (districtCode == null ||
//                                     districtCode == '') {
//                                   return 'Enter a district code';
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: feedback == '' ? 0 : 10,
//                         ),
//                         Text(
//                           feedback,
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       ],
//                     )
//                   : Text('you are a student!'),
//       actions: <Widget>[
//         accountType == 'Teacher'
//             ? FlatButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 child: Text(
//                   'Continue',
//                   style: TextStyle(color: kPrimaryColor, fontSize: 15.5),
//                 ),
//                 onPressed: () async {
//                   if (_formKey.currentState.validate()) {
//                     if (await _fire
//                             .doesDistrictCodeExist(_codeController.text) ==
//                         true) {
//                       print('district code valid');
//                       setState(() {
//                         feedback = '';
//                       });
//                       String result = await _auth.signInWithGoogle();
//                       print(result);
//                     } else {
//                       print('invalid');
//                       setState(() {
//                         feedback = 'District Code Invalid';
//                       });
//                     }
//                   }
//                 })
//             : Container()
//       ],
//     );
//   }
// }
