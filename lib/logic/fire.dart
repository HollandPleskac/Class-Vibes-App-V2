import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final Firestore _firestore = Firestore.instance;
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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

    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Reactions')
        .document()
        .setData({
      'date': DateTime.now(),
      'reaction': newMood,
      'student email': uid,
    });
  }

  void setupMeeting({
    String studentUid,
    String length,
    String title,
    String content,
    String teacherUid,
    String dateAndTime,
    String classId,
    DateTime timestampId,
    String courseName,
  }) {
    _firestore
        .collection('UserData')
        .document(studentUid)
        .collection('Meetings')
        .document(timestampId.toString())
        .setData({
      'length': length,
      'title': title,
      'message': content,
      'date and time': dateAndTime,
      'timestamp': DateTime.now(),
      'class id': classId,
      'recipient': studentUid,
      'course': courseName,
      'Course': courseName,
    });
    _firestore
        .collection('UserData')
        .document(teacherUid)
        .collection('Meetings')
        .document(timestampId.toString())
        .setData({
      'length': length,
      'title': title,
      'message': content,
      'date and time': dateAndTime,
      'timestamp': DateTime.now(),
      'class id': classId,
      'recipient': studentUid,
      'course': courseName,
      'Course': courseName,
    });
  }

  void deleteMeeting({
    String studentUid,
    String teacherUid,
    String meetingId,
    String classId,
  }) {
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
    String title,
  }) {
    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Announcements')
        .document()
        .setData(
      {
        'title': title,
        'message': content,
        'date': DateTime.now(),
        // 'class name': 'TAKE OUT (cant update once sent)',
      },
    );
  }

  void deleteAnnouncement({String classId, String announcementId}) {
    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Announcements')
        .document(announcementId)
        .delete();
  }

  void editUserName({
    String uid,
    String newUserName,
  }) {
    _firestore.collection('UserData').document(uid).updateData({
      'display name': newUserName,
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
        .where(FieldPath.documentId, isEqualTo: classCode)
        .getDocuments()
        .then((querySnap) => querySnap.documents.isNotEmpty);

    if (isAlreadyInClass == true) {
      return 'You are already in that class.';
    }

    if (isClassCode == true) {
      bool isAcceptingJoin = await _firestore
          .collection('Classes')
          .document(classCode)
          .get()
          .then((docSnap) => docSnap.data['allow join']);
      //put the student in that class
      if (isAcceptingJoin) {
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
          'teacher unread': 0,
          'accepted': false,
        });

        _firestore
            .collection('UserData')
            .document(studentEmail)
            .collection('Classes')
            .document(classCode)
            .setData({
          'code': classCode,
          'student unread': 0,
          'teacher unread': 0,
          'accepted': false,
        });
        await _firebaseMessaging.subscribeToTopic(classCode);
        return 'You have joined the class!';
      } else {
        return 'Teacher is not accepting students right now';
      }
    }
    return 'That code does not exist.';
  }

  Future<List> addClass({String uid, String className}) async {
    String classCode = randomNumeric(4);
    // String classCode = '7614';

    int isCodeUnique = await _firestore
        .collection("Classes")
        .where("class code", isEqualTo: classCode)
        .getDocuments()
        .then((querySnapshot) => querySnapshot.documents.length);

    if (isCodeUnique != 0) {
      // return ['failure', 'An error occurred try again'];
      print('adding a new class');
      addClass(uid: uid, className: className);
    }

    _firestore.collection('Classes').document(classCode).setData({
      'teacher email': uid,
      'class code': classCode,
      'class name': className,
      'allow join': true,
      'max days inactive': 7,
      'expire date': DateTime.now().add(Duration(days: 365)),
      // 'type':'paid',
    });

    _firestore
        .collection('UserData')
        .document(uid)
        .collection('Classes')
        .document(classCode)
        .setData({
      'teacher email': uid,
      'class code': classCode,
      'class name': className,
      'allow join': true,
      'max days inactive': 7,
      'expire date': DateTime.now().add(Duration(days: 365)),
      // 'type':'paid',
    });
    return ['success', classCode];
  }

  Future<List> addTrialClass(String uid) async {
    String classCode = randomNumeric(4);
    // String classCode = '5gUxwD';

    int isCodeUnique = await _firestore
        .collection("Classes")
        .where("class code", isEqualTo: classCode)
        .getDocuments()
        .then((querySnapshot) => querySnapshot.documents.length);

    if (isCodeUnique != 0) {
      print('readding trial class');
      addTrialClass(uid);
      // return ['failure', 'An error occurred try again'];
    }

    _firestore.collection('Classes').document(classCode).setData({
      'teacher email': uid,
      'class code': classCode,
      'class name': 'Trial Class',
      'allow join': true,
      'max days inactive': 7,
      'expire date': DateTime.now().add(
        Duration(days: 395),
      ),
      // 'type':'trial',
    });

    _firestore
        .collection('UserData')
        .document(uid)
        .collection('Classes')
        .document(classCode)
        .setData({
      'teacher email': uid,
      'class code': classCode,
      'class name': 'Trial Class',
      'allow join': true,
      'max days inactive': 7,
      'expire date': DateTime.now().add(
        Duration(days: 395),
      ),
      // 'type':'trial',
    });

    return ['success', classCode];
  }

  Future<void> deleteClass({String classId, String teacherEmail}) async {
    //delete class from Classes

    _firestore.collection('Classes').document(classId).delete();

    // delete class from Teachers

    _firestore
        .collection('UserData')
        .document(teacherEmail)
        .collection('Classes')
        .document(classId)
        .delete();

    //delete class from Students

    List<DocumentSnapshot> studentDocuments = await _firestore
        .collection('Classes')
        .document(classId)
        .collection('Students')
        .getDocuments()
        .then((querySnap) => querySnap.documents);
    print(studentDocuments);

    for (var i = 0; i < studentDocuments.length; i++) {
      studentDocuments.forEach((DocumentSnapshot document) {
        //document.documentID is a student email
        _firestore
            .collection('UserData')
            .document(document.documentID)
            .collection('Classes')
            .document(classId)
            .delete();
      });
    }
  }

  void leaveClass({String studentEmail, String classId}) {
    _firestore
        .collection('UserData')
        .document(studentEmail)
        .collection('Classes')
        .document(classId)
        .delete();

    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Students')
        .document(studentEmail)
        .delete();
  }

  void incrementStudentUnreadCount(
      {String classId, String studentEmail}) async {
    _firestore
        .collection('UserData')
        .document(studentEmail)
        .collection('Classes')
        .document(classId)
        .updateData({
      'student unread': FieldValue.increment(1),
    });
  }

  void incrementTeacherUnreadCount(
      {String classId, String studentEmail}) async {
    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Students')
        .document(studentEmail)
        .updateData({
      'teacher unread': FieldValue.increment(1),
    });
  }

  void resetStudentUnreadCount({String classId, String studentEmail}) {
    _firestore
        .collection('UserData')
        .document(studentEmail)
        .collection('Classes')
        .document(classId)
        .updateData({
      'student unread': 0,
    });
  }

  void resetTeacherUnreadCount({String classId, String studentEmail}) {
    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Students')
        .document(studentEmail)
        .updateData({
      'teacher unread': 0,
    });
  }

// TODO : delete
  Future<bool> doesDistrictCodeExist(String districtCode) async {
    return await _firestore
        .collection('Districts')
        .where('district id', isEqualTo: districtCode)
        .getDocuments()
        .then((querySnap) => querySnap.documents.isNotEmpty);
  }

  void rejectFromQueue(String studentEmail, String classId) {
    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Students')
        .document(studentEmail)
        .delete();

    _firestore
        .collection('UserData')
        .document(studentEmail)
        .collection('Classes')
        .document(classId)
        .delete();
  }

  void acceptFromQueue(String studentEmail, String classId) {
    print(studentEmail);
    print(classId);
    _firestore
        .collection('UserData')
        .document(studentEmail)
        .collection('Classes')
        .document(classId)
        .updateData(
      {
        'accepted': true,
      },
    );

    _firestore
        .collection('Classes')
        .document(classId)
        .collection('Students')
        .document(studentEmail)
        .updateData(
      {
        'accepted': true,
      },
    );
  }
}
