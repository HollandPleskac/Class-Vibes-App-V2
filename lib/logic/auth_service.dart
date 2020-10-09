import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'fire.dart';
import 'revenue_cat.dart';

final _revenueCat = RevenueCat();
final _fire = Fire();

class AuthenticationService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }

  // Student Email

  Future<String> signInEmailStudent(String email, String password) async {
    try {
      final UserCredential cred = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (await _fire.getAccountType(email) != 'Student') {
        await _firebaseAuth.signOut();
        return 'Account exists as a teacher. Please use the teacher sign in';
      }

      if (!cred.user.emailVerified) {
        await cred.user.sendEmailVerification();
        await _firebaseAuth.signOut();
        return 'Verify your email to continue. We sent you a verification email.';
      }

      await _revenueCat.signInRevenueCat(cred.user.uid);

      return "Signed in";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return 'The email address is not valid';
        case 'user-disabled':
          return 'The user cooresponding to this email address has been disabled';
        case 'user-not-found':
          return 'No user exists with this email address. Please sign up first.';
        case 'wrong-password':
          return 'The password is incorrect';
        default:
          return 'An unknown error occurred';
      }
    } catch (e) {
      print(e);
      return 'An unknown error occurred';
    }
  }

  Future<String> signUpEmailStudent(String email, String password) async {
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

  // Student Google

  Future<String> signInGoogleStudent() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print(googleUser.email);

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final User user =
          (await _firebaseAuth.signInWithCredential(credential)).user;

      if (await _fire.isUserInDb(user.email) == false) {
        await _firebaseAuth.signOut();
        return 'No user exists with this email address. Please sign up first.';
      }

      if (await _fire.getAccountType(user.email) != 'Student') {
        await _firebaseAuth.signOut();
        return 'Account exists as a teacher. Please use the teacher sign in';
      }

      await _revenueCat.signInRevenueCat(user.uid);
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          return 'Account exists with a different credential';

        case 'invalid-credential':
          return 'The credential is invalid';

        case 'operation-not-allowed':
          return 'Operation not allowed. Your account is not enabled';

        case 'user-disabled':
          return 'The user cooresponding to this email address has been disabled';

        case 'user-not-found':
          return 'No user exists with this email address. Please sign up first.';

        case 'wrong-password':
          return 'The password is incorrect';

        case 'invalid-verification-code':
          return 'The verification code is incorrect';

        case 'invalid-verification-id':
          return 'The verification id is incorrect';

        default:
          return 'An unknown error occurred';
      }
    } catch (e) {
      print(e);
      return 'An unknown error occurred';
    }
  }

  // Teacher Email

  // Teacher Google

}
