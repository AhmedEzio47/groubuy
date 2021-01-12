import 'package:cloud_firestore/cloud_firestore.dart';

import 'constants/constants.dart';
import 'models/category.dart';
import 'models/product.dart';

class DatabaseService {
  static addProduct(String id, String name, String desc, String brand,
      String category, List images) async {
    await Firestore.instance.collection('products').document(id).setData({
      'name': name,
      'description': desc,
      'brand': brand,
      'category': category,
      'images': images
    });
  }

  static addCategory(String cat) async {
    await Firestore.instance.collection('categories').add({
      'name': cat,
    });
  }

  static Future<List<Category>> getCategories() async {
    QuerySnapshot snapshot = await categoriesRef.getDocuments();
    List<Category> categories =
        snapshot.documents.map((doc) => Category.fromDoc(doc)).toList();
    return categories;
  }

  static Future<List<Product>> getProductsByCategory(String category) async {
    QuerySnapshot productSnapshot = await productsRef
        .where('category', isEqualTo: category)
        .orderBy('name', descending: false)
        .limit(15)
        .getDocuments();
    List<Product> products =
        productSnapshot.documents.map((doc) => Product.fromDoc(doc)).toList();
    return products;
  }
}
