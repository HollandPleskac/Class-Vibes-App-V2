import 'package:firebase_auth/firebase_auth.dart';

import 'fire.dart';

final _fire = Fire();

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }

  // Student

  Future<String> signin(String email, String password) async {
    try {
      final UserCredential cred = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (!cred.user.emailVerified) {
        await cred.user.sendEmailVerification();
        return 'Verify your email to continue. We sent you a verification email.';
      }

      if (await _fire.getAccountType(email) != 'Student') {
        return 'Account exists as a teacher. Please use the teacher sign in';
      }

      return "Signed in";
    } on FirebaseAuthException catch (e) {
      if (await _fire.getAccountType(email) != 'Student') {
        return 'Account exists as a teacher. Please use the teacher sign in';
      }
      switch (e.code) {
        case 'invalid-email':
          return 'The email address is not valid';
        case 'user-disabled':
          return 'The user cooresponding to this email address has been disabled';
        case 'user-not-found':
          return 'No user exists with this email address';
        case 'wrong-password':
          return 'The password is incorrect';
        default:
          return 'An unknown error occurred';
      }
    } catch (e) {
      return 'An unknown error occurred';
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return 'signed up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.message;
    }
  }

  // Teacher

}
