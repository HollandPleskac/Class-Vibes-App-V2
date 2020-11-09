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

  void fcmSubscribe(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void fcmUnSubscribe(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  void requestNotificationPermissions() {
    _firebaseMessaging.requestNotificationPermissions();
  }

}
