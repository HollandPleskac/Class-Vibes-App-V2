// // stuff that might help

// /*

// client_secret.json in downloads folder
// client id : 368704685264-uvni0feb8ghmos6jhokudb8f3begkj2v.apps.googleusercontent.com

// */

// import 'package:flutter/material.dart';
// import 'package:googleapis_auth/auth_browser.dart';
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/calendar/v3.dart';

// final _credentials = new ServiceAccountCredentials.fromJson(r'''
// {
//   "private_key_id": ...,
//   "private_key": ...,
//   "client_email": ...,
//   "client_id": ...,
//   "type": "service_account"
// }
// ''');

// const _SCOPES = const [CalendarApi.CalendarEventsReadonlyScope];

// void apiCall() async {
//   print('called');
//   final _googleSignIn = new GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/calendar.readonly',
//     ],
//   );

//   print('google sign in');

//   var result = await _googleSignIn.signIn();
//   print('await google sign in ' + result.toString());

//   var headers = await _googleSignIn.currentUser.authHeaders;

//   print('valu');
// print('valu');
//   print('tests');
//   print(result.id.toString());



// print('valu');
// print('valu');


// // clientViaApiKey(headers.values[0]);

















//   // final authHeaders = _googleSignIn.currentUser.authHeaders;
//   // clientViaServiceAccount(_credentials, _SCOPES).then((http_client) {
//   //   var storage = new StorageApi(http_client);
//   //   storage.buckets.list('dart-on-cloud').then((buckets) {
//   //     print("Received ${buckets.items.length} bucket names:");
//   //     for (var file in buckets.items) {
//   //       print(file.name);
//   //     }
//   //   });
//   // });
// }

// class Testing extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton(
//           child: Text('click me'),
//           onPressed: () async {
//             await apiCall();
//           },
//         ),
//       ),
//     );
//   }
// }
