import 'package:class_vibes_v2/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../logic/auth.dart';
import '../constant.dart';
import '../widgets/delete_account_screen.dart';

final _auth = Auth();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class AccountSettingsTeacherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 5,),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteAccountScreen('Teacher'),
                ),
              );
            },
            child: InkWell(
              child: Container(
                height: 40,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [SizedBox(width: 20,),
                        Text('Delete Account',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteAccountScreen('Teacher'),
                ),
              );
            },
            child: InkWell(
              child: Container(
                height: 40,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [SizedBox(width: 20,),
                        Text('Edit Name',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteAccountScreen('Teacher'),
                ),
              );
            },
            child: InkWell(
              child: Container(
                height: 40,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    height: 40,
                    child: Row(
                      children: [SizedBox(width: 20,),
                        Text('Bob',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
