import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isSwitched = true;
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
              'Register',
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
                        border: InputBorder.none, hintText: 'Username'),
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Email'),
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Password'),
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
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.grey[200],
                  activeColor: Colors.grey[500],
                ),
                SizedBox(
                  width: 20,
                ),
                Text(isSwitched? "Student Account":"Teacher Account",style: TextStyle(color: Colors.grey[500]),)
              ],
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
                        color: Colors.grey[100],
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
