import 'package:class_vibes_v2/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/no_documents_message.dart';

import '../logic/fire.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
            .doc(classId)
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
                  snapshot.data.docs.isEmpty == false) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return UnapprovedStudent(
                      document: snapshot.data.docs[index],
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.075,
            ),
            child: Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.userAlt,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.075,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        document['name'].toString(),
                        style: TextStyle(fontSize: 16.5),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        document.id,
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
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    
                    _fire.rejectFromQueue(document.id, classId);
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
                    _fire.acceptFromQueue(document.id, classId);
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
