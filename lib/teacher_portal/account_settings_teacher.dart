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
  Future<void> _deleteAccount() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteAccountPopUpT();
      },
    );
  }

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
              _deleteAccount();
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

class DeleteAccountPopUpT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Delete Account',
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'We hate to see you go, but if you are sure press the button below. Remeber this action can not be undone.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: new Container(
                child: new Material(
                  child: new InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeleteAccountScreen('Teacher'),
                        ),
                      );
                    },
                    child: new Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      width: 180.0,
                      height: 40.0,
                      child: Center(
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                ),
                color: Colors.transparent,
              ),
            ),
          ],
        ));
  }
}
