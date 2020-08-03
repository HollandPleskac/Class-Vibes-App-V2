import 'package:flutter/material.dart';

class UnreadMessageBadge extends StatelessWidget {
  final int unreadCount;

  UnreadMessageBadge(this.unreadCount);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        unreadCount.toString(),
      ),
    );
  }
}
