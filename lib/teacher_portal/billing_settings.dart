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
    User user = _firebaseAuth.currentUser;
    String uid = user.uid;
    // String uid = "\$RCAnonymousID:75b278d90514447390804954abb8fc8f";
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
                //SizedBox(height: 30,),
                //Row(
                //  children: [
                //    SizedBox(width: 15,),
                //    Text('Payment History',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700),),
                //  ],
                //),
                SizedBox(height: 30,),
                Expanded(
                  flex: 7,
                  child: Container(
                    color: Colors.white,
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
    // return Text(purchase.productId);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: Row(
            children: [
              SizedBox(width: 10,),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.height * 0.06,
                child: Center(child: Text('1',style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w700),),),
                decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10)
                ),    
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('One Class',style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.w700),),
                  SizedBox(height: 5,),
                  Text(purchase.purchaseDate,style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w500),),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- \$1.99',style: TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.w500),),
                ],
              ),
              SizedBox(width: 15,),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15)
          ),
        ),
      ),
    );
  }
}
