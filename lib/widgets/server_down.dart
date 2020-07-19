import 'package:flutter/material.dart';

class ServersDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/serverdown-isometric.png',
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          
            Text(
              'Servers are Down',
              style: TextStyle(color: Colors.grey[600], fontSize: 42),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0275,
            ),
            Padding(
              padding: EdgeInsets.only(left:20,right:20),
                          child: Text(
                'Sorry for the inconvience, but our servers are down for maintenance. Please check back later. This page will allow you to get back to what you were doing when servers are up.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 15.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
