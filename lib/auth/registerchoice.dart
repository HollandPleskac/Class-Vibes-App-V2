import 'package:flutter/material.dart';

class RegisterChoice extends StatefulWidget {
  @override
  _RegisterChoiceState createState() => _RegisterChoiceState();
}

class _RegisterChoiceState extends State<RegisterChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
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
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
              'Student',
              style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
            ),
                ),
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,  
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrange[400],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
              'Teacher',
              style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
            ),
                ),
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,  
              ),
            ),
          ),
        ],
      ),
    );
  }
}
