import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BillingTab extends StatefulWidget {
  @override
  _BillingTabState createState() => _BillingTabState();
}

class _BillingTabState extends State<BillingTab> {
  Map<String, dynamic> response;
  _makeGetRequest() async {
    Response serverResponse = await get(_localhost());
    setState(() {
      response = json.decode(serverResponse.body);
      print(serverResponse.body);
    });
  }

  String _localhost() {
    if (Platform.isAndroid)
      return 'http://10.0.2.2:3000';
    else // for iOS simulator
      return 'http://localhost:3000';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text('get past purchases'),
            onPressed: () {
              _makeGetRequest();
              print(response);
            },
          ),
          response == null
              ? Container()
              : Text(response['subscriber']['non_subscriptions'].toString()),
        ],
      ),
    );
  }
}
