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
        id: doc.documentID,
        sellerId: doc['seller_id'],
        productId: doc['product_id'],
        subscribers: doc['subscribers'],
        discount: doc['discount'],
        minAmount: doc['min_amount'],
        price: doc['price'],
        available: doc['available'],
        expireDate: doc['expire_date']);
  }
}
