import 'package:cloud_firestore/cloud_firestore.dart';

class Wish {
  final String id;
  final String productId;
  final bool available;
  final int subscribers;

  Wish({this.id, this.productId, this.available, this.subscribers});

  factory Wish.fromDoc(DocumentSnapshot doc) {
    return Wish(
      id: doc.documentID,
      productId: doc['product_id'],
      subscribers: doc['subscribers'],
      available: doc['available'],
    );
  }
}
