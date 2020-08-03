import 'package:flutter/material.dart';

class UnreadMessageBadge extends StatelessWidget {
  final int unreadCount;

  UnreadMessageBadge(this.unreadCount);
  @override
  Widget build(BuildContext context) {
    if (unreadCount.toInt() == 0) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.blue[200], borderRadius: BorderRadius.circular(6)),
        height: 25,
        width: 25,
        child: Center(
          child: Text(
            unreadCount.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (0 < unreadCount.toInt() && unreadCount.toInt() > 6) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.orangeAccent, borderRadius: BorderRadius.circular(6)),
        height: 25,
        width: 25,
        child: Center(
          child: Text(
            unreadCount.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (5 < unreadCount.toInt()) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(6)),
        height: 25,
        width: 25,
        child: Center(
          child: Text(
            unreadCount.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
