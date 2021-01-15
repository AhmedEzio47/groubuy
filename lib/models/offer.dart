import 'package:cloud_firestore/cloud_firestore.dart';

class Offer {
  final String id;
  final String productId;
  final String sellerId;
  final int minAmount;
  final double discount;
  final int buyers;

  Offer(
      {this.id,
      this.productId,
      this.sellerId,
      this.minAmount,
      this.discount,
      this.buyers});

  factory Offer.fromDoc(DocumentSnapshot doc) {
    return Offer(
        id: doc.documentID,
        sellerId: doc['seller_id'],
        productId: doc['product_id'],
        buyers: doc['buyers'],
        discount: doc['discount'],
        minAmount: doc['min_amount']);
  }
}
