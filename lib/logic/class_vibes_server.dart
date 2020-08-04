import 'package:http/http.dart' as http;

class ClassVibesServer {
  Future<void> sendEmailForAnnouncement(
    String classCode,
    String title,
    String message,
    String className,
  ) async {
    print(className);
    print(classCode);
    var getResponse = await http.get(
        'http://api.classvibes.net/api/sendEmail?code=$classCode&title=$title&message=$message&className=$className');
    print(getResponse.body);
  }
}
