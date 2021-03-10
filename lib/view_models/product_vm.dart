import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/services/database_service.dart';
import 'package:path/path.dart' as path;
import 'package:random_string/random_string.dart';

class ProductVM extends ChangeNotifier {
  Product product;

  List _imagesUrls = [];

  ProductVM({Product product}) {
    if (product != null) {
      getOffers();
    }
  }
  List<Offer> _offers = [];
  List<Offer> get offers => _offers;
  getOffers() async {
    List<Offer> offers =
        await DatabaseService.getAvailableOffersByProduct(product.id);
    _offers = offers;
    notifyListeners();
  }

  submit(String name, String desc, String brand, String chosenCat,
      List images) async {
    if (name == '') {
      AppUtil.showToast('Please choose a name');
      return;
    }
    if (desc == '') {
      AppUtil.showToast('Please write a description');
      return;
    }
    if (brand == '') {
      AppUtil.showToast('Please choose a brand');
      return;
    }
    if (chosenCat == null) {
      AppUtil.showToast('Please choose a category');
      return;
    }
    String id = randomAlphaNumeric(20);
    for (File image in images) {
      String url = await AppUtil()
          .uploadFile(image, 'products/$id/${path.basename(image.path)}');
      _imagesUrls.add(url);
    }
    await DatabaseService.addProduct(
        id, name, desc, brand, chosenCat, _imagesUrls);
    AppUtil.showToast('Submitted');
  }
}
