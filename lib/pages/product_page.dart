import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/widgets/offer_item.dart';
import 'package:groubuy/widgets/product_item.dart';

import 'new_offer.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key key, this.product}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    getOffers();
    super.initState();
  }

  List<Offer> _offers = [];
  getOffers() async {
    List<Offer> offers =
        await DatabaseService.getAvailableOffersByProduct(widget.product.id);
    setState(() {
      _offers = offers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Column(
        children: [
          ProductItem(
            product: widget.product,
          ),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _offers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.4,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return OfferItem(
                  offer: _offers[index],
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        height: 50,
        width: 100,
        child: RawMaterialButton(
          fillColor: MyColors.primaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return NewOffer(
                productId: widget.product.id,
              );
            }));
          },
          child: Text(
            '+ Add Offer',
            style: TextStyle(color: MyColors.textLightColor),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: MyColors.primaryColor)),
        ),
      ),
    );
  }
}
