import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constant.dart';

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

  Future getPastPurchases() {
    Map revResponse = {'':''};

    response = revResponse;
  }

  @override
  void initState() {
    getPastPurchases().then((_) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Payments are done though in app purchase.',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimaryColor,fontSize: 15,fontWeight: FontWeight.w500),
          ),
          // SizedBox(height: 20,),
          // Text(
          //   'Contact support@classvibes.net with any questions!',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(color: kPrimaryColor,fontSize: 15,fontWeight: FontWeight.w500),
          // ),
          // RaisedButton(
          //   child: Text('get past purchases'),
          //   onPressed: () {
          //     _makeGetRequest();
          //     print(response);
          //   },
          // ),
          // response == null
          //     ? Container()
          //     : Text(response['subscriber']['non_subscriptions'].toString()),
        ],
      ),
    );
  }
}
