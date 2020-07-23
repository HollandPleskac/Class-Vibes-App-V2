import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../logic/fire.dart';
import './class_announcements.dart';

final Firestore _firestore = Firestore.instance;
final _fire = Fire();

class ClassAnnouncements extends StatelessWidget {
  final String classId;

  ClassAnnouncements({
    this.classId,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            flex: 7,
            child: StreamBuilder(
              stream: _firestore
                  .collection("Classes")
                  .document(classId)
                  .collection('Announcements')
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return ListView(
                        physics: BouncingScrollPhysics(),
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 20, left: 40, right: 40, bottom: 20),
                            child: Announcement(
                              message: document['content'],
                              timestamp: DateTime.parse(
                                  document['timestamp'].toDate().toString()),
                              announcementId: document.documentID,
                              classId: classId,
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: NoDocsAnnouncementsClassTeacher(),
                      );
                    }
                }
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Align(
                alignment: Alignment.centerRight,

                child: Padding(
                  padding: EdgeInsets.only(right: 20),
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
            ),
          ),
        ],
      ),
    );
  }
}

class Announcement extends StatelessWidget {
  final String message;
  final DateTime timestamp;
  final String announcementId;
  final String classId;

  Announcement({
    this.message,
    this.timestamp,
    this.announcementId,
    this.classId,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(235, 235, 235, 1),
      ),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: 8,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7.5,
                ),
                Text(
                  DateFormat.yMMMMd('en_US')
                      .add_jm()
                      .format(timestamp)
                      .toString(),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () {
                print('delet');
                _fire.deleteAnnouncement(
                  classId: classId,
                  announcementId: announcementId,
                );
              },
              child: FaIcon(
                FontAwesomeIcons.trash,
                color: Colors.grey,
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
      label: Text(
        'Push Announcement',
        style: TextStyle(fontSize: 15),
      ),
      onPressed: () {
        showModalBottomSheet(
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
      },
    );
  }
}
