import 'package:flutter/material.dart';

class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
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
          Center(
            child: Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email'),
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.06,
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
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password'),
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.06,
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
            child: GestureDetector(
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
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
