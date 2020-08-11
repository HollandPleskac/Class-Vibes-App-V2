import 'package:flutter/material.dart';
import './student_sign_up.dart';
import './teacher_sign_up.dart';

class RegisterChoice extends StatefulWidget {
  @override
  _RegisterChoiceState createState() => _RegisterChoiceState();
}

class _RegisterChoiceState extends State<RegisterChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
                      child: Text(
                        'Register As',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 30,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(height: 50,),
          Center(
            child: Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpStudent()));
                  },
                  child: Container(
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
              
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(10)),
               height: MediaQuery.of(context).size.width * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpTeacher()));
                  },
                  child: Container(
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
              
                  decoration: BoxDecoration(
                      color: Colors.deepOrange[400],
                      borderRadius: BorderRadius.circular(10)),
               height: MediaQuery.of(context).size.width * 0.6,
                  width: MediaQuery.of(context).size.width * 0.9,
            ),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}
