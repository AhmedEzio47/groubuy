import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static addProduct(
      String id, String name, String desc, String brand, List images) async {
    await Firestore.instance.collection('products').document(id).setData(
        {'name': name, 'description': desc, 'brand': brand, 'images': images});
  }
}
