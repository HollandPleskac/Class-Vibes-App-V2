import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';
import '../widgets/no_documents_message.dart';
import '../logic/fire.dart';
import '../logic/fcm.dart';
import '../logic/class_vibes_server.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _fire = Fire();
final _fcm = FCM();
final _classVibesServer = ClassVibesServer();

class ChatTeacher extends StatefulWidget {
  static const routeName = 'teacher-chat';
  final String classId;
  final String studentEmail;

  ChatTeacher({this.classId, this.studentEmail});

  @override
  _ChatTeacherState createState() => _ChatTeacherState();
}

class _ChatTeacherState extends State<ChatTeacher> {
  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;

  String _teacherName;

  Future getTeacherName() async {
    final String email = _firebaseAuth.currentUser.email;
    final String name = await _firestore.collection('UserData').doc(email).get().then((docSnap) => docSnap.data()['display name']);

    _teacherName = name;
  }

  @override
  void initState() {
    getTeacherName().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final routeArguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.9),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              _fire.resetTeacherUnreadCount(
                classId: widget.classId,
                studentEmail: widget.studentEmail,
              );
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: StreamBuilder(
            stream: _firestore
                .collection('UserData')
                .doc(widget.studentEmail)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else {
                return Text(
                  'Chat with ' + snapshot.data['display name'],
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                );
              }
            }),
        // title:
        //   actions: <Widget>[
        //     GestureDetector(
        //       onTap: _showModalSheet,
        //       child: Padding(
        //         padding: const EdgeInsets.all(10),
        //         child: Container(
        //           width: 30,
        //           height: 30,
        //           decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               image: DecorationImage(
        //                   image: NetworkImage(
        //                       'https://i.pinimg.com/736x/9e/e8/9f/9ee89f7623acc78fc33fc0cbaf3a014b.jpg'),
        //                   fit: BoxFit.cover)),
        //         ),
        //       ),
        //     )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: _firestore
                      .collection("Class-Chats")
                      .doc(widget.classId)
                      .collection('Students')
                      .doc(widget.studentEmail)
                      .collection('Messages')
                      .orderBy("timestamp", descending: true)
                      .limit(40)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (!snapshot.hasData ||
                            snapshot.data.docs.length != 0) {
                          return Center(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              reverse: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return snapshot.data.docs[index]
                                            ['sent type'] ==
                                        'student'
                                    ? RecievedChat(
                                        title: snapshot.data.docs[index]
                                            ['user'],
                                        content: snapshot.data.docs[index]
                                            ['message'],
                                      )
                                    : SentChat(
                                        title: snapshot.data.docs[index]
                                            ['user'],
                                        content: snapshot.data.docs[index]
                                            ['message'],
                                      );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: NoDocsChat(),
                          );
                        }
                    }
                  },
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.04,
                                  right:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: TextField(
                                      controller: _controller,
                                      maxLines: 5,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                        hintText: 'Type a message...',
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                                  onPressed: () async {
                                    if (_controller.text != '') {
                                      _fire.incrementStudentUnreadCount(
                                        classId: widget.classId,
                                        studentEmail: widget.studentEmail,
                                      );
                                      await _firestore
                                          .collection('Class-Chats')
                                          .doc(widget.classId)
                                          .collection('Students')
                                          .doc(widget.studentEmail)
                                          .collection('Messages')
                                          .doc()
                                          .set({
                                        'timestamp': DateTime.now(),
                                        'message': _controller.text,
                                        'user': _teacherName,
                                        'sent type': 'teacher',
                                      });
                                      // send a notification to the students device
                                      String acceptedString = widget.studentEmail.replaceAll("@", "-");
                                      acceptedString = acceptedString.replaceAll(".", "-");
                                      await _classVibesServer.sentChatNotification('classes-student-${widget.classId}-$acceptedString', _teacherName, _controller.text);

                                      _controller.clear();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SentChat extends StatelessWidget {
  final String title;
  final String content;

  SentChat({
    this.title,
    this.content,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 100, bottom: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          color: kPrimaryColor,
          //color: Colors.redAccent.shade400.withOpacity(0.3),
        ),
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              Text(
                content,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecievedChat extends StatelessWidget {
  final String title;
  final String content;

  RecievedChat({this.title, this.content});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 100, bottom: 30),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)),
            color: Colors.grey.shade200),
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.grey[800], fontWeight: FontWeight.w800),
              ),
              Text(
                content,
                style: TextStyle(color: Colors.grey[800]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
