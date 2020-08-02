import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  var title = 'asdf';
  var helper = 'asdf';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (message) async {
        // in app
        setState(() {
          title = message["notification"]["title"];
          helper = "You have recieved a new notification";
        });
      },
      onResume: (message) async {
        // app open but on home screen or something
        setState(() {
          title = message["data"]["title"];
          helper = "You have open the application from notification";
          print('TITLE : '+title);
          print('HELPER : '+helper);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            Text(helper),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Set State'),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}
