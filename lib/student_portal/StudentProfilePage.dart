import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 80,
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
          GestureDetector(
            child: Center(
              child: Container(
                height: 42,
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text("Student",style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18
                    ),),
                    Spacer(),
                    Text("Enrolled in 16 classes",style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14
                    ),),
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
                  Text("abc@gmail.com",style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18
                  ),),
                  Spacer(),
                  Text("Email Address",style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14
                  ),),
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
                  Text("Kushagra Singh",style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18
                  ),),
                  Spacer(),
                  Text("Full Name",style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14
                  ),),
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
                  Text("KushagraS",style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18
                  ),),
                  Spacer(),
                  Text("UserName",style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14
                  ),),
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
        ],
      ),
    );
  }
}
