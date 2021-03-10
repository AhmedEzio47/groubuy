import 'package:flutter/foundation.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';

import '../database_service.dart';

class OfferVM extends ChangeNotifier{
  Offer _offer;
  Product _product;
  Product get product => _product;
  Offer get offer => _offer;

  OfferVM({Offer offer}){
    this._offer = offer;
    getOfferProduct();
  }

  getOffer() async{
    Offer offer = await DatabaseService.getOfferById(_offer.id);
    _offer = offer;
    notifyListeners();
  }

  getOfferProduct() async {
    Product product =
    await DatabaseService.getProductById(_offer.productId);
    _product = product;
    notifyListeners();
  }
  
  subscribe() async{
    await DatabaseService.subscribeOffer(_offer.id);
    await getOffer();
    AppUtil.showToast('Subscribed successfully');
  }
}