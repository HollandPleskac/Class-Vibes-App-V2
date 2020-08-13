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

  Future<void> deleteAccountStudent() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
  }
}
