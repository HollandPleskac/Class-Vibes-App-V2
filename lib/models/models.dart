// data model is responsible for creating an instance with the proper data shape
// database service is responsible for the actual business logic for retrieving the documents from the db
// and deserializing them to the proper class
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Class {
  final String id;
  final String name;
  final String code;
  final String teacher;
  final DateTime expireDate;
  final int maxDaysInactive;
  final bool allowJoin;

  Class({
    this.id,
    this.name,
    this.code,
    this.teacher,
    this.expireDate,
    this.maxDaysInactive,
    this.allowJoin,
  });

  factory Class.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Class(
      id: doc.id,
      name: data['class name'] ?? 'Class Name',
      code: data['class code'],
      teacher: data['teacher email'] ?? 'teacher',
      expireDate: data['expire date'],
      maxDaysInactive: data['max days inactive'] ?? 7,
      allowJoin: data['allow join'] ?? false,
    );
  }
}

class StudentSignInFeedbackModel extends ChangeNotifier {
  String feedback = '';

  void updateFeedback(String newFeedback) {
    feedback = newFeedback;
    print('New feedback '+newFeedback);
    notifyListeners();
  }
}

class TeacherSignInFeedbackModel extends ChangeNotifier {
  String feedback = '';


}
