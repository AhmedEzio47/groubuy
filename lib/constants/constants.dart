import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
final categoriesRef = firestore.collection('categories');
final productsRef = firestore.collection('products');
final offersRef = firestore.collection('offers');

enum UserTypes { SELLER, BUYER }

class Constants {
  static String currentUserId = 'Groubuy admin';
  static UserTypes userType = UserTypes.BUYER;
}
