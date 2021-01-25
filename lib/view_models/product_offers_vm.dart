import 'package:flutter/foundation.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';

class ProductOffersVM extends ChangeNotifier {
  final Product product;

  ProductOffersVM(this.product) {
    getOffers();
  }

  List<Offer> _offers = [];
  List<Offer> get offers => _offers;
  getOffers() async {
    List<Offer> offers =
        await DatabaseService.getAvailableOffersByProduct(product.id);
    _offers = offers;
    notifyListeners();
  }
}
