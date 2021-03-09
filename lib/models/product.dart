import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String brand;
  final String category;
  final List images;

  Product(
      {this.name,
      this.description,
      this.brand,
      this.category,
      this.images,
      this.id});

  factory Product.fromDoc(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      name: doc.data()['name'],
      description: doc.data()['description'],
      brand: doc.data()['brand'],
      category: doc.data()['category'],
      images: doc.data()['images'],
    );
  }
}
