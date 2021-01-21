import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = Firestore.instance;
final categoriesRef = firestore.collection('categories');
final productsRef = firestore.collection('products');
final offersRef = firestore.collection('offers');

enum UserTypes { SELLER, BUYER }

class Constants {
  static String currentUserId;
  static UserTypes userType = UserTypes.BUYER;
}
