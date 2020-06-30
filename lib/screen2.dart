import 'package:flutter/material.dart';
import 'constant.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Screen 2',style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: kPrimaryColor,
      body: Center(child: Text('screen 2')),
    );
  }
}