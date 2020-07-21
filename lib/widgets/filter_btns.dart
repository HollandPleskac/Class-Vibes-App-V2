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
      padding: EdgeInsets.all(2),
      color: isTouched == true ? Colors.grey[300] : Colors.grey[200],
      onPressed: () {
        onClick();
      },
      child: Text(
        'All',
        style: TextStyle(
            color: isTouched == true ? kPrimaryColor : Colors.grey[700],
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
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 12.5, right: 12.5),
      color: isTouched == true ? Colors.grey[300] : Colors.grey[200],
      onPressed: () {
        onClick();
      },
      child: Text(
        'Doing Great',
        style: TextStyle(
            color: isTouched == true ? kPrimaryColor : Colors.grey[700],
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
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 12.5, right: 12.5),
      color: isTouched == true ? Colors.grey[300] : Colors.grey[200],
      onPressed: () {
        onClick();
      },
      child: Text(
        'Need Help',
        style: TextStyle(
            color: isTouched == true ? kPrimaryColor : Colors.grey[700],
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
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 12.5, right: 12.5),
      color: isTouched == true ? Colors.grey[300] : Colors.grey[200],
      onPressed: () {
        onClick();
      },
      child: Text(
        'Frustrated',
        style: TextStyle(
            color: isTouched == true ? kPrimaryColor : Colors.grey[700],
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
      padding: EdgeInsets.only(top: 2, bottom: 2, left: 12.5, right: 12.5),
      color: isTouched == true ? Colors.grey[300] : Colors.grey[200],
      onPressed: () {
        onClick();
      },
      child: Text(
        'Inactive',
        style: TextStyle(
            color: isTouched == true ? kPrimaryColor : Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 13.5),
      ),
    );
  }
}
