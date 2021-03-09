import 'package:cloud_firestore/cloud_firestore.dart';

class Offer {
  final String id;
  final String productId;
  final String sellerId;
  final int minAmount;
  final String price;
  final double discount;
  final bool available;
  final Timestamp expireDate;
  final int subscribers;

  Offer(
      {this.id,
      this.productId,
      this.sellerId,
      this.minAmount,
      this.price,
      this.discount,
      this.available,
      this.expireDate,
      this.subscribers});

  factory Offer.fromDoc(DocumentSnapshot doc) {
    return Offer(
        id: doc.id,
        sellerId: doc.data()['seller_id'],
        productId: doc.data()['product_id'],
        subscribers: doc.data()['subscribers'],
        discount: doc.data()['discount'],
        minAmount: doc.data()['min_amount'],
        price: doc.data()['price'],
        available: doc.data()['available'],
        expireDate: doc.data()['expire_date']);
  }
}
