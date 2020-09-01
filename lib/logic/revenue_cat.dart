import 'dart:io';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCat {
  Future<void> getOfferings() async {
    await Purchases.setup("icBZdQAfwvIZlcBZcMCTKxplUedWSFtM");
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current.availablePackages.isNotEmpty) {
        // Display packages for sale
        print(offerings.all);
      }
    } on PlatformException catch (e) {
      // optional error handling
      print('exception ' + e.toString());
    }
  }

  Future<void> makePurchase() async {
    await Purchases.setup("icBZdQAfwvIZlcBZcMCTKxplUedWSFtM");
    Offerings offerings = await Purchases.getOfferings();
    try {
      Package package = offerings.current.getPackage("class");

      print(offerings.current.getPackage("class"));

      await Purchases.purchasePackage(package);

      // if (purchaserInfo
      //     .entitlements.all["my_entitlement_identifier"].isActive) {
      //   // Unlock that great "pro" content
      // }

    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        print('error ' + e.toString());
        print('error code ' + errorCode.toString());
      }
    }
  }
}
