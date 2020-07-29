import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../logic/fire.dart';
import './class_announcements.dart';
import '../widgets/announcements.dart';

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
      child: Stack(
        children: [
          StreamBuilder(
            stream: _firestore
                .collection("Classes")
                .document(classId)
                .collection('Announcements')
                .orderBy("date", descending: true)
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
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 40, right: 40, bottom: 20),
                          child: TeacherAnnouncement(
                            message: document['message'],
                            title: document['title'],
                            timestamp: DateTime.parse(
                                document['date'].toDate().toString()),
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
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20,bottom: 20),
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
      },
    );
  }
}
