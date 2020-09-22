import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ClassVibesServer {
  Future<void> sendEmailForAnnouncement(
    String classCode,
    String title,
    String message,
    String className,
  ) async {
    print(className);
    print(classCode);
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final String token = await user.getIdToken().then((value) => value.token);
    var getResponse = await http.get(
        'http://api-v1.classvibes.net/api/sendEmail?code=$classCode&title=$title&message=$message&className=$className&apiToken=$token');
    print(getResponse.body);
  }

  Future<void> deleteAccount({
    String email,
    String accountType,
  }) async {
    // https://api-v1.classvibes.net/api/deleteUserAccount?authToken=&email=&type=
    final FirebaseUser user = await _firebaseAuth.currentUser();

    final String token = await user.getIdToken().then((value) => value.token);
    var getResponse = await http.get(
        'https://api-v1.classvibes.net/api/deleteUserAccount?authToken=$token&email=$email&type=$accountType');
    print(getResponse.body);
  }

  Future<void> removeFromClass({
    String studentEmail,
    String classId,
    String teacherEmail,
  }) async {
    // https://api-v1.classvibes.net/api/removeStudent?email=&code=&teacher=&classUID=&authToken=
    final FirebaseUser user = await _firebaseAuth.currentUser();

    final String token = await user.getIdToken().then((value) => value.token);
    var getResponse = await http.get(
        'https://api-v1.classvibes.net/api/removeStudent?email=$studentEmail&code=$classId&teacher=$teacherEmail&classUID=$classId&authToken=$token');
    print(getResponse.body);
  }

  Future<void> createStripeCustomer(String email) async {
    var getResponse = await http
        .get('https://api-v1.classvibes.net/api/createCustomer?email=$email');
    print(getResponse.body);
  }

  // https://api-v1.classvibes.net/api/getTransactionsRevenueCat?id=
}
