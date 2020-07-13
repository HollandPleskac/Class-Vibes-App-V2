import 'package:firebase_auth/firebase_auth.dart';

import './auth.dart';

final _auth = Auth();
final _firebaseAuth = FirebaseAuth.instance;

class Auth {
  Future<List> loginAsStudent() async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: 'new3@gmail.com', password: 'password123');

      FirebaseUser user = authResult.user;

      return ['success','new@gmail.com'];
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          return ['failure','No account exist with this email'];
        case "ERROR_USER_DISABLED":
          return ['failure','Account has been disabled'];
        case "ERROR_USER_TOKEN_EXPIRED":
          return ['failure','User token expired'];
        case "ERROR_EMAIL_ALREADY_IN_USE":
          return ['failure',"Email already in use"];
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          return ['failure',"Email already exists with different account"];
        case "ERROR_CREDENTIAL_ALREADY_IN_USE":
          return ['failure',"Credential already in use"];
      }
    }
    return ['success','new@gmail.com'];
  }

  Future<List> loginAsTeacher() async {
    try {
      AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: 'new1@gmail.com', password: 'password123');

      FirebaseUser user = authResult.user;

      return ['success','new1@gmail.com'];
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          return ['failure','No account exist with this email'];
        case "ERROR_USER_DISABLED":
          return ['failure','Account has been disabled'];
        case "ERROR_USER_TOKEN_EXPIRED":
          return ['failure','User token expired'];
        case "ERROR_EMAIL_ALREADY_IN_USE":
          return ['failure',"Email already in use"];
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          return ['failure',"Email already exists with different account"];
        case "ERROR_CREDENTIAL_ALREADY_IN_USE":
          return ['failure',"Credential already in use"];
      }
    }
    return ['success','new1@gmail.com'];
  }

  String signUp() {}
}
