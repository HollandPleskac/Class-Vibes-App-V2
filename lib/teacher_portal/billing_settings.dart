import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';
import '../logic/class_vibes_server.dart';
import '../logic/revenue_cat.dart';


final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _classVibesServer = ClassVibesServer();
final _revenueCat = RevenueCat();

class BillingTab extends StatefulWidget {
  @override
  _BillingTabState createState() => _BillingTabState();
}

class _BillingTabState extends State<BillingTab> {
  Map<String, dynamic> revenueCatUserInfo;
  _makeGetRequest() async {
    Response serverResponse = await get(_localhost());
    setState(() {
      revenueCatUserInfo = json.decode(serverResponse.body);
      print(serverResponse.body);
    });
  }

  String _localhost() {
    if (Platform.isAndroid)
      return 'http://10.0.2.2:3000';
    else // for iOS simulator
      return 'http://localhost:3000';
  }

  Future getPurchases() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    String uid = user.uid;
    String serverResponse =  await _classVibesServer.getRevenueCatBillingInfo(uid);

    revenueCatUserInfo = json.decode(serverResponse);
  }

  @override
  void initState() {
    getPurchases().then((_) {
      setState(() {
        print(revenueCatUserInfo);
      });
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
          //     print(pastPurchases);
          //   },
          // ),
          revenueCatUserInfo == null
              ? Container()
              : Text(revenueCatUserInfo["subscriber"].toString()),
          // revenueCatUserInfo == null
          //     ? Container()
          //     : Text(revenueCatUserInfo["subscriber"]['non_subscriptions'].toString()),
        ],
      ),
    );
  }
}
