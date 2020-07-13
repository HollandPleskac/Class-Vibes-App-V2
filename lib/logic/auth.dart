import 'package:firebase_auth/firebase_auth.dart';

import './auth.dart';

final _auth = Auth();
final _firebaseAuth = FirebaseAuth.instance;

class Auth {
  Future<String> loginAsStudent() async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: 'new@gmail.com', password: 'password123');

      FirebaseUser user = authResult.user;

      return 'success';
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          return 'No account exist with this email';
        case "ERROR_USER_DISABLED":
          return 'Account has been disabled';
        case "ERROR_USER_TOKEN_EXPIRED":
          return 'User token expired';
        case "ERROR_EMAIL_ALREADY_IN_USE":
          return "Email already in use";
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          return "Email already exists with different account";
        case "ERROR_CREDENTIAL_ALREADY_IN_USE":
          return "Credential already in use";
      }
    }
    return 'success';
  }

  String loginAsTeacher() {}

  String signUp() {}
}
