import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/strings.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/pages/offer_page.dart';
import 'package:groubuy/widgets/cached_image.dart';

class OfferItem2 extends StatefulWidget {
  final Offer offer;

  const OfferItem2({Key key, this.offer}) : super(key: key);
  @override
  _OfferItem2State createState() => _OfferItem2State();
}

class _OfferItem2State extends State<OfferItem2> {
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return OfferPage(
            offer: widget.offer,
          );
        }));
      },
      child: Container(
        child: Column(
          children: [
            CachedImage(
              height: 100,
              width: 100,
              fit: BoxFit.contain,
              imageUrl: _product?.images == null ? null : _product?.images[0],
              defaultAssetImage: Strings.default_product_image,
              imageShape: BoxShape.rectangle,
            ),
            Text(
              _product?.name ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: MyColors.textDarkColor,
                fontFamily: 'Arial',
              ),
            ),
            Text(
              'Seller name',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${double.parse(widget.offer.price) * ((100 - widget.offer.discount) / 100)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.textDarkColor,
                    fontFamily: 'Arial',
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text('${widget.offer.discount}% OFF')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
