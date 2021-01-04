import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  static addProduct(String name, String desc, String brand) async {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('products')
        .add({'name': name, 'description': desc, 'brand': brand});
  }
}
