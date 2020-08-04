import 'package:http/http.dart' as http;

class ClassVibesServer {
  Future<void> sendEmailForAnnouncement(
    String classCode,
    String title,
    String message,
    String className,
  ) async {
    var getResponse = await http.get(
        'http://api.classvibes.net/api/sendEmail?code=123&title=test&message=hi&className=testclass');
  }
}
