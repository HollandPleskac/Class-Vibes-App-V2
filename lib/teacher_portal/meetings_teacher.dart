import 'package:flutter/material.dart';

import '../nav_teacher.dart';

class MeetingsTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetings'),
      ),
      drawer: NavTeacher(),
      body: Center(
        child: Text('Teacher Meetings'),
      ),
    );
  }
}
