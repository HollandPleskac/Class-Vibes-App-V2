import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './fcm.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final _fcm = FCM();

class Fire {
  // class setttings
  void updateClassName(String uid, String classId, String newClassName) async {
    _firestore.collection("Classes").doc(classId).update({
      "class name": newClassName,
    });

    _firestore
        .collection("UserData")
        .doc(uid)
        .collection("Classes")
        .doc(classId)
        .update({
      "class name": newClassName,
    });
  }

  void updateAllowJoin(String uid, String classId, bool newStatusOnJoin) {
    _firestore.collection("Classes").doc(classId).update({
      "allow join": newStatusOnJoin,
    });
    _firestore
        .collection("UserData")
        .doc(uid)
        .collection("Classes")
        .doc(classId)
        .update({
      "allow join": newStatusOnJoin,
    });
  }

  void updateMaxDaysInactive(
      String uid, String classId, int newMaxDaysInactive) {
    _firestore.collection("Classes").doc(classId).update({
      "max days inactive": newMaxDaysInactive,
    });
    _firestore
        .collection("UserData")
        .doc(uid)
        .collection("Classes")
        .doc(classId)
        .update({
      "max days inactive": newMaxDaysInactive,
    });
  }

  // student dashboard
  void updateStudentMood({String uid, String classId, String newMood}) {
    _firestore
        .collection('UserData')
        .doc(uid)
        .collection('Classes')
        .doc(classId)
        .update({
      'status': newMood,
      'date': DateTime.now(),
    });

    _firestore
        .collection('Classes')
        .doc(classId)
        .collection('Students')
        .doc(uid)
        .update({
      'status': newMood,
      'date': DateTime.now(),
    });

    _firestore
        .collection('Classes')
        .doc(classId)
        .collection('Reactions')
        .doc()
        .set({
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
        .doc(studentUid)
        .collection('Meetings')
        .doc(timestampId.toString())
        .set({
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
        .doc(teacherUid)
        .collection('Meetings')
        .doc(timestampId.toString())
        .set({
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
        .doc(studentUid)
        .collection('Meetings')
        .doc(meetingId)
        .delete();
    _firestore
        .collection("UserData")
        .doc(teacherUid)
        .collection('Meetings')
        .doc(meetingId)
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
        .doc(classId)
        .collection('Announcements')
        .doc()
        .set(
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
        .doc(classId)
        .collection('Announcements')
        .doc(announcementId)
        .delete();
  }

  void editUserName({
    String uid,
    String newUserName,
  }) {
    _firestore.collection('UserData').doc(uid).update({
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
        .get()
        .then((querySnap) => querySnap.docs.isNotEmpty);

    bool isAlreadyInClass = await _firestore
        .collection('UserData')
        .doc(studentEmail)
        .collection('Classes')
        .where(FieldPath.documentId, isEqualTo: classCode)
        .get()
        .then((querySnap) => querySnap.docs.isNotEmpty);

    if (isAlreadyInClass == true) {
      return 'You are already in that class.';
    }

    if (isClassCode == true) {
      bool isAcceptingJoin = await _firestore
          .collection('Classes')
          .doc(classCode)
          .get()
          .then((docSnap) => docSnap['allow join']);
      //put the student in that class
      if (isAcceptingJoin) {
        _firestore
            .collection('Classes')
            .doc(classCode)
            .collection('Students')
            .doc(studentEmail)
            .set({
          'date': DateTime.now(),
          'email': studentEmail,
          'name': studentName,
          'status': 'doing great',
          'teacher unread': 0,
          'accepted': false,
        });

        _firestore
            .collection('UserData')
            .doc(studentEmail)
            .collection('Classes')
            .doc(classCode)
            .set({
          'code': classCode,
          'student unread': 0,
          'teacher unread': 0,
          'accepted': false,
        });
        await _firebaseMessaging.subscribeToTopic(classCode);
        await storeTokenOnClass(studentEmail, classCode);
        await storeToken(studentEmail);
        return 'You have joined the class!';
      } else {
        return 'Teacher is not accepting students right now';
      }
    }
    return 'That code does not exist.';
  }

  Future<List> addClass({
    @required String email,
    @required String className,
    @required String uid,
  }) async {
    String classCode = randomNumeric(4);

    int isCodeUnique = await _firestore
        .collection("Classes")
        .where("class code", isEqualTo: classCode)
        .get()
        .then((querySnapshot) => querySnapshot.docs.length);

    if (isCodeUnique != 0) {
      print('adding a new class');
      addClass(email: email, className: className, uid: uid);
    }

    _firestore.collection('Classes').doc(classCode).set({
      'teacher email': email,
      'class code': classCode,
      'class name': className,
      'allow join': true,
      'max days inactive': 7,
      'expire date': DateTime.now().add(Duration(days: 365)),
      // 'type':'paid',
    });

    _firestore
        .collection('UserData')
        .doc(email)
        .collection('Classes')
        .doc(classCode)
        .set({
      'teacher email': email,
      'class code': classCode,
      'class name': className,
      'allow join': true,
      'max days inactive': 7,
      'expire date': DateTime.now().add(Duration(days: 365)),
      // 'type':'paid',
    });

    await subscribeToClasses(email, 'Teacher', uid);
    return ['success', classCode];
  }

  Future<List> addTrialClass(String uid) async {
    String classCode = randomNumeric(4);
    // String classCode = '5gUxwD';

    int isCodeUnique = await _firestore
        .collection("Classes")
        .where("class code", isEqualTo: classCode)
        .get()
        .then((querySnapshot) => querySnapshot.docs.length);

    if (isCodeUnique != 0) {
      print('readding trial class');
      addTrialClass(uid);
      // return ['failure', 'An error occurred try again'];
    }

    _firestore.collection('Classes').doc(classCode).set({
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
        .doc(uid)
        .collection('Classes')
        .doc(classCode)
        .set({
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

    _firestore.collection('Classes').doc(classId).delete();

    // delete class from Teachers

    _firestore
        .collection('UserData')
        .doc(teacherEmail)
        .collection('Classes')
        .doc(classId)
        .delete();

    //delete class from Students

    List<DocumentSnapshot> studentdocs = await _firestore
        .collection('Classes')
        .doc(classId)
        .collection('Students')
        .get()
        .then((querySnap) => querySnap.docs);
    print(studentdocs);

    for (var i = 0; i < studentdocs.length; i++) {
      studentdocs.forEach((DocumentSnapshot doc) {
        //doc.docID is a student email
        _firestore
            .collection('UserData')
            .doc(doc.id)
            .collection('Classes')
            .doc(classId)
            .delete();
      });
    }
  }

  void leaveClass({String studentEmail, String classId}) {
    _firestore
        .collection('UserData')
        .doc(studentEmail)
        .collection('Classes')
        .doc(classId)
        .delete();

    _firestore
        .collection('Classes')
        .doc(classId)
        .collection('Students')
        .doc(studentEmail)
        .delete();
  }

  void incrementStudentUnreadCount(
      {String classId, String studentEmail}) async {
    _firestore
        .collection('UserData')
        .doc(studentEmail)
        .collection('Classes')
        .doc(classId)
        .update({
      'student unread': FieldValue.increment(1),
    });
  }

  void incrementTeacherUnreadCount(
      {String classId, String studentEmail}) async {
    _firestore
        .collection('Classes')
        .doc(classId)
        .collection('Students')
        .doc(studentEmail)
        .update({
      'teacher unread': FieldValue.increment(1),
    });
  }

  void resetStudentUnreadCount({String classId, String studentEmail}) {
    _firestore
        .collection('UserData')
        .doc(studentEmail)
        .collection('Classes')
        .doc(classId)
        .update({
      'student unread': 0,
    });
  }

  void resetTeacherUnreadCount({String classId, String studentEmail}) {
    _firestore
        .collection('Classes')
        .doc(classId)
        .collection('Students')
        .doc(studentEmail)
        .update({
      'teacher unread': 0,
    });
  }

// TODO : delete
  Future<bool> doesDistrictCodeExist(String districtCode) async {
    return await _firestore
        .collection('Districts')
        .where('district id', isEqualTo: districtCode)
        .get()
        .then((querySnap) => querySnap.docs.isNotEmpty);
  }

  void rejectFromQueue(String studentEmail, String classId) {
    _firestore
        .collection('Classes')
        .doc(classId)
        .collection('Students')
        .doc(studentEmail)
        .delete();

    _firestore
        .collection('UserData')
        .doc(studentEmail)
        .collection('Classes')
        .doc(classId)
        .delete();
  }

  void acceptFromQueue(String studentEmail, String classId) {
    print(studentEmail);
    print(classId);
    _firestore
        .collection('UserData')
        .doc(studentEmail)
        .collection('Classes')
        .doc(classId)
        .update(
      {
        'accepted': true,
      },
    );

    _firestore
        .collection('Classes')
        .doc(classId)
        .collection('Students')
        .doc(studentEmail)
        .update(
      {
        'accepted': true,
      },
    );
  }

  Future<void> storeToken(String email) async {
    String token = await _fcm.getToken();

    bool isNoToken = await _firestore
        .collection("UserData")
        .doc(email)
        .collection("tokens")
        .where(token, isEqualTo: token)
        .get()
        .then((querySnapshot) => querySnapshot.docs.isEmpty);

    // store in classes
    if (isNoToken) {
      // store in user data
      await _firestore
          .collection("UserData")
          .doc(email)
          .collection("Tokens")
          .doc()
          .set({
        "token": token,
        "created at": DateTime.now(),
        "platform": Platform.operatingSystem,
      });
    }
  }

  // TODO : take this out
  Future<void> storeTokenStudent(String email) async {
    String token = await _fcm.getToken();

    bool isNoToken = await _firestore
        .collection("UserData")
        .doc(email)
        .collection("tokens")
        .where(token, isEqualTo: token)
        .get()
        .then((querySnapshot) => querySnapshot.docs.isEmpty);

    if (isNoToken) {
      await _firestore
          .collection("Classes")
          .doc(email)
          .collection("Tokens")
          .doc()
          .set({
        "token": token,
        "created at": DateTime.now(),
        "platform": Platform.operatingSystem,
      });
    }
  }

  // TODO : take this out
  Future<void> storeTokenOnClass(String email, String classId) async {
    String token = await _fcm.getToken();
    await _firestore
        .collection("Classes")
        .doc(classId)
        .collection("Students")
        .doc(email)
        .update({
      "token": token,
    });
  }

  Future<String> getAccountType(String email) async {
    return await _firestore
        .collection('UserData')
        .doc(email)
        .get()
        .then((docSnap) => docSnap['account type']);
  }

  Future<bool> isUserInDb(String email) async {
    return await _firestore
        .collection('UserData')
        .where('email', isEqualTo: email)
        .get()
        .then((querySnap) => querySnap.docs.isNotEmpty);
  }

  Future<void> setUpAccountStudent(String email, String username) async {
    await _firestore.collection('UserData').doc(email).set({
      'email': email,
      'display name': username,
      'account type': 'Student',
    });
  }

  Future<void> setUpAccountTeacher(
    String email,
    String username,
  ) async {
    await _firestore.collection('UserData').doc(email).set({
      'email': email,
      'display name': username,
      'account type': 'Teacher',
    });
  }

  Future<void> subscribeToClasses(
      String email, String accountType, String uid) async {
    List<QueryDocumentSnapshot> classes = await _firestore
        .collection('UserData')
        .doc(email)
        .collection('Classes')
        .get()
        .then((querySnap) {
      print(querySnap.docs);
      return querySnap.docs;
    });

    if (classes.length != 0) {
      print('not equal to 0');
      for (int i = 0; i < classes.length; i++) {
        print(i);
        String classCode = classes[i].id;
        print('Subscribed to : ' + classCode);
        if (accountType == "Teacher") {
          _fcm.fcmSubscribe('classes-teacher-$classCode');
        } else {
          String acceptedString = email.replaceAll("@", "-");
          acceptedString = acceptedString.replaceAll(".", "-");
          _fcm.fcmSubscribe('classes-student-$classCode-$acceptedString');
        }
      }
    }
  }
}
