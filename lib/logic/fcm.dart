import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class FCM {
  Future<String> getToken() async {
    String token = await _firebaseMessaging.getToken();
    return token;
  }

  Future<void> sendNotification() async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA2miS9yY:APA91bEU74Nt7Ddt4HGq14lDMvh0Gar7vsc2SfiqTQWhS01xkQpF6QmALEYM6c-4CqD4RFdJFTIubtUZvPmZP4fwP3vvUbyIrXdbrpUYXMNWmVeq6r9lzYt2DfgLqYRsNdxKjuXnLrEl',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await getToken(),
        },
      ),
    );
    print('notification sent!');
  }
}
