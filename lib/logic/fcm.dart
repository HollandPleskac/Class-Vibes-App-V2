import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import './fire.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final _fire = Fire();

class FCM {
  Future<String> getToken() async {
    String token = await _firebaseMessaging.getToken();
    print(token);
    return token;
  }

  Future<String> setDG(String uid) async {
    String token = await getToken();
    print('TOKEN : ' + token);
    var response = await http.post(
      'https://fcm.googleapis.com/fcm/notification',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA2miS9yY:APA91bEU74Nt7Ddt4HGq14lDMvh0Gar7vsc2SfiqTQWhS01xkQpF6QmALEYM6c-4CqD4RFdJFTIubtUZvPmZP4fwP3vvUbyIrXdbrpUYXMNWmVeq6r9lzYt2DfgLqYRsNdxKjuXnLrEl',
        'project_id': '938057332518',
      },
      body: jsonEncode(<String, dynamic>{
        "operation": "create",
        "notification_key_name": uid,
        "registration_ids": [token]
      }),
    );

    print(response.body);
  }

//{"notification_key":"APA91bFOc9KhcaoHoTRLVQkPegKQ88CELwOqwRwRiwzdcRGihbXrif-tdmC8CY33_-rZqaC-k-L5GajsclJWJlFr2ztB-BQqFtjZCqwqJ0BDaKeQ4cXnl0135rCIO1WwJRYXPzdkMdb1"}
// thats for pleskac510@gmail.com

  Future<String> getDG(String uid) async {
    // pleskac510@gmail.com is id for this thing here
    var response = await http.get(
        'https://fcm.googleapis.com/fcm/notification?notification_key_name=$uid',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA2miS9yY:APA91bEU74Nt7Ddt4HGq14lDMvh0Gar7vsc2SfiqTQWhS01xkQpF6QmALEYM6c-4CqD4RFdJFTIubtUZvPmZP4fwP3vvUbyIrXdbrpUYXMNWmVeq6r9lzYt2DfgLqYRsNdxKjuXnLrEl',
          'project_id': '938057332518',
        });

    print(response.body);

    return response.body;
  }

  Future<String> sendDG() async {
    String token = await getToken();

    String toValue = await getDG("test2");

    print('TO VAL : ' + toValue.toString());

    var response = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA2miS9yY:APA91bEU74Nt7Ddt4HGq14lDMvh0Gar7vsc2SfiqTQWhS01xkQpF6QmALEYM6c-4CqD4RFdJFTIubtUZvPmZP4fwP3vvUbyIrXdbrpUYXMNWmVeq6r9lzYt2DfgLqYRsNdxKjuXnLrEl',
      },
      body: jsonEncode(<String, dynamic>{
        "to":
            'APA91bFQAYJgAEr2dLwIhwNr6VtEqNMRI9fzDQzNbb86hTOfSmmhFFIALX8VJ8PZb1OdKWd8-EUjzowMaXZlHcKYIN01fq4PCuMECYWDNC03XaUH74Sv4dk',
        "notification": {
          "title": "Hello",
          "body": "This is a test message",
        },
        "priority":"high",
        "data": {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
      }),
    );

    print(response.body);
  }

  Future<void> addDG() async {
    var uid = '1069338@lammersvilleusd.net';
    var response = await http.post(
      'https://fcm.googleapis.com/fcm/notification?notification_key_name=$uid',
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA2miS9yY:APA91bEU74Nt7Ddt4HGq14lDMvh0Gar7vsc2SfiqTQWhS01xkQpF6QmALEYM6c-4CqD4RFdJFTIubtUZvPmZP4fwP3vvUbyIrXdbrpUYXMNWmVeq6r9lzYt2DfgLqYRsNdxKjuXnLrEl',
        'project_id': '938057332518',
      },
      body: jsonEncode(<String, dynamic>{
        "operation": "add",
        "notification_key_name": uid,
        "notification_key": await getDG(uid),
        "registration_ids": [await getToken()]
      }),
    );

    print(response.body);
  }
}
