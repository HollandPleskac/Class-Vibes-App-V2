import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant.dart';

final Firestore _firestore = Firestore.instance;

class FilterAll extends StatelessWidget {
  final Function onClick;
  final bool isTouched;

  FilterAll({this.onClick, this.isTouched});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.all(2),
      color: isTouched == true ? Color.fromRGBO(241, 242, 246, 1) : Color.fromRGBO(241, 242, 246, 1),
      onPressed: () {
        onClick();
      },
      child: Text(
        'All',
        style: TextStyle(
            color: isTouched == true ? kPrimaryColor : Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 13.5),
      ),
    );
  }
}

class FilterDoingGreat extends StatelessWidget {
  final Function onClick;
  final bool isTouched;

  FilterDoingGreat({this.onClick, this.isTouched});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 12.5, right: 12.5),
      color: isTouched == true ? Color.fromRGBO(241, 242, 246, 1) : Color.fromRGBO(241, 242, 246, 1),
      onPressed: () {
        onClick();
      },
      child: Text(
        'Doing Great',
        style: TextStyle(
            color: isTouched == true ? kPieChartDoingGreatColor : Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 13.5),
      ),
    );
  }
}

class FilterNeedHelp extends StatelessWidget {
  final Function onClick;
  final bool isTouched;

  FilterNeedHelp({this.onClick, this.isTouched});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 12.5, right: 12.5),
      color: isTouched == true ? Color.fromRGBO(241, 242, 246, 1) : Color.fromRGBO(241, 242, 246, 1),
      onPressed: () {
        onClick();
      },
      child: Text(
        'Need Help',
        style: TextStyle(
            color: isTouched == true ? kPieChartNeedHelpColor : Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 13.5),
      ),
    );
  }
}

class FilterFrustrated extends StatelessWidget {
  final Function onClick;
  final bool isTouched;

  FilterFrustrated({this.onClick, this.isTouched});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 12.5, right: 12.5),
      color: isTouched == true ? Color.fromRGBO(241, 242, 246, 1) : Color.fromRGBO(241, 242, 246, 1),
      onPressed: () {
        onClick();
      },
      child: Text(
        'Frustrated',
        style: TextStyle(
            color: isTouched == true ? kPieChartFrustratedColor : Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 13.5),
      ),
    );
  }
}

class FilterInactive extends StatelessWidget {
  final Function onClick;
  final bool isTouched;

  FilterInactive({this.onClick, this.isTouched});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 12.5, right: 12.5),
      color: isTouched == true ? Color.fromRGBO(241, 242, 246, 1) :  Color.fromRGBO(241, 242, 246, 1),
      onPressed: () {
        onClick();
      },
      child: Text(
        'Inactive',
        style: TextStyle(
            color: isTouched == true ? kPieChartInactiveColor : Colors.grey[600],
            fontWeight: FontWeight.w600,
            fontSize: 13.5),
      ),
    );
  }
}
