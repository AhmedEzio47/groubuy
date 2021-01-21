import 'package:flutter/material.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/widgets/product_item.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  List<Product> _products = [];
  getProducts() async {
    List<Product> offers = await DatabaseService.getProducts();
    setState(() {
      _products = offers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .8,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ProductItem(
            product: _products[index],
          );
        },
      ),
    );
  }
}
