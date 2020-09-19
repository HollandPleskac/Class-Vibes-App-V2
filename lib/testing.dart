
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import './logic/revenue_cat.dart';

final _revenueCat = RevenueCat();

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('get offering'),
              onPressed: () async {
                await _revenueCat.getOfferings();
              },
            ),
             RaisedButton(
              child: Text('make purchase'),
              onPressed: () async {
                _revenueCat.makePurchase();
              },
            ),
          ],
        ),
      ),
    );
  }
}
