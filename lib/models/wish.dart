import 'package:cloud_firestore/cloud_firestore.dart';

class Wish {
  final String id;
  final String productId;
  final bool available;
  final int subscribers;

  Wish({this.id, this.productId, this.available, this.subscribers});

  factory Wish.fromDoc(DocumentSnapshot doc) {
    return Wish(
      id: doc.id,
      productId: doc.data()['product_id'],
      subscribers: doc.data()['subscribers'],
      available: doc.data()['available'],
    );
  }
}
