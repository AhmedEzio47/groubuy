import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static addProduct(
      String id, String name, String desc, String brand, List images) async {
    await Firestore.instance.collection('products').document(id).setData(
        {'name': name, 'description': desc, 'brand': brand, 'images': images});
  }

  static addCategory(String cat) async {
    await Firestore.instance.collection('categories').add({
      'name': cat,
    });
  }

  static getCategory() async {
    List categories = [];
    QuerySnapshot snapshot =
        await Firestore.instance.collection('categories').getDocuments();
    snapshot.documents.forEach((element) {
      categories.add(element.data['name']);
    });
    return categories;
  }
}
