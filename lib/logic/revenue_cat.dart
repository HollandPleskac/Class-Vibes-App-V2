import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCat {

  Future<void> signInRevenueCat(String uid) async {
    // sets up the purchases with the public api key and the firebase app user id
    await Purchases.setup("icBZdQAfwvIZlcBZcMCTKxplUedWSFtM", appUserId: uid);
    print(uid);

    PurchaserInfo purchaserInfo = await Purchases.identify(uid);

    print('Purchase Info : '+purchaserInfo.toString());
  }

  Future<void> signOutRevenueCat() async {
    await Purchases.reset();
  }

  Future<List> makePurchase() async {
    Offerings offerings = await Purchases.getOfferings();
    try {
      Package package = offerings.current.getPackage("class");

      print(offerings.current.getPackage("class"));

      await Purchases.purchasePackage(package);

      return ['success', ''];
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      switch (errorCode) {
        case PurchasesErrorCode.purchaseCancelledError:
          print("User cancelled");
          return ['failure', 'User cancelled the purchase'];
        case PurchasesErrorCode.purchaseNotAllowedError:
          print("User not allowed to purchase");
          return ['failure', 'User is not allowed to make the purchase'];
        default:
          return ['failure', 'An error occurred'];
      }
    }
  }

  Future<void> getOfferings() async {
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
}
