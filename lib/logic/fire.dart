import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

final Firestore _firestore = Firestore.instance;

class Fire {
  // class setttings
  void updateClassName(String uid, String classId, String newClassName) async {
    _firestore.collection("Classes").document(classId).updateData({
      "class name": newClassName,
    });

    _firestore
        .collection("UserData")
        .document(uid)
        .collection("Classes")
        .document(classId)
        .updateData({
      "class name": newClassName,
    });
  }

  void updateAllowJoin(String uid, String classId, bool newStatusOnJoin) {
    _firestore.collection("Classes").document(classId).updateData({
      "allow join": newStatusOnJoin,
    });
    _firestore
        .collection("UserData")
        .document(uid)
        .collection("Classes")
        .document(classId)
        .updateData({
      "allow join": newStatusOnJoin,
    });
  }

  void updateMaxDaysInactive(
      String uid, String classId, int newMaxDaysInactive) {
    _firestore.collection("Classes").document(classId).updateData({
      "max days inactive": newMaxDaysInactive,
    });
    _firestore
        .collection("UserData")
        .document(uid)
        .collection("Classes")
        .document(classId)
        .updateData({
      "max days inactive": newMaxDaysInactive,
    });
  }

  // student dashboard
  void updateStudentMood({String uid, String classId, String newMood}) {
    _firestore
        .collection('UserData')
        .document(uid)
        .collection('Classes')
        .document(classId)
        .updateData({
      'status': newMood,
      'date': DateTime.now(),
    });

    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Students')
        .document(uid)
        .updateData({
      'status': newMood,
      'date': DateTime.now(),
    });
  }

  void setupMeeting({
    String studentUid,
    String length,
    String title,
    String content,
    String studentName,
    String teacherUid,
    String dateAndTime,
    String className,
    String classId,
    String teacherName,
  }) {
    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Meetings')
        .document('random meeting id')
        .setData({
      'time': length,
      'title': title,
      'content': content,
      'class name': className,
      'date and time': dateAndTime,
      'student name': studentName,
      'timestamp': DateTime.now(),
      'teacher name': teacherName,
      'class id': classId,
    });
    _firestore
        .collection('UserData')
        .document(studentUid)
        .collection('Meetings')
        .document('random meeting id')
        .setData({
      'time': length,
      'title': title,
      'content': content,
      'class name': className,
      'date and time': dateAndTime,
      'student name': studentName,
      'timestamp': DateTime.now(),
      'teacher name': teacherName,
      'class id': classId,
    });
    _firestore
        .collection('UserData')
        .document(teacherUid)
        .collection('Meetings')
        .document('random meeting id')
        .setData({
      'time': length,
      'title': title,
      'class name': className,
      'content': content,
      'student name': studentName,
      'date and time': dateAndTime,
      'timestamp': DateTime.now(),
      'teacher name': teacherName,
      'class id': classId,
    });
  }

  void deleteMeeting({
    String studentUid,
    String teacherUid,
    String meetingId,
    String classId,
  }) {
    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Meetings')
        .document(meetingId)
        .delete();
    _firestore
        .collection("UserData")
        .document(studentUid)
        .collection('Meetings')
        .document(meetingId)
        .delete();
    _firestore
        .collection("UserData")
        .document(teacherUid)
        .collection('Meetings')
        .document(meetingId)
        .delete();
  }

  void pushAnnouncement({
    String classId,
    String content,
    String className,
  }) {
    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Announcements')
        .document('announcement id')
        .setData(
      {
        'content': content,
        'timestamp': DateTime.now(),
        'class name': className,
      },
    );
  }

  void editUserName({
    String uid,
    String newUserName,
  }) {
    _firestore.collection('UserData').document(uid).updateData({
      'display-name': newUserName,
    });
  }

  Future<String> joinClass(
    String classCode,
    String studentEmail,
    String studentName,
  ) async {
    bool isClassCode = await _firestore
        .collection('Classes')
        .where('class code', isEqualTo: classCode)
        .getDocuments()
        .then((querySnap) => querySnap.documents.isNotEmpty);

    bool isAlreadyInClass = await _firestore
        .collection('UserData')
        .document(studentEmail)
        .collection('Classes')
        .where('class code', isEqualTo: classCode)
        .getDocuments()
        .then((querySnap) => querySnap.documents.isNotEmpty);
    if (isAlreadyInClass == true) {
      return 'You are already in that class.';
    }
    if (isClassCode == true) {
      //put the student in that class
      _firestore
          .collection('Classes')
          .document(classCode)
          .collection('Students')
          .document(studentEmail)
          .setData({
        'date': DateTime.now(),
        'email': studentEmail,
        'name': studentName,
        'status': 'doing great',
      });
      return 'You have joined the class!';
    }
    return 'That code does not exist.';
  }

  Future<List> addClass({String uid, String className}) async {
    String classCode = randomAlphaNumeric(6);
    // String classCode = '5gUxwD';

    int isCodeUnique = await _firestore
        .collection("Classes")
        .where("class code", isEqualTo: classCode)
        .getDocuments()
        .then((querySnapshot) => querySnapshot.documents.length);

    if (isCodeUnique != 0) {
      return ['failure', 'An error occurred try again'];
    }

    _firestore.collection('Classes').document(classCode).setData({
      'class code': classCode,
      'class name': className,
      'allow join': true,
      'max days inactive': 7,
    });

    _firestore
        .collection('UserData')
        .document(uid)
        .collection('Classes')
        .document(classCode)
        .setData({
      'class code': classCode,
      'class name': className,
      'allow join': true,
      'max days inactive': 7,
    });
    return ['success', classCode];
  }

  void deleteClass({String classId, String teacherEmail}) {
    print('deleting class');
    //query all the students then delete the class from the students tree
  }
}
