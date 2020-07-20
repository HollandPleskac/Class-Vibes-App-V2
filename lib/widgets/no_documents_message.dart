import 'package:flutter/material.dart';

class NoDocsClassViewStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('PIC'),
          SizedBox(
            height: 50,
          ),
          Text('Nothing to see here'),
           SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text('Join a class (push) join class screen')
            ],
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
          Text('PIC'),
          SizedBox(
            height: 50,
          ),
          Text('Nothing much to see here. Just chill out'),
           
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
          Text('PIC'),
          SizedBox(
            height: 50,
          ),
          Text('Your all caught up, nothing to see here')
           
        ],
      ),
    );
  }
}
