import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/no_documents_message.dart';

import '../logic/fire.dart';

final Firestore _firestore = Firestore.instance;
final _fire = Fire();

class ClassQueue extends StatelessWidget {
  final String classId;

  ClassQueue({this.classId});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _firestore
            .collection('Classes')
            .document(classId)
            .collection('Students')
            .where('accepted', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.data != null &&
                  snapshot.data.documents.isEmpty == false) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return UnapprovedStudent(
                      document: snapshot.data.documents[index],
                      classId: classId,
                    );
                  },
                );
              } else {
                return Center(
                  child: NoDocsClassQueue(),
                );
              }
          }
        },
      ),
    );
  }
}

class UnapprovedStudent extends StatelessWidget {
  final DocumentSnapshot document;
  final String classId;

  UnapprovedStudent({
    this.document,
    this.classId,
  });

  String lastUpdatedStatus(Timestamp lastUpdate) {
    if (DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inMinutes <=
        0) {
      // date in seconds
      return 'Queued a few seconds ago';
    } else if (DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inHours <=
        0) {
      // date in minutes
      return 'Queued ' +
          DateTime.now()
              .difference(
                DateTime.parse(lastUpdate.toDate().toString()),
              )
              .inMinutes
              .toString() +
          ' minutes ago';
    } else if (DateTime.now()
            .difference(
              DateTime.parse(lastUpdate.toDate().toString()),
            )
            .inDays ==
        0) {
      // date in hours
      return 'Queued ' +
          DateTime.now()
              .difference(
                DateTime.parse(lastUpdate.toDate().toString()),
              )
              .inHours
              .toString() +
          ' hours ago';
    } else {
      // date in days

      return 'Queued ' +
          DateTime.now()
              .difference(
                DateTime.parse(lastUpdate.toDate().toString()),
              )
              .inDays
              .toString() +
          ' days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.09,
            ),
            child: Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.userAlt,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.09,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        document['name'],
                        style: TextStyle(fontSize: 16.5),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        lastUpdatedStatus(
                          document['date'],
                        ),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    
                    _fire.rejectFromQueue(document.documentID, classId);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.trash,
                    color: Colors.red,
                    size: 22.5,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                IconButton(
                  onPressed: () {
                    _fire.acceptFromQueue(document.documentID, classId);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                    size: 22.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
