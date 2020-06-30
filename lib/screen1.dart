import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Screen 1',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.deepOrange,
      body: Center(child: Text('screen 1')),
    );
  }
}
