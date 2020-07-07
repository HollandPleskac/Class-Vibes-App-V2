import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore _firestore = Firestore.instance;

class Fire {
  void updateClassName(String uid, String newClassName) {
    _firestore.collection("Classes").document(uid).updateData({
      "class name": newClassName,
    });
  }

  void updateAllowJoin(String uid, bool newStatusOnJoin) {
    _firestore.collection("Classes").document(uid).updateData({
      "allow join": newStatusOnJoin,
    });
  }
}
