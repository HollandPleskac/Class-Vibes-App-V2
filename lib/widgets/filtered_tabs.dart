import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../teacher_portal/chat_teacher.dart';
import '../constant.dart';

final Firestore _firestore = Firestore.instance;

class AllTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document('test class app ui')
          .collection('Students')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no data'),
              );
            }
        }
      },
    );
  }
}

class DoingGreatTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document('test class app ui')
          .collection('Students')
          .where("status", isEqualTo: 'doing great')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: 5),
            ),
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no data'),
              );
            }
        }
      },
    );
  }
}

class NeedHelpTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document('test class app ui')
          .collection('Students')
          .where("status", isEqualTo: 'need help')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: 5),
            ),
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no data'),
              );
            }
        }
      },
    );
  }
}

class FrustratedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document('test class app ui')
          .collection('Students')
          .where("status", isEqualTo: 'frustrated')
          .where(
            "date",
            isGreaterThan: DateTime.now().subtract(
              Duration(days: 5),
            ),
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no data'),
              );
            }
        }
      },
    );
  }
}

class InactiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .document('test class app ui')
          .collection('Students')
          .where(
            "date",
            isLessThan: DateTime.now().subtract(
              Duration(days: 5),
            ),
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Student(
                    name: document['name'],
                    status: document['status'],
                    profilePictureLink: null,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text('no data'),
              );
            }
        }
      },
    );
  }
}

class Student extends StatelessWidget {
  final String name;
  final String status;
  final String profilePictureLink;

  Student({this.name, this.status, this.profilePictureLink});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: profilePictureLink == null
                ? Center(
                    child: FaIcon(
                      FontAwesomeIcons.userAlt,
                      color: kPrimaryColor,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                        profilePictureLink,
                      ),
                    ),
                  ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Container(),
              Text(
                name,
                style: TextStyle(fontSize: 16.5),
              ),
              Text(
                'Last updated: 7 days ago',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Container(),
              Container(),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // final String classId = routeArguments['class id'];
              // final String teacherName = routeArguments['teacher name'];
              // final String teacherUid = routeArguments['student uid'];
              // final String studentName = routeArguments['student name'];
              print('press');
              Navigator.pushNamed(
                context,
                ChatTeacher.routeName,
                arguments: {
                  'class id': 'test class app ui',
                  'teacher name': 'Mr.Shea',
                  'student uid': 'new@gmail.com',
                  'student name': name
                },
              );
            },
            child: FaIcon(
              FontAwesomeIcons.solidComments,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
