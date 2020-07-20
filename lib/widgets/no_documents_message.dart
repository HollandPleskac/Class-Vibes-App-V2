import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';
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
            height: 10,
          ),
          Text(
            'Nothing to see here',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 34,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            padding: EdgeInsets.only(right: 15),
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
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(
                  width: 10,
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
    return Text('no meetings');
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
            height: 30,
          ),
          Text(
            'No Announcements',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 34,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'You\'re all caught up, nothing to see here.',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
