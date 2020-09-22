import 'package:flutter/foundation.dart';

// productName is the product id in the app/play store
// purchaseId is the purchase id for every single individual productId

class Purchase {
  final String productId;
  final String purchaseId;
  final String originalPurchaseDate;
  final String purchaseDate;
  final String store;

  Purchase({
    @required this.productId,
    @required this.purchaseId,
    @required this.originalPurchaseDate,
    @required this.purchaseDate,
    @required this.store,
  });
}
