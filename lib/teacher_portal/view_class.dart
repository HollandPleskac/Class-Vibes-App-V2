import 'package:class_vibes_v2/widgets/no_documents_message.dart';
import 'package:class_vibes_v2/widgets/server_down.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/pie_charts.dart';
import '../widgets/filtered_tabs.dart';
import '../widgets/filter_btns.dart';
import '../widgets/badges.dart';
import '../constant.dart';
import './class_settings.dart';
import './class_announcements.dart';
import './class_meetings.dart';
import './class_queue.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class ViewClass extends StatefulWidget {
  static const routeName = 'individual-class-teacher';
  @override
  _ViewClassState createState() => _ViewClassState();
}

class _ViewClassState extends State<ViewClass> {
  String _email;

  Future getTeacherEmail() async {
    final User user = _firebaseAuth.currentUser;
    final email = user.email;

    _email = email;
  }

  @override
  void initState() {
    getTeacherEmail().then((_) {
      setState(() {});
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );

    super.initState();
  }

  Future<void> showHelpPopupStatuses() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: GraphKey(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArguments = ModalRoute.of(context).settings.arguments as Map;
    final String classId = routeArguments['class id'];

    return DefaultTabController(
      length: 5,
      child: StreamBuilder(
        stream: _firestore
            .collection('Application Management')
            .doc('ServerManagement')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            return snapshot.data['serversAreUp'] == false
                ? ServersDown()
                : Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBar(
                      backgroundColor: kPrimaryColor,
                      title: StreamBuilder(
                        stream: _firestore
                            .collection('Classes')
                            .doc(classId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('');
                          } else {
                            try {
                              return Text(
                                snapshot.data['class name'],
                              );
                            } catch (error) {
                              //this check for classid is used to prevent a red error from occurring when deleting a class
                              return Container();
                            }
                          }
                        },
                      ),
                      centerTitle: true,
                      actions: [
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.question,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await showHelpPopupStatuses();
                          },
                        ),
                      ],
                      bottom: TabBar(
                        indicatorColor: Colors.white,
                        isScrollable: true,
                        tabs: [
                          Tab(text: 'Students'),
                          StreamBuilder(
                            stream: _firestore
                                .collection('Classes')
                                .doc(classId)
                                .collection('Students')
                                .where("accepted", isEqualTo: false)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Tab(
                                  child: Text('Join Requests'),
                                );
                              }
                              return Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Join Requests'),
                                    snapshot.data.docs.length == 0
                                        ? Container()
                                        : SizedBox(width: 7.5),
                                    UnreadMessageBadge(
                                        snapshot.data.docs.length),
                                  ],
                                ),
                              );
                            },
                          ),
                          Tab(text: 'Meetings'),
                          Tab(text: 'Announcements'),
                          Tab(text: 'Settings'),
                        ],
                      ),
                    ),
                    body: Theme(
                      data: ThemeData(
                        backgroundColor: Colors.white,
                        canvasColor: Colors.transparent,
                      ),
                      child: TabBarView(
                        children: [
                          Container(
                            child: StudentsTab(
                              teacherEmail: _email,
                              classId: classId,
                            ),
                          ),
                          Container(
                            child: ClassQueue(
                              classId: classId,
                            ),
                          ),
                          Container(
                            child: ClassMeetings(
                              teacherEmail: _email,
                              classId: classId,
                            ),
                          ),
                          Container(
                            child: ClassAnnouncements(
                              classId: classId,
                            ),
                          ),
                          Container(
                            child: ClassSettings(
                              classId: classId,
                              email: _email,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }
}

//filter btns - are the nav btns
//filter tabs - are the content displayed if u click on a btn
//located in widgets

class StudentsTab extends StatefulWidget {
  final String teacherEmail;
  final String classId;
  StudentsTab({
    this.teacherEmail,
    this.classId,
  });
  @override
  _StudentsTabState createState() => _StudentsTabState();
}

class _StudentsTabState extends State<StudentsTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            _firestore.collection('Classes').doc(widget.classId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            return Column(
              children: <Widget>[
                DynamicPieChart(
                  widget.classId,
                  snapshot.data['max days inactive'],
                ),
                Expanded(
                  // this expanded makes filter view take all remaining height
                  child: Container(
                    child: FilterView(
                      classId: widget.classId,
                      teacherEmail: widget.teacherEmail,
                      maxDaysInactive: snapshot.data['max days inactive'],
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}

class DynamicPieChart extends StatelessWidget {
  final String classId;
  final int maxDaysInactive;

  DynamicPieChart(
    this.classId,
    this.maxDaysInactive,
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('Classes')
          .doc(classId)
          .collection('Students')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: AspectRatio(aspectRatio: 1.6),
            );
          default:
            if (snapshot.data != null &&
                snapshot.data.docs.isEmpty == false &&
                snapshot.data.docs
                    .where((document) => document['accepted'] == true)
                    .isNotEmpty) {
              double doingGreatStudents = snapshot.data.docs
                  .where((document) => document["status"] == "doing great")
                  .where((document) => document['accepted'] == true)
                  .where((documentSnapshot) =>
                      DateTime.now()
                          .difference(
                            DateTime.parse(
                                documentSnapshot['date'].toDate().toString()),
                          )
                          .inDays <
                      maxDaysInactive)
                  .length
                  .toDouble();

              double needHelpStudents = snapshot.data.docs
                  .where((documentSnapshot) =>
                      documentSnapshot['status'] == 'need help')
                  .where((document) => document['accepted'] == true)
                  .where((documentSnapshot) =>
                      DateTime.now()
                          .difference(
                            DateTime.parse(
                                documentSnapshot['date'].toDate().toString()),
                          )
                          .inDays <
                      maxDaysInactive)
                  .length
                  .toDouble();
              double frustratedStudents = snapshot.data.docs
                  .where((documentSnapshot) =>
                      documentSnapshot['status'] == 'frustrated')
                  .where((document) => document['accepted'] == true)
                  .where((documentSnapshot) =>
                      DateTime.now()
                          .difference(
                            DateTime.parse(
                                documentSnapshot['date'].toDate().toString()),
                          )
                          .inDays <
                      maxDaysInactive)
                  .length
                  .toDouble();
              double inactiveStudents = snapshot.data.docs
                  .where((documentSnapshot) =>
                      DateTime.now()
                          .difference(
                            DateTime.parse(
                                documentSnapshot['date'].toDate().toString()),
                          )
                          .inDays >=
                      maxDaysInactive)
                  .where((document) => document['accepted'] == true)
                  .length
                  .toDouble();

              double totalStudents = doingGreatStudents +
                  needHelpStudents +
                  frustratedStudents +
                  inactiveStudents.toDouble();

              int doingGreatPercentage =
                  (doingGreatStudents / totalStudents * 100).toInt();
              int needHelpPercentage =
                  (needHelpStudents / totalStudents * 100).toInt();
              int frustratedPercentage =
                  (frustratedStudents / totalStudents * 100).toInt();
              int inactivePercentage =
                  (inactiveStudents / totalStudents * 100).toInt();

              return PieChartSampleBig(
                //graph percentage
                doingGreatStudents: doingGreatStudents,
                needHelpStudents: needHelpStudents,
                frustratedStudents: frustratedStudents,
                inactiveStudents: inactiveStudents,
                //graph titles
                doingGreatPercentage: doingGreatPercentage,
                needHelpPercentage: needHelpPercentage,
                frustratedPercentage: frustratedPercentage,
                inactivePercentage: inactivePercentage,
              );
            } else {
              return Center(
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: Center(
                    child: NoDocsGraphClassTeacher(),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}

// keep the state of the bottom of the screen all here so the graph doesnt update when u switch the filer
class FilterView extends StatefulWidget {
  final String classId;
  final String teacherEmail;
  final int maxDaysInactive;

  FilterView({this.classId, this.teacherEmail, this.maxDaysInactive});
  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool _isTouchedAll = true;
  bool _isTouchedDoingGreat = false;
  bool _isTouchedNeedHelp = false;
  bool _isTouchedFrustrated = false;
  bool _isTouchedInactive = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.0425,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: FilterAll(
                  isTouched: _isTouchedAll,
                  onClick: () => setState(() {
                    _isTouchedAll = true;
                    _isTouchedDoingGreat = false;
                    _isTouchedNeedHelp = false;
                    _isTouchedFrustrated = false;
                    _isTouchedInactive = false;
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.035),
                child: FilterDoingGreat(
                  isTouched: _isTouchedDoingGreat,
                  onClick: () => setState(() {
                    _isTouchedAll = false;
                    _isTouchedDoingGreat = true;
                    _isTouchedNeedHelp = false;
                    _isTouchedFrustrated = false;
                    _isTouchedInactive = false;
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.035),
                child: FilterNeedHelp(
                  isTouched: _isTouchedNeedHelp,
                  onClick: () => setState(() {
                    _isTouchedAll = false;
                    _isTouchedDoingGreat = false;
                    _isTouchedNeedHelp = true;
                    _isTouchedFrustrated = false;
                    _isTouchedInactive = false;
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.035),
                child: FilterFrustrated(
                  isTouched: _isTouchedFrustrated,
                  onClick: () => setState(() {
                    _isTouchedAll = false;
                    _isTouchedDoingGreat = false;
                    _isTouchedNeedHelp = false;
                    _isTouchedFrustrated = true;
                    _isTouchedInactive = false;
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.035,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: FilterInactive(
                  isTouched: _isTouchedInactive,
                  onClick: () => setState(() {
                    _isTouchedAll = false;
                    _isTouchedDoingGreat = false;
                    _isTouchedNeedHelp = false;
                    _isTouchedFrustrated = false;
                    _isTouchedInactive = true;
                  }),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: _isTouchedAll == true
              ? AllTab(
                  widget.classId, widget.teacherEmail, widget.maxDaysInactive)
              : _isTouchedDoingGreat
                  ? DoingGreatTab(widget.classId, widget.teacherEmail,
                      widget.maxDaysInactive)
                  : _isTouchedNeedHelp
                      ? NeedHelpTab(widget.classId, widget.teacherEmail,
                          widget.maxDaysInactive)
                      : _isTouchedFrustrated
                          ? FrustratedTab(widget.classId, widget.teacherEmail,
                              widget.maxDaysInactive)
                          : _isTouchedInactive
                              ? InactiveTab(widget.classId, widget.teacherEmail,
                                  widget.maxDaysInactive)
                              : Text(
                                  'IMPORTANT - this text will never show since one of the first values will always be true'),
        ),
      ],
    );
  }
}

// class ChartSwitch extends StatefulWidget {
//   final String classId;
//   ChartSwitch(this.classId);
//   @override
//   _ChartSwitchState createState() => _ChartSwitchState();
// }

// class _ChartSwitchState extends State<ChartSwitch> {
//   bool isSwitched = false;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           right: 10,
//           top: 10,
//           child: Container(
//             height: 30,
//             child: Switch(
//               value: isSwitched,
//               onChanged: (value) {
//                 print(value);
//                 setState(() {
//                   isSwitched = value;
//                 });
//               },
//             ),
//           ),
//         ),
//         isSwitched == false
//             ? DynamicPieChart(widget.classId)
//             : Padding(
//               padding: EdgeInsets.only(top:50),
//                 child: LineChartSample1(),
//               ),
//         // : AspectRatio(
//         //     aspectRatio: 1.6,
//         //     child: Center(
//         //       child: Text('chart'),
//         //     ),
//         //   ),
//       ],
//     );
//   }
// }
