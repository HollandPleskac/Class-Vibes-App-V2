import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './class_vibes_server.dart';
import './fire.dart';
import './revenue_cat.dart';

final _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final _classVibesServer = ClassVibesServer();
final _revenueCat = RevenueCat();

final _fire = Fire();

class Auth {
  Future<List> loginAsStudent({String email, String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;

      if (!user.emailVerified) {
        print('current user : '+_firebaseAuth.currentUser.toString());
        print(user);
        return ['failure', 'Verify your email to continue'];
      }

      if (await checkAccountType(email) != 'Student') {
        return ['failure', 'Account is not registered as a student'];
      }

      await _revenueCat.signInRevenueCat(user.uid);
      await _fire.storeToken(email);
      await _fire.storeTokenStudent(email);
      return ['success', email];
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          return ['failure', 'Email is badly formatted'];
        case "ERROR_WRONG_PASSWORD":
          return ['failure', 'Password is incorrect'];
        case "ERROR_USER_NOT_FOUND":
          return ['failure', 'No user exists for this email address'];
        case "ERROR_USER_DISABLED":
          return ['failure', 'Account has been disabled'];
        case "ERROR_TOO_MANY_REQUESTS":
          return [
            'failure',
            'Too many requests to sign in please wait to sign in'
          ];
        case "ERROR_OPERATION_NOT_ALLOWED":
          return ['failure', 'Operation not allowed.'];
        default:
          return ['failure', 'An unknown error occurred'];
      }
    }
  }

  Future<List> loginAsTeacher({String email, String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;

      if (!user.emailVerified) {
        return ['failure', 'Verify your email to continue'];
      }

      if (await checkAccountType(email) != 'Teacher') {
        return ['failure', 'Account is not registered as a teacher'];
      }

      await _revenueCat.signInRevenueCat(user.uid);
      await _fire.storeToken(email);
      return ['success', email];
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          return ['failure', 'Email is badly formatted'];
        case "ERROR_WRONG_PASSWORD":
          return ['failure', 'Password is incorrect'];
        case "ERROR_USER_NOT_FOUND":
          return ['failure', 'No user exists for this email address'];
        case "ERROR_USER_DISABLED":
          return ['failure', 'Account has been disabled'];
        case "ERROR_TOO_MANY_REQUESTS":
          return [
            'failure',
            'Too many requests to sign in please wait to sign in'
          ];
        case "ERROR_OPERATION_NOT_ALLOWED":
          return ['failure', 'Operation not allowed.'];
        default:
          return ['failure', 'An unknown error occurred'];
      }
    }
  }

// if teacher - get district id - check w/ district id and sort out all the errors before signing up

  Future<List> signUpStudent({
    String email,
    String password,
    String username,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      await user.sendEmailVerification();

      return ['success', email];
    } catch (error) {
      switch (error.code) {
        case "ERROR_WEAK_PASSWORD":
          return ['failure', 'Password is not strong enough'];
        case "ERROR_INVALID_EMAIL":
          return ['failure', 'Email address formatted incorrectly'];
        case "ERROR_EMAIL_ALREADY_IN_USE ":
          return ['failure', 'Email already in use'];
        default:
          return ['failure', 'an unknown error occurred'];
      }
    }
    return ['failure', 'unknown error'];
  }

  Future<List> signUpTeacher({
    String email,
    String password,
    String username,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      await user.sendEmailVerification();

      await _classVibesServer.createStripeCustomer(email);

      return ['success', email];
    } catch (error) {
      print(error.code);
      switch (error.code) {
        case "ERROR_WEAK_PASSWORD":
          return ['failure', 'Password is not strong enough'];
        case "ERROR_INVALID_EMAIL":
          return ['failure', 'Email address formatted incorrectly'];
        case "ERROR_EMAIL_ALREADY_IN_USE":
          return ['failure', 'Email already in use'];
        default:
          return ['failure', 'An unknown error occurred'];
      }
    }
  }

  Future<void> setUpAccountStudent({String email, String username}) async {
    await _firestore.collection('UserData').doc(email).set({
      'email': email,
      'display name': username,
      'account type': 'Student',
      'account status': 'Activated',
    });

    await _fire.storeToken(email);
    await _fire.storeTokenStudent(email);
  }

  Future<void> setUpAccountTeacher({
    String email,
    String username,
  }) async {
    await _firestore.collection('UserData').doc(email).set({
      'email': email,
      'display name': username,
      'account type': 'Teacher',
      'account status': 'Activated',
    });
    await _fire.storeToken(email);
    await _fire.addTrialClass(email);
  }

  Future<String> checkAccountType(String email) async {
    return await _firestore
        .collection('UserData')
        .doc(email)
        .get()
        .then((docSnap) => docSnap['account type']);
  }

  Future signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await _revenueCat.signOutRevenueCat();
  }

  Future signOutFirebase() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future signOutGoogle() async {
    await _googleSignIn.signOut();
    await _revenueCat.signOutRevenueCat();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<List> signUpWithGoogleStudent() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      try {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final User user =
            (await _firebaseAuth.signInWithCredential(credential)).user;

        bool isUserInDB = await _firestore
            .collection('UserData')
            .where('email', isEqualTo: googleUser.email)
            .get()
            .then((querySnap) => querySnap.docs.isNotEmpty);
        if (isUserInDB == true) {
          signOutFirebase();
          return ['failure', 'User is already registered'];
        }

        print("signed in " + user.displayName);

        await setUpAccountStudent(
            email: user.email, username: user.displayName);

        await _revenueCat.signInRevenueCat(user.uid);
        return ['success', ''];
      } catch (error) {
        return ['failure', 'an error occurred'];
      }
    } catch (e) {
      print(e);
      return ['failure', e];
    }
  }

  Future<List> signInWithGoogleStudent() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
    try {
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

            print('EMAIL VERIFICATION : ' + user.emailVerified.toString());

        bool isUserInDB = await _firestore
            .collection('UserData')
            .where('email', isEqualTo: googleUser.email)
            .get()
            .then((querySnap) => querySnap.docs.isNotEmpty);
        if (isUserInDB == false) {
          signOutFirebase();
          return ['failure', 'User is not registered'];
        }

        String accountType = await _firestore
            .collection('UserData')
            .doc(googleUser.email)
            .get()
            .then((docSnap) => docSnap['account type']);

        if (accountType != 'Student') {
          signOutFirebase();
          return ['failure', 'Account is not registered as a student'];
        }
        print("signed in " + user.displayName);

        await _revenueCat.signInRevenueCat(user.uid);
        await _fire.storeToken(user.email);
        await _fire.storeTokenStudent(user.email);
        return ['success', ''];
      } catch (error) {
        switch (error.code) {
          case "ERROR_INVALID_CREDENTIAL":
            return ['failure', 'invalid credential'];
          case "ERROR_USER_DISABLED":
            return ['failure', 'user disabled'];
          case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
            return ['failure', 'accout exists with different credential'];
          case "ERROR_OPERATION_NOT_ALLOWED":
            return ['failure', 'operation not allowed'];
          case "ERROR_INVALID_ACTION_CODE":
            return ['failure', 'invalid action code'];
          default:
            return ['failure', 'an unknown error occurred'];
        }
      }
    } catch (e) {
      print(e);
      return ['failure', e];
    }
  }

  Future<List> signUpWithGoogleTeacher() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user =
          (await _firebaseAuth.signInWithCredential(credential)).user;

      bool isUserInDB = await _firestore
          .collection('UserData')
          .where('email', isEqualTo: googleUser.email)
          .get()
          .then((querySnap) => querySnap.docs.isNotEmpty);
      if (isUserInDB == true) {
        signOutFirebase();
        return ['failure', 'User is already registered'];
      }

      print("signed in " + user.displayName);

      await _classVibesServer.createStripeCustomer(user.email);

      await setUpAccountTeacher(
        email: user.email,
        username: user.displayName,
      );

      await _revenueCat.signInRevenueCat(user.uid);
      return ['success', 'Successfully Signed Up'];
    } catch (e) {
      print(e);
      return ['failure', e];
    }
  }

  Future<List> signInWithGoogleTeacher() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }

    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user =
          (await _firebaseAuth.signInWithCredential(credential)).user;

      bool isUserInDB = await _firestore
          .collection('UserData')
          .where('email', isEqualTo: googleUser.email)
          .get()
          .then((querySnap) => querySnap.docs.isNotEmpty);
      if (isUserInDB == false) {
        signOutFirebase();
        return ['failure', 'User is not registered'];
      }

      String accountType = await _firestore
          .collection('UserData')
          .doc(googleUser.email)
          .get()
          .then((docSnap) => docSnap['account type']);

      if (accountType != 'Teacher') {
        signOutFirebase();
        return ['failure', 'Account is not registered as a teacher'];
      }

      print("signed in " + user.displayName);

      await _revenueCat.signInRevenueCat(user.uid);
      await _fire.storeToken(user.email);
      return ['success', ''];
    } catch (e) {
      print(e);
      return ['failure', e];
    }
  }
}
