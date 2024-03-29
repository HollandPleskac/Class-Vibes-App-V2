import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../student_portal/join_class.dart';

class NoDocsClassViewStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_no_data_qbuo.svg',
            width: MediaQuery.of(context).size.width * 0.475,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Nothing to see here',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 34,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          FlatButton(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.035),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Color.fromRGBO(78, 115, 223, 1),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JoinClass(),
                ),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(70, 100, 210, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      )),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.height * 0.06,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.027,
                ),
                Text(
                  'Join a class',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NoDocsMeetingsStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_Group_chat_unwm.svg',
            width: MediaQuery.of(context).size.width * 0.475,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Meetings',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 34,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Text(
            'Nothing much to see here. Just chill out.',
            style: TextStyle(
                height: 2,
                color: Colors.grey[600],
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class NoDocsAnnouncementsStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_complete_task_u2c3.svg',
            width: MediaQuery.of(context).size.width * 0.475,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Announcements',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 34,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Text(
            'You\'re all caught up, nothing to see here.',
            style: TextStyle(
                height: 2,
                color: Colors.grey[600],
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class NoDocsClassViewTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_taking_notes_tjaf.svg',
            width: MediaQuery.of(context).size.width * 0.475,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Classes To See',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 34,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              'You have not created any classes yet.  To create a class hit the + icon in the top right corner of this screen.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  color: Colors.grey[600],
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class NoDocsMeetingsTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_checking_boxes_2ibd.svg',
            width: MediaQuery.of(context).size.width * 0.65,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Meetings',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 38,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              'To schedule a meeting go to classes and click on a class.  Go to the Students tab and click on the meeting icon with a student.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  color: Colors.grey[600],
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class NoDocsAnnouncementsClassTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_news_go0e.svg',
            width: MediaQuery.of(context).size.width * 0.65,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Announcements',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 38,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              'Send an announcement to the entire class with the button below!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  color: Colors.grey[600],
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class NoDocsMeetingsClassTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_remote_meeting_cbfk.svg',
            width: MediaQuery.of(context).size.width * 0.65,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Meetings',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 38,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              'To schedule a meeting go to the Students Tab.  Then click on the meeting icon next to a student name!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  color: Colors.grey[600],
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class NoDocsGraphClassTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_empty_xct9.svg',
            width: MediaQuery.of(context).size.width * 0.35,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.025,
          ),
          Text(
            'No Students',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 38,
                color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}

class NoDocsAnnouncementsClassStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_news_go0e.svg',
            width: MediaQuery.of(context).size.width * 0.65,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Announcements',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 38,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              'There are no announcements to see.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  color: Colors.grey[600],
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class NoDocsMeetingsClassStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_remote_meeting_cbfk.svg',
            width: MediaQuery.of(context).size.width * 0.65,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Meetings',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 38,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              'You have no scheduled meetings.  Let your teacher know if you would like to have a meeting through the chat tab.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  color: Colors.grey[600],
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}


class NoDocsChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('no chat be the first !'),
    );
  }
}

class NoDocsClassQueue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/undraw_Checklist__re_2w7v.svg',
            width: MediaQuery.of(context).size.width * 0.65,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Text(
            'No Pending Requests',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width*0.085,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0175,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Any pending student join requests will show up here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  color: Colors.grey[600],
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}