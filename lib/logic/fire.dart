import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore _firestore = Firestore.instance;

class Fire {
  void updateClassName(String uid,String classId, String newClassName) {
    _firestore.collection("Classes").document(classId).updateData({
      "class name": newClassName,
    });

    _firestore.collection("UserData").document(uid).collection("Classes").document(classId).updateData({
      "class name": newClassName,
    });
  }

  void updateAllowJoin(String uid,String classId, bool newStatusOnJoin) {
    _firestore.collection("Classes").document(classId).updateData({
      "allow join": newStatusOnJoin,
    });
    _firestore.collection("UserData").document(uid).collection("Classes").document(classId).updateData({
      "allow join": newStatusOnJoin,
    });
  }
}
