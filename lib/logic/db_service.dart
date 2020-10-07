import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db;

  DatabaseService(this._db);

  // Future<String> get accountType async => await _db.collection("UserData").doc(email).get().then(
  //         (doc) => doc['account type'],
  //       );
  
}
