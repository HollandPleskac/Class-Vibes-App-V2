import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../nav_student.dart';

final Firestore _firestore = Firestore.instance;

class AnnouncementsStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavStudent(),
      appBar: AppBar(
        title: Text('Student Announcements'),
        centerTitle: true,
        backgroundColor: kWetAsphaltColor,
      ),
      body: Text('view announcements that are sent to you'),
    );
  }
}
