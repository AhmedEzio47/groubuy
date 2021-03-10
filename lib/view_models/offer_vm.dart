import 'package:flutter/foundation.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/services/database_service.dart';
import 'package:random_string/random_string.dart';

class OfferVM extends ChangeNotifier {
  Offer _offer;
  Product _product;
  Product get product => _product;
  Offer get offer => _offer;

  OfferVM({Offer offer}) {
    this._offer = offer;
    init();
  }

  init() async {
    await getOffer();
    await getOfferProduct();
  }

  getOffer() async {
    Offer offer = await DatabaseService.getOfferById(_offer.id);
    _offer = offer;
    notifyListeners();
  }

  getOfferProduct() async {
    Product product = await DatabaseService.getProductById(_offer.productId);
    _product = product;
    notifyListeners();
  }

  subscribe() async {
    bool isSubscriber = await DatabaseService.isSubscriber(_offer.id);
    if (isSubscriber) {
      AppUtil.showToast('You\'re already a subscriber');
      return;
    }
    await DatabaseService.subscribeOffer(_offer.id);
    await getOffer();
    AppUtil.showToast('Subscribed successfully');
  }

  submit(String productId, String minAmount, String price, String discount,
      bool isAvailable, DateTime expireDate) async {
    if (minAmount == '') {
      AppUtil.showToast('Please insert an amount');
      return;
    }
    if (minAmount == '') {
      AppUtil.showToast('Please insert a discount');
      return;
    }
    String id = randomAlphaNumeric(20);

    await DatabaseService.addOffer(
        id,
        productId,
        Constants.currentUserId,
        int.parse(minAmount),
        price,
        double.parse(discount),
        0,
        isAvailable,
        expireDate);
    AppUtil.showToast('Submitted');
  }
}
