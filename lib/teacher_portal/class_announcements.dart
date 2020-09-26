import 'dart:ui';

import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../logic/fire.dart';
import './class_announcements.dart';
import '../widgets/announcements.dart';
import '../logic/class_vibes_server.dart';

final Firestore _firestore = Firestore.instance;
final _fire = Fire();

final _classVibesServer = ClassVibesServer();

class ClassAnnouncements extends StatelessWidget {
  final String classId;

  ClassAnnouncements({
    this.classId,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          StreamBuilder(
            stream: _firestore
                .collection("Classes")
                .document(classId)
                .collection('Announcements')
                .orderBy("date", descending: true).limit(50)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Container(),
                  );
                default:
                  if (snapshot.data != null &&
                      snapshot.data.documents.isEmpty == false) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          child: TeacherAnnouncement(
                            message: snapshot.data.documents[index]['message'],
                            title: snapshot.data.documents[index]['title'],
                            timestamp: DateTime.parse(snapshot
                                .data.documents[index]['date']
                                .toDate()
                                .toString()),
                            announcementId:
                                snapshot.data.documents[index].documentID,
                            classId: classId,
                          ),
                        );
                      },
                    );
                    // return ListView(
                    //   physics: BouncingScrollPhysics(),
                    //   children: snapshot.data.documents
                    //       .map((DocumentSnapshot document) {
                    //     return Padding(
                    //       padding: EdgeInsets.only(
                    //           top: 20, left: 20, right: 20, bottom: 20),
                    //       child: TeacherAnnouncement(
                    //         message: document['message'],
                    //         title: document['title'],
                    //         timestamp: DateTime.parse(
                    //             document['date'].toDate().toString()),
                    //         announcementId: document.documentID,
                    //         classId: classId,
                    //       ),
                    //     );
                    //   }).toList(),
                    // );
                  } else {
                    return Center(
                      child: NoDocsAnnouncementsClassTeacher(),
                    );
                  }
              }
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20, bottom: 20),
              child: PushAnnouncementBtn(
                classId: classId,
                getClassName: () async => await _firestore
                    .collection('Classes')
                    .document(classId)
                    .get()
                    .then((docSnap) => docSnap.data['class name']),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PushAnnouncementBtn extends StatelessWidget {
  String classId;
  Function getClassName;

  PushAnnouncementBtn({this.classId, this.getClassName});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        icon: FaIcon(FontAwesomeIcons.bullhorn),
        backgroundColor: kPrimaryColor,
        label: Text(
          'Send Announcement',
          style: TextStyle(fontSize: 15),
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Send Announcment',
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14),
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1),
                                          controller: _titleController,
                                          validator: (value) {
                                            if (value == null || value == '') {
                                              return 'announcement has to have a title';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 18),
                                            labelStyle: TextStyle(),
                                            hintText: 'Title',
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14),
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1),
                                          controller: _contentController,
                                          validator: (value) {
                                            if (value == null || value == '') {
                                              return 'announcement has to have a message';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 18),
                                            labelStyle: TextStyle(),
                                            hintText: 'Message',
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Center(
                                      child: Container(
                                        child: new Material(
                                          child: new InkWell(
                                            onTap: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _fire.pushAnnouncement(
                                                  classId: classId,
                                                  title: _titleController.text,
                                                  content:
                                                      _contentController.text,
                                                  className:
                                                      await getClassName(),
                                                );
                                            

                                                _classVibesServer
                                                    .sendEmailForAnnouncement(
                                                  classId,
                                                  _titleController.text,
                                                  _contentController.text,
                                                  await getClassName(),
                                                );
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: new Container(
                                              child: Center(
                                                child: Text(
                                                  'Push',
                                                  style: TextStyle(
                                                      color: Colors.grey[100],
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          color: Colors.transparent,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent[400],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}

/*showModalBottomSheet(
          barrierColor: Colors.white.withOpacity(0),
          elevation: 0,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ClipRect(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Push an Announcement',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                child: TextFormField(
                                  controller: _titleController,
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      return 'announcement has to have a title';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Color.fromRGBO(126, 126, 126, 1),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                    hintText: 'Title',
                                    icon: FaIcon(FontAwesomeIcons.speakap),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                child: TextFormField(
                                  controller: _contentController,
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      return 'announcement has to have a message';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Color.fromRGBO(126, 126, 126, 1),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                    hintText: 'Message',
                                    icon: FaIcon(FontAwesomeIcons.speakap),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(right: 20, bottom: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    color: kPrimaryColor,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        _fire.pushAnnouncement(
                                          classId: classId,
                                          title: _titleController.text,
                                          content: _contentController.text,
                                          className: await getClassName(),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      'Push',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: MediaQuery.of(context).size.height * 0.35,
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
        */
