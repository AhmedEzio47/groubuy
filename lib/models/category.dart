import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;

  Category({this.name, this.id});

  factory Category.fromDoc(DocumentSnapshot doc) {
    return Category(id: doc.documentID, name: doc['name']);
  }
}
