// THIS FILE IS NOT IN USE

import 'package:flutter/material.dart';
import '../constant.dart';
import '../widgets/delete_account_screen.dart';

class AccountSettingsTeacherPage extends StatefulWidget {
  @override
  _AccountSettingsTeacherPageState createState() =>
      _AccountSettingsTeacherPageState();
}

class _AccountSettingsTeacherPageState
    extends State<AccountSettingsTeacherPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
            },
            child: InkWell(
              child: Container(
                height: 40,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Delete Account',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => DeleteAccountScreen('Teacher'),
          //       ),
          //     );
          //   },
          //   child: InkWell(
          //     child: Container(
          //       height: 40,
          //       child: Material(
          //         color: Colors.transparent,
          //         child: Container(
          //           height: 40,
          //           child: Row(
          //             children: [SizedBox(width: 20,),
          //               Text('Edit Name',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Divider(),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => DeleteAccountScreen('Teacher'),
          //       ),
          //     );
          //   },
          //   child: InkWell(
          //     child: Container(
          //       height: 40,
          //       child: Material(
          //         color: Colors.transparent,
          //         child: Container(
          //           height: 40,
          //           child: Row(
          //             children: [SizedBox(width: 20,),
          //               Text('Bob',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

