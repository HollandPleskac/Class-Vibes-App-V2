import 'package:flutter/material.dart';

import '../logic/auth.dart';
import '../teacher_portal/classview_teacher.dart';

final _auth = Auth();

class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final _formKey = new GlobalKey<FormState>();
  bool isEmailValidate = false;
  bool isPasswordValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
          ),
          Center(
            child: Text(
              'Teacher',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 46,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Email'),
                          validator: (value) {
                            if (value == null || value == '') {
                              setState(() {
                                isEmailValidate = true;
                              });

                              return 'Email cannot be blank';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    height: isEmailValidate == true
                        ? MediaQuery.of(context).size.height * 0.08
                        : MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Password'),
                          validator: (value) {
                            if (value == null || value == '') {
                              setState(() {
                                isPasswordValidate = true;
                              });
                              return 'Password cannot be blank';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    height: isPasswordValidate == true
                        ? MediaQuery.of(context).size.height * 0.08
                        : MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if (_formKey.currentState.validate()) {
                  _auth.loginAsTeacher();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassViewTeacher(),
                    ),
                  );
                }
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
