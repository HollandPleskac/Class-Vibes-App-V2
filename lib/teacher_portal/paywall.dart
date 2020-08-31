import 'package:class_vibes_v2/teacher_portal/classview_teacher.dart';
import 'package:flutter/material.dart';

import '../logic/revenue_cat.dart';

final _revenueCat = RevenueCat();

class Paywall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Purchasing this class will cost 1.99'),
            Text('You will have access to this class for 1 year'),
            Text('After 1 year, your class will expire'),
            RaisedButton(
              child: Text('Purchase'),
              onPressed: () {
                _revenueCat.makePurchase();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClassViewTeacher(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
