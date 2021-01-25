import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/widgets/offer_item.dart';
import 'package:groubuy/widgets/product_item.dart';

class OfferPage extends StatefulWidget {
  final Offer offer;

  const OfferPage({Key key, this.offer}) : super(key: key);
  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
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

  int _currentImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_product?.name ?? ''),
        ),
        body: Column(
          children: [
            ProductItem(
              width: MediaQuery.of(context).size.width,
              height: 350,
              product: _product,
            ),
            SizedBox(
              height: 10,
            ),
            OfferItem(
              offer: widget.offer,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: MyColors.primaryColor,
              onPressed: () {},
              child: Text(
                'Subscribe',
                style: TextStyle(color: MyColors.textLightColor),
              ),
            )
          ],
        ));
  }
}
