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
    final IdTokenResult token = await user.getIdToken();
    var getResponse = await http.get(
        'http://api.classvibes.net/api/sendEmail?code=$classCode&title=$title&message=$message&className=$className&apiToken=$token');
    print(getResponse.body);
  }
}
