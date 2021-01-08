//TODO : sign up as a teacher

import 'package:class_vibes_v2/logic/class_vibes_server.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'fire.dart';
import 'revenue_cat.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

final _revenueCat = RevenueCat();
final _fire = Fire();
final _classVibesServer = ClassVibesServer();


class AuthenticationService {
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await _revenueCat.signOutRevenueCat();
  }

  Future<void> signoutFirebase() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future signOutGoogle() async {
    // for deleting accounts - leaves firebase user to be deleted
    await _googleSignIn.signOut();
    await _revenueCat.signOutRevenueCat();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
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
      await _fire.subscribeToClasses(email,'Student',cred.user.uid);
      await _classVibesServer.logPlatformSignIn(email);

      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print('firebase code : '+ e.code);
      switch (e.code) {
        case 'invalid-email':
          return 'The email address is not valid';
        case 'user-disabled':
          return 'The user cooresponding to this email address has been disabled';
        case 'user-not-found':
          return 'No user exists with this email address. Please sign up first.';
        case 'wrong-password':
          return 'The password is incorrect';
        case 'too-many-requests':
          return 'Too many requests.  Try again in 5 minutes.';
        default:
          return 'An unknown error occurred';
      }
    } catch (e) {
      print('error '+e.toString());
      return e.toString();
    }
  }

  Future<String> signUpEmailStudent(
    String email,
    String password,
    String confirmPassword,
    String username,
    bool checkedBox,
  ) async {
    try {
      if (checkedBox == false) {
        return 'Accept the Terms of Service and the Privacy Policy to continue';
      }

      if (password != confirmPassword) {
        return 'Please make sure the password field matches the confirm password field';
      }
      UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await cred.user.sendEmailVerification();

      await _fire.setUpAccountStudent(email, username);
      await _classVibesServer.logPlatformSignIn(email);


      return 'Signed up';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'That email is already in use';
        case 'email-already-in-use':
          return 'That email is not valid';
        case 'operation-not-allowed':
          return 'Email/Password sign in has been disabled';
        case 'weak-password':
          return 'Password is not strong enough';
        default:
          return 'An unknown error occurred';
      }
    } catch (e) {
      return e.toString();
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
        await signoutFirebase();
        return 'No user exists with this email address. Please sign up first.';
      }

      if (await _fire.getAccountType(user.email) != 'Student') {
        await signoutFirebase();
        return 'Account exists as a teacher. Please use the teacher sign in';
      }

      await _revenueCat.signInRevenueCat(user.uid);
      await _fire.subscribeToClasses(user.email,'Student',user.uid);
      await _classVibesServer.logPlatformSignIn(user.email);


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
      return e.toString();
    }
  }

  Future<String> signUpGoogleStudent() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final User user =
          (await _firebaseAuth.signInWithCredential(credential)).user;

      if (await _fire.isUserInDb(user.email) == true) {
        await signoutFirebase();
        return 'An account already exists with this email address. Use the sign in portals to access your account.';
      }

      await _fire.setUpAccountStudent(user.email, user.displayName);

      await _revenueCat.signInRevenueCat(user.uid);
      await _classVibesServer.logPlatformSignIn(user.email);


      return 'Signed up';
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
      return e.toString();
    }
  }

  // Teacher Email

  Future<String> signInEmailTeacher(String email, String password) async {
    try {
      final UserCredential cred = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (await _fire.getAccountType(email) != 'Teacher') {
        await _firebaseAuth.signOut();
        return 'Account exists as a student. Please use the student sign in';
      }

      if (!cred.user.emailVerified) {
        await cred.user.sendEmailVerification();
        await _firebaseAuth.signOut();
        return 'Verify your email to continue. We sent you a verification email.';
      }

      await _revenueCat.signInRevenueCat(cred.user.uid);
      await _fire.subscribeToClasses(email,'Teacher',cred.user.uid);
      await _classVibesServer.logPlatformSignIn(email);


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
        case 'too-many-requests':
          return 'Too many requests.  Try again in 5 minutes.';
        default:
          return 'An unknown error occurred';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<String> signUpEmailTeacher(
    String email,
    String password,
    String confirmPassword,
    String username,
    bool checkedBox,
  ) async {
    try {
      if (checkedBox == false) {
        return 'Accept the Terms of Service and the Privacy Policy to continue';
      }

      if (password != confirmPassword) {
        return 'Please make sure the password field matches the confirm password field';
      }
      UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await cred.user.sendEmailVerification();

      await _fire.addTrialClass(cred.user.email);

      await _fire.setUpAccountTeacher(email, username);
      await _classVibesServer.logPlatformSignIn(email);


      return 'Signed up';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'That email is already in use';
        case 'email-already-in-use':
          return 'That email is not valid';
        case 'operation-not-allowed':
          return 'Email/Password sign in has been disabled';
        case 'weak-password':
          return 'Password is not strong enough';
        default:
          return 'An unknown error occurred';
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Teacher Google

  Future<String> signInGoogleTeacher() async {
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
        await signoutFirebase();
        return 'No user exists with this email address. Please sign up first.';
      }

      if (await _fire.getAccountType(user.email) != 'Teacher') {
        await signoutFirebase();
        return 'Account exists as a student. Please use the student sign in';
      }

      await _revenueCat.signInRevenueCat(user.uid);
      await _fire.subscribeToClasses(user.email,'Teacher',user.uid);
      await _classVibesServer.logPlatformSignIn(user.email);


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
      return e.toString();
    }
  }

  Future<String> signUpGoogleTeacher() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final User user =
          (await _firebaseAuth.signInWithCredential(credential)).user;

      if (await _fire.isUserInDb(user.email) == true) {
        await signoutFirebase();
        return 'An account already exists with this email address. Use the sign in portals to access your account.';
      }

      await _fire.setUpAccountTeacher(user.email, user.displayName);
      print('set up teacher account');

      await _fire.addTrialClass(user.email);
      print('added trial class');

      await _revenueCat.signInRevenueCat(user.uid);
      print('signed in with revenue cat');

      await _classVibesServer.logPlatformSignIn(user.email);


      return 'Signed up';
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
      return e.toString();
    }
  }
}
