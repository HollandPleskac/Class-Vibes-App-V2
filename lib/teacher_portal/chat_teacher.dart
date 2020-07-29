import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';

final Firestore _firestore = Firestore.instance;

class ChatTeacher extends StatefulWidget {
  static const routeName = 'teacher-chat';

  @override
  _ChatTeacherState createState() => _ChatTeacherState();
}

class _ChatTeacherState extends State<ChatTeacher> {
  final TextEditingController _controller = TextEditingController();
  void _showModalSheet() {
    showModalBottomSheet(
        barrierColor: Colors.white.withOpacity(0),
        elevation: 0,
        context: context,
        builder: (builder) {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Options',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.do_not_disturb,
                        color: Colors.black87,
                      ),
                      title: Text(
                        'Mute Messages',
                        style: TextStyle(color: Colors.black87),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context).settings.arguments as Map;
    final String classId = routeArguments['class id'];
    final String teacherName = routeArguments['teacher name'];
    final String studentEmail = routeArguments['student uid'];
    final String studentName = routeArguments['student name'];
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
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text(
          'Chat with ' + studentName,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: _showModalSheet,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                        fit: BoxFit.cover)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: StreamBuilder(
                    stream: _firestore
                        .collection("Class-Chats")
                        .document(classId)
                        .collection(studentEmail)
                        .orderBy("timestamp", descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      //FIX THIS
                      if (!snapshot.hasData)
                        return Center(
                          child: Text('No Chat History'),
                        );
                      print('SNAPPPP : '+snapshot.data.toString());
                      print('SOMEHTING : '+snapshot.data.documents[0].data.toString());
                      return Center(
                        child: ListView(
                          reverse: true,
                          children: snapshot.data.documents.map(
                            (DocumentSnapshot document) {
                              print('THIS DOC + ' + document.toString());
                              return document['sent type'] == 'student'
                                  ? RecievedChat(
                                      title: document['user'],
                                      content: document['message'],
                                    )
                                  : SentChat(
                                      title: document['user'],
                                      content: document['message'],
                                    );
                            },
                          ).toList(),
                        ),
                      );
                    }),
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
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      // await _firestore
                                      //     .collection('Classes')
                                      //     .document(classId)
                                      //     .collection('Students')
                                      //     .document(studentEmail)
                                      //     .collection("Chats")
                                      //     .document()
                                      //     .setData({
                                      //   'date': DateTime.now(),
                                      //   'content': _controller.text,
                                      //   'title': teacherName,
                                      //   'sent type': 'teacher'
                                      // });

                                      await _firestore
                                          .collection('Class-Chats')
                                          .document(classId)
                                          .collection(studentEmail)
                                          .document()
                                          .setData({
                                        'timestamp': DateTime.now(),
                                        'message': _controller.text,
                                        'user': teacherName,
                                        'sent type': 'teacher'
                                      });
                                      _controller.clear();
                                    }),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  // child: Center(
                                  //   child: Text(
                                  //     'Hello Mr. Shea I need help with math',
                                  //     style: TextStyle(color: Colors.black),
                                  //   ),
                                  // ),
                                  //SIZE THIS
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.675,
                                      child: TextField(
                                        controller: _controller,
                                      ),
                                    ),
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
          color: kPrimaryColor.withOpacity(0.5),
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
