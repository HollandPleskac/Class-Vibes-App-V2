import 'dart:ui';

import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';

import '../nav_student.dart';

class ProfileStudent extends StatefulWidget {
  @override
  _ProfileStudentState createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showModalSheetEditUserName() {
    showModalBottomSheet(
        barrierColor: Colors.white.withOpacity(0),
        elevation: 0,
        context: context,
        builder: (builder) {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Edit Username',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Username cannot be blank';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavStudent(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: kWetAsphaltColor,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 7,
                      color: Colors
                          .grey[200] //                   <--- border width here
                      ),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/115909667/original/7d79dd80b9eecaa289de1bc8065ad44aa03e2daf/do-a-simple-but-cool-profile-pic-or-logo-for-u.jpeg'),
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Center(
            child: Container(
              height: 42,
              width: MediaQuery.of(context).size.width - 50,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Student",
                    style: TextStyle(color: Colors.grey[800], fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "Enrolled in 16 classes",
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              height: 42,
              width: MediaQuery.of(context).size.width - 50,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "abc@gmail.com",
                    style: TextStyle(color: Colors.grey[800], fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "Email Address",
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              _showModalSheetEditUserName();
              print('user name');
            },
            child: Center(
              child: Container(
                height: 42,
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "KushagraS",
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      "UserName",
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
