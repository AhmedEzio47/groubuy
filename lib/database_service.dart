import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/models/offer.dart';

import 'constants/constants.dart';
import 'models/category.dart';
import 'models/product.dart';

class DatabaseService {
  static addProduct(String id, String name, String desc, String brand,
      String category, List images) async {
    await firestore.collection('products').doc(id).set({
      'name': name,
      'description': desc,
      'brand': brand,
      'category': category,
      'images': images
    });
  }

  static addCategory(String cat) async {
    await firestore.collection('categories').add({
      'name': cat,
    });
  }

  static Future<List<Category>> getCategories() async {
    QuerySnapshot snapshot = await categoriesRef.get();
    List<Category> categories =
        snapshot.docs.map((doc) => Category.fromDoc(doc)).toList();
    return categories;
  }

  static Future<List<Product>> getProducts() async {
    QuerySnapshot productSnapshot =
        await productsRef.orderBy('name', descending: false).limit(20).get();
    List<Product> products =
        productSnapshot.docs.map((doc) => Product.fromDoc(doc)).toList();
    return products;
  }

  static Future<List<Product>> getProductsByCategory(String category) async {
    QuerySnapshot productSnapshot = await productsRef
        .where('category', isEqualTo: category)
        .orderBy('name', descending: false)
        .limit(15)
        .get();
    List<Product> products =
        productSnapshot.docs.map((doc) => Product.fromDoc(doc)).toList();
    return products;
  }

  static addOffer(
      String id,
      String productId,
      String sellerId,
      int minAmount,
      String price,
      double discount,
      int subscribers,
      bool available,
      DateTime expireDate) async {
    await firestore.collection('offers').doc(id).set({
      'seller_id': sellerId,
      'product_id': productId,
      'subscribers': subscribers,
      'price': price,
      'discount': discount,
      'min_amount': minAmount,
      'available': available,
      'expire_date': expireDate != null ? Timestamp.fromDate(expireDate) : null
    });
  }

  static addWish(String productId) async {
    List<Offer> offers =
        await DatabaseService.getAvailableOffersByProduct(productId);
    if (offers.length > 0) {
      AppUtil.showToast('Offers exist on this product');
      return;
    }
    await firestore.collection('wishes').add({
      'product_id': productId,
      'subscribers': 0,
      'available': true,
    });
    AppUtil.showToast('Wish Added');
  }

  static getProductById(String id) async {
    DocumentSnapshot productSnapshot = await productsRef.doc(id).get();
    return Product.fromDoc(productSnapshot);
  }

  static getAvailableOffersByProduct(String productId) async {
    QuerySnapshot offersSnapshot = await offersRef
        .where('product_id', isEqualTo: productId)
        .where('available', isEqualTo: true)
        .get();
    List<Offer> offers =
        offersSnapshot.docs.map((doc) => Offer.fromDoc(doc)).toList();
    return offers;
  }

  static getAvailableOffers() async {
    QuerySnapshot offersSnapshot =
        await offersRef.where('available', isEqualTo: true).get();
    List<Offer> offers =
        offersSnapshot.docs.map((doc) => Offer.fromDoc(doc)).toList();
    return offers;
  }
}
