import 'dart:convert';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

final String serverToken =
    'AAAA2miS9yY:APA91bEU74Nt7Ddt4HGq14lDMvh0Gar7vsc2SfiqTQWhS01xkQpF6QmALEYM6c-4CqD4RFdJFTIubtUZvPmZP4fwP3vvUbyIrXdbrpUYXMNWmVeq6r9lzYt2DfgLqYRsNdxKjuXnLrEl';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class FCM {
  Future<void> sendAnnouncementNotification({
    String title,
    String body,
    String classId,
  }) async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'title': 'New Announcement',
          },
          'to': '/topics/'+classId.toString(),
        },
      ),
    );
  }
}
