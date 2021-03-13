import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groubuy/models/user_model.dart' as user_model;

final firestore = FirebaseFirestore.instance;
final categoriesRef = firestore.collection('categories');
final productsRef = firestore.collection('products');
final offersRef = firestore.collection('offers');
final usersRef = firestore.collection('users');

enum UserTypes { SELLER, BUYER }

class Constants {
  static String currentUserId = 'Groubuy admin';
  static user_model.User currentUser;
  static User currentFirebaseUser;
  static bool isFacebookOrGoogleUser;

  ///change user type
  static UserTypes userType = UserTypes.BUYER;

  static String language = 'en';
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}
AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
