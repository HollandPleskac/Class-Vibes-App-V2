import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../logic/class_vibes_server.dart';
import '../models/purchase.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final _classVibesServer = ClassVibesServer();

class BillingTab extends StatefulWidget {
  @override
  _BillingTabState createState() => _BillingTabState();
}

class _BillingTabState extends State<BillingTab> {
  Map<String, dynamic> revenueCatUserInfo;
  List<Purchase> pastPurchases = [];
  bool isChecked = false;

  Future getRevenueCatData() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    // String uid = user.uid;
    String uid = "\$RCAnonymousID:75b278d90514447390804954abb8fc8f";
    print(uid);
    String serverResponse =
        await _classVibesServer.getRevenueCatBillingInfo(uid);
    revenueCatUserInfo = json.decode(serverResponse);
  }

  void getPastPurchases() {
    // see the data by printing nonSubscriptions
    Map nonSubscriptions =
        revenueCatUserInfo["subscriber"]['non_subscriptions'];
    print(nonSubscriptions);
    nonSubscriptions.forEach((productKey, productValue) {
      // ERROR : IDK WHY BUT WITHOUT THE print - no values get shown on the screen
      print(productValue.map((purchase) {
        pastPurchases.add(
          Purchase(
            productId: productKey,
            purchaseId: purchase['id'],
            originalPurchaseDate: purchase['original_purchase_date'],
            purchaseDate: purchase['purchase_date'],
            store: purchase['store'],
          ),
        );
      }));
    });
  }

  @override
  void initState() {
    getRevenueCatData().then((_) {
      setState(() {
        getPastPurchases();
        isChecked = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isChecked == false
        ? Center(child: CircularProgressIndicator())
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Payment History',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    color: Colors.red[100],
                    child: pastPurchases.isEmpty == true
                        ? Text('No Past Purchase History')
                        : ListView(
                            children: pastPurchases
                                .map((purchase) => PastPurchaseItem(purchase))
                                .toList(),
                          ),
                  ),
                ),
              ],
            ),
          );
  }
}

class PastPurchaseItem extends StatelessWidget {
  final Purchase purchase;

  PastPurchaseItem(this.purchase);
  @override
  Widget build(BuildContext context) {
    // productId (in app/play store)
    // purchaseId (unique id for every single purchase)
    // original purchase date
    // purchase date
    // store

    // TODO : didplay wha the purchase is : 3 classes
    //TODO : display amount
    // TODO : display the date
    return Text(purchase.productId);
  }
}
