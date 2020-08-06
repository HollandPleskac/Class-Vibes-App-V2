//only used for chat functions

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  Future<List<DocumentSnapshot>> fetchFirstList(String classId, String studentEmail) async {
    return (await Firestore.instance
            .collection("Class-Chats")
                    .document(classId)
                    .collection('Students')
                    .document(studentEmail)
                    .collection('Messages')
                    .orderBy("timestamp", descending: true)
            .limit(10)
            .getDocuments())
        .documents;
  }

  Future<List<DocumentSnapshot>> fetchNextList(
      List<DocumentSnapshot> documentList, String classId, String studentEmail,) async {
    return (await Firestore.instance
            .collection("Class-Chats")
                    .document(classId)
                    .collection('Students')
                    .document(studentEmail)
                    .collection('Messages')
                    .orderBy("timestamp", descending: true)
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(10)
            .getDocuments())
        .documents;
  }
}