// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class Testing extends StatefulWidget {
//   @override
//   _TestingState createState() => _TestingState();
// }

// class _TestingState extends State<Testing> {
//   @override
//   void initState() {
//     print('init state');
//     // Dart client

//     IO.Socket socket = IO.io('http://localhost:3000');
//     socket.on('connect', (_) {
//       print('connect');
//     });
//     print('data?');
//     socket.on('connect', (data) => print(data));
//     socket.on('disconnect', (_) => print('disconnect'));
//     socket.on('fromServer', (_) => print(_));
//     socket.connect();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FlatButton(
//           child: Text('connect'),
//           onPressed: () {}
//         ),
//       ),
//     );
//   }
// }
