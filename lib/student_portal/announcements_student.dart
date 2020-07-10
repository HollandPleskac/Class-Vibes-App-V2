import 'package:flutter/material.dart';

import '../nav_student.dart';

class AnnouncementsStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavStudent(),
      appBar: AppBar(
        title: Text('Student Announcements'),
      ),
      body: Center(
        child: Text('student announcements'),
      ),
    );
  }
}
