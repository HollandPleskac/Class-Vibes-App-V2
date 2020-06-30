import 'package:flutter/material.dart';
import 'constant.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWetAsphaltColor,
        title: Text(
          'Screen 1',
          style: TextStyle(color: Colors.white,),
        ),
                centerTitle: true,

      ),
      backgroundColor: Colors.white,
      body: Center(child: Text('screen 1')),
    );
  }
}
