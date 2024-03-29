// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// final _firebaseAuth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = GoogleSignIn();
// final _firestore = Firestore.instance;

// class Auth {
//   Future<List> loginAsStudent({String email, String password}) async {
//     try {
//       AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);

//       FirebaseUser user = authResult.user;

//       if (!user.isEmailVerified) {
//         return ['failure', 'Verify your email to continue'];
//       }

//       if (await checkAccountType(email) != 'Student') {
//         return ['failure', 'Account is not registered as a student'];
//       }

//       if (await checkAccountStatus(email) != 'Activated') {
//         return [
//           'failure',
//           'Account is Deactivated. If you think this is a mistake contact {class vibes email}'
//         ];
//       }

//       return ['success', email];
//     } catch (error) {
//       switch (error.code) {
//         case "ERROR_INVALID_EMAIL":
//           return ['failure', 'Email is badly formatted'];
//         case "ERROR_WRONG_PASSWORD":
//           return ['failure', 'Password is incorrect'];
//         case "ERROR_USER_NOT_FOUND":
//           return ['failure', 'No user exists for this email address'];
//         case "ERROR_USER_DISABLED":
//           return ['failure', 'Account has been disabled'];
//         case "ERROR_TOO_MANY_REQUESTS":
//           return [
//             'failure',
//             'Too many requests to sign in please wait to sign in'
//           ];
//         case "ERROR_OPERATION_NOT_ALLOWED":
//           return ['failure', 'Operation not allowed.'];
//         default:
//           return ['failure', 'An unknown error occurred'];
//       }
//     }
//   }

//   Future<List> loginAsTeacher({String email, String password}) async {
//     try {
//       AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);

//       FirebaseUser user = authResult.user;

//       if (!user.isEmailVerified) {
//         return ['failure', 'Verify your email to continue'];
//       }

//       if (await checkAccountType(email) != 'Teacher') {
//         return ['failure', 'Account is not registered as a teacher'];
//       }

//       if (await checkAccountStatus(email) != 'Activated') {
//         return [
//           'failure',
//           'Account is Deactivated. If you think this is a mistake contact {class vibes email}'
//         ];
//       }

//       return ['success', email];
//     } catch (error) {
//       switch (error.code) {
//         case "ERROR_INVALID_EMAIL":
//           return ['failure', 'Email is badly formatted'];
//         case "ERROR_WRONG_PASSWORD":
//           return ['failure', 'Password is incorrect'];
//         case "ERROR_USER_NOT_FOUND":
//           return ['failure', 'No user exists for this email address'];
//         case "ERROR_USER_DISABLED":
//           return ['failure', 'Account has been disabled'];
//         case "ERROR_TOO_MANY_REQUESTS":
//           return [
//             'failure',
//             'Too many requests to sign in please wait to sign in'
//           ];
//         case "ERROR_OPERATION_NOT_ALLOWED":
//           return ['failure', 'Operation not allowed.'];
//         default:
//           return ['failure', 'An unknown error occurred'];
//       }
//     }
//   }

// // if teacher - get district id - check w/ district id and sort out all the errors before signing up

//   Future<List> signUpStudent({
//     String email,
//     String password,
//     String username,
//   }) async {
//     try {
//       AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       FirebaseUser user = result.user;

//       UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//       userUpdateInfo.displayName = username;

//       await user.updateProfile(userUpdateInfo);

//       await user.sendEmailVerification();

//       return ['success', email];
//     } catch (error) {
//       switch (error.code) {
//         case "ERROR_WEAK_PASSWORD":
//           return ['failure', 'Password is not strong enough'];
//         case "ERROR_INVALID_EMAIL":
//           return ['failure', 'Email address formatted incorrectly'];
//         case "ERROR_EMAIL_ALREADY_IN_USE ":
//           return ['failure', 'Email already in use'];
//       }
//     }
//     return ['failure', 'unknown error'];
//   }

//   Future<List> signUpTeacher({
//     String email,
//     String password,
//     String username,
//     String districtId,
//   }) async {
//     //get does district id exist?
//     bool districtIdExists = await _firestore
//         .collection('Districts')
//         .where('district id', isEqualTo: districtId)
//         .getDocuments()
//         .then((querySnap) => querySnap.documents.isNotEmpty);
//     if (districtIdExists) {
//       //is teacher is allowed teachers collection?
//       //change this iselligible to join to be if teacher email split at @ is matching to one in db
//       // bool isEligibleForJoin = await _firestore
//       //     .collection('Districts')
//       //     .document(districtId)
//       //     .collection('Allowed Teachers')
//       //     .where(FieldPath.documentId, isEqualTo: email)
//       //     .getDocuments()
//       //     .then((querySnap) => querySnap.documents.isNotEmpty);
//       bool isEligibleForJoin = true;

//       if (isEligibleForJoin) {
//         // if so --> sign up the teacher
//         print('iseligible');
//         try {
//           AuthResult result = await _firebaseAuth
//               .createUserWithEmailAndPassword(email: email, password: password);
//           FirebaseUser user = result.user;

//           UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//           userUpdateInfo.displayName = username;

//           await user.updateProfile(userUpdateInfo);

//           await user.sendEmailVerification();

//           return ['success', email];
//         } catch (error) {
//           print(error.code);
//           switch (error.code) {
//             case "ERROR_WEAK_PASSWORD":
//               return ['failure', 'Password is not strong enough'];
//             case "ERROR_INVALID_EMAIL":
//               return ['failure', 'Email address formatted incorrectly'];
//             case "ERROR_EMAIL_ALREADY_IN_USE":
//               return ['failure', 'Email already in use'];
//           }
//         }
//       } else {
//         return [
//           'failure',
//           'That email address is not eligible to join this district.  If you think this is an error please contact your district administrator'
//         ];
//       }
//     } else {
//       return ['failure', 'District Id does not extis'];
//     }
//     // this return should never show - all other possibilities are in the tree already
//     print('error unknown');
//     return ['failure', 'unknown error'];
//   }

//   void setUpAccountStudent({String email, String username}) {
//     _firestore.collection('UserData').document(email).setData({
//       'email': email,
//       'display name': username,
//       'account type': 'Student',
//       'account status': 'Activated',
//     });
//   }

//   void setUpAccountTeacher({
//     String email,
//     String username,
//     String districtId,
//   }) async {
//     _firestore.collection('UserData').document(email).setData({
//       'email': email,
//       'display name': username,
//       'account type': 'Teacher',
//       'account status': 'Activated',
//       'district id': districtId,
//     });
//   }

//   Future<String> checkAccountType(String email) async {
//     return await _firestore
//         .collection('UserData')
//         .document(email)
//         .get()
//         .then((docSnap) => docSnap.data['account type']);
//   }

//   Future<String> checkAccountStatus(String email) async {
//     return await _firestore
//         .collection('UserData')
//         .document(email)
//         .get()
//         .then((docSnap) => docSnap.data['account status']);
//   }

//   void signOut() async {
//     await _firebaseAuth.signOut();
//   }

//   Future<void> resetPassword(String email) async {
//     await _firebaseAuth.sendPasswordResetEmail(email: email);
//   }

//   Future<List> signUpWithGoogleStudent() async {
//     // if (await _googleSignIn.isSignedIn() == true) {
//     //   await _googleSignIn.signOut();
//     // }
//     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//     print(googleUser.email);
//     bool isUserInDB = await _firestore
//         .collection('UserData')
//         .where('email', isEqualTo: googleUser.email)
//         .getDocuments()
//         .then((querySnap) => querySnap.documents.isNotEmpty);
//     if (isUserInDB == true) {
//       return ['failure', 'User is already registered'];
//     }

//     setUpAccountStudent(
//         email: googleUser.email, username: googleUser.displayName);

//     // final GoogleSignInAuthentication googleAuth =
//     //     await googleUser.authentication;

//     // final AuthCredential credential = GoogleAuthProvider.getCredential(
//     //   accessToken: googleAuth.accessToken,
//     //   idToken: googleAuth.idToken,
//     // );

//     // final FirebaseUser user =
//     //     (await _firebaseAuth.signInWithCredential(credential)).user;

//     // print("signed in " + user.displayName);
//     // if the user is not email verified which they arenet at this point
//     // send them to the sign in teacher screen
//     // and check if they verify their email
//     return ['success', ''];
//   }

//   Future<List> signInWithGoogleStudent() async {

//     // if (await _googleSignIn.isSignedIn() == true) {
//     //   await _googleSignIn.signOut();
//     // }
//     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//     print(googleUser.email);

//     bool isUserInDB = await _firestore
//         .collection('UserData')
//         .where('email', isEqualTo: googleUser.email)
//         .getDocuments()
//         .then((querySnap) => querySnap.documents.isNotEmpty);
//     if (isUserInDB == false) {
//       return ['failure', 'User is not registered'];
//     }

//     String accountType = await _firestore
//         .collection('UserData')
//         .document(googleUser.email)
//         .get()
//         .then((docSnap) => docSnap.data['account type']);

//     if (accountType != 'Student') {
//       return ['failure', 'Account is not registered as a student'];
//     } else {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.getCredential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final FirebaseUser user =
//           (await _firebaseAuth.signInWithCredential(credential)).user;
//       print("signed in " + user.displayName);

//       UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//       userUpdateInfo.displayName = user.displayName;

//       await user.updateProfile(userUpdateInfo);
//       return ['success', ''];
//     }

//     // if the user is not email verified which they arenet at this point
//     // send them to the sign in teacher screen
//     // and check if they verify their email
//   }

//   Future<List> signUpWithGoogleTeacher(String districtCode) async {
//     // to show the full google popup and let them choose an account
//     // if (await _googleSignIn.isSignedIn() == true) {
//     //   await _googleSignIn.disconnect();
//     // }

//     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//     print(googleUser.email);
//     bool isUserInDB = await _firestore
//         .collection('UserData')
//         .where('email', isEqualTo: googleUser.email)
//         .getDocuments()
//         .then((querySnap) => querySnap.documents.isNotEmpty);
//     if (isUserInDB == true) {
//       return ['failure', 'User is already registered'];
//     }

//     bool districtIdExists = await _firestore
//         .collection('Districts')
//         .where('district id', isEqualTo: districtCode)
//         .getDocuments()
//         .then((querySnap) => querySnap.documents.isNotEmpty);

//     if (districtIdExists == false) {
//       return ['failure', 'That district code does not exist'];
//     }

//     setUpAccountTeacher(
//         email: googleUser.email,
//         username: googleUser.displayName,
//         districtId: districtCode);

//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     final FirebaseUser user =
//         (await _firebaseAuth.signInWithCredential(credential)).user;

//     print("signed in " + user.displayName);

//     return ['success', 'Successfully Signed Up'];
//   }

//   Future<List> signInWithGoogleTeacher() async {
    
//     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//     print(googleUser.email);

//     bool isUserInDB = await _firestore
//         .collection('UserData')
//         .where('email', isEqualTo: googleUser.email)
//         .getDocuments()
//         .then((querySnap) => querySnap.documents.isNotEmpty);
//     if (isUserInDB == false) {
//       return ['failure', 'User is not registered'];
//     }
//     print('user is in db');

//     String accountType = await _firestore
//         .collection('UserData')
//         .document(googleUser.email)
//         .get()
//         .then((docSnap) => docSnap.data['account type']);

//     if (accountType != 'Teacher') {
//       return ['failure', 'Account is not registered as a teacher'];
//     } else {
//       print('account is set up as a teacher');
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.getCredential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final FirebaseUser user =
//           (await _firebaseAuth.signInWithCredential(credential)).user;
//       print("signed in " + user.displayName);

//       UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
//       userUpdateInfo.displayName = user.displayName;

//       await user.updateProfile(userUpdateInfo);
//       return ['success', ''];
//     }
//   }
// }
