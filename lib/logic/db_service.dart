import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';

class DatabaseService {
  final FirebaseFirestore _db;

  DatabaseService(this._db);

  // get a single document
  Future<Class> getClass(String id) async {
    var snap = await _db.collection('Classes').doc(id).get();
    return Class.fromFirestore(snap);
  }

  // Get a stream of a single document
  Stream<Class> streamClass(String id) {
    return _db.collection('Classes').doc(id).snapshots().map(
          (snap) => Class.fromFirestore(snap),
        );
  }

  // Query a collection
  // returns a list of snapshots => take the list then map each item in the list to a Class

  Stream<List<Class>> streamClasses(User user) {
    var ref =
        _db.collection('Classes').where('teacher email', isEqualTo: user.email);

    return ref.snapshots().map(
          (list) => list.docs.map(
            (doc) => Class.fromFirestore(doc),
          ),
        );
  }
}
