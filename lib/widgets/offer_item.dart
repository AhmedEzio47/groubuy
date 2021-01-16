import 'package:flutter/material.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';

class OfferItem extends StatefulWidget {
  final Offer offer;

  const OfferItem({Key key, this.offer}) : super(key: key);
  @override
  _OfferItemState createState() => _OfferItemState();
}

class _OfferItemState extends State<OfferItem> {
  Product _product;
  getOfferProduct() async {
    Product product =
        await DatabaseService.getProductById(widget.offer.productId);
    setState(() {
      _product = product;
    });
  }

  @override
  void initState() {
    getOfferProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Column(
        children: [Text(_product.name)],
      ),
    );
  }
}
