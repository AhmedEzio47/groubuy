import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = Firestore.instance;
final categoriesRef = firestore.collection('categories');
final productsRef = firestore.collection('products');

class Constants {
  static String currentUserId;
}
