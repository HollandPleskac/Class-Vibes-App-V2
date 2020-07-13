import 'package:firebase_auth/firebase_auth.dart';

import './auth.dart';

final _auth = Auth();
final _firebaseAuth = FirebaseAuth.instance;

class Auth {
  Future<List> loginAsStudent({String email, String password}) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = authResult.user;

      return ['success', email];
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          return ['failure', 'No account exist with this email'];
        case "ERROR_USER_DISABLED":
          return ['failure', 'Account has been disabled'];
        case "ERROR_USER_TOKEN_EXPIRED":
          return ['failure', 'User token expired'];
        case "ERROR_EMAIL_ALREADY_IN_USE":
          return ['failure', "Email already in use"];
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          return ['failure', "Email already exists with different account"];
        case "ERROR_CREDENTIAL_ALREADY_IN_USE":
          return ['failure', "Credential already in use"];
      }
    }
    return ['success', email];
  }

  Future<List> loginAsTeacher({String email, String password}) async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = authResult.user;

      return ['success', email];
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          return ['failure', 'No account exist with this email'];
        case "ERROR_USER_DISABLED":
          return ['failure', 'Account has been disabled'];
        case "ERROR_USER_TOKEN_EXPIRED":
          return ['failure', 'User token expired'];
        case "ERROR_EMAIL_ALREADY_IN_USE":
          return ['failure', "Email already in use"];
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          return ['failure', "Email already exists with different account"];
        case "ERROR_CREDENTIAL_ALREADY_IN_USE":
          return ['failure', "Credential already in use"];
      }
    }
    return ['success', email];
  }

  String signUp() {}
}
