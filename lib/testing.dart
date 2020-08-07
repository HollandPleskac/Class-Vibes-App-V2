//testing file
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

final Firestore _firestore = Firestore.instance;

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  var first = _firestore.collection('Testing').orderBy('field 1').limit(5);
  List<Widget> list = [];

  @override
  void initState() {
    first.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        print('c '+change.document.data['field 1']);
        setState(() {
          list.add(Text(change.document.data['field 1'].toString()));
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Screen'),
      ),
      body: Container(
        child: ListView(
          children: list,
        ),
      ),
    );
  }
}
