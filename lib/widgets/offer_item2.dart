import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/sizes.dart';
import 'package:groubuy/constants/strings.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/pages/offer_page.dart';
import 'package:groubuy/services/database_service.dart';
import 'package:groubuy/widgets/cached_image.dart';
import 'package:shimmer/shimmer.dart';

class OfferItem2 extends StatefulWidget {
  final Offer offer;
  final bool isLoading;
  const OfferItem2({Key key, this.offer, this.isLoading = false})
      : super(key: key);
  @override
  _OfferItem2State createState() => _OfferItem2State();
}

class _OfferItem2State extends State<OfferItem2> {
  Product _product;
  getOfferProduct() async {
    Product product =
        await DatabaseService.getProductById(widget.offer.productId);
    _product = product;
    // setState(() {
    //
    // });
  }

  @override
  void initState() {
    super.initState();
    //print('offer id ${widget.offer.id}');
    if (widget.offer.id != null) {
      getOfferProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !widget.isLoading
          ? () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return OfferPage(
                  offer: widget.offer,
                );
              }));
            }
          : null,
      child: Container(
        child: Column(
          children: [
            widget.isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        height: Sizes().setHeight(context, .1),
                        width: Sizes().setWidth(context, .2),
                        color: Colors.grey[300],
                      ),
                    ),
                  )
                : CachedImage(
                    height: Sizes().setHeight(context, .13),
                    width: Sizes().setWidth(context, .2),
                    fit: BoxFit.contain,
                    imageUrl: _product?.images[0],
                    defaultAssetImage: Strings.default_product_image,
                    imageShape: BoxShape.rectangle,
                  ),
            widget.isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        height: 10,
                        width: Sizes().setWidth(context, .2),
                        color: Colors.grey[300],
                      ),
                    ),
                  )
                : Text(
                    _product?.name ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MyColors.textDarkColor,
                      fontFamily: 'Arial',
                    ),
                  ),
            widget.isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        height: 10,
                        width: Sizes().setWidth(context, .2),
                        color: Colors.grey[300],
                      ),
                    ),
                  )
                : Text(
                    'Seller name',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
            widget.isLoading
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: Container(
                        height: 10,
                        width: Sizes().setWidth(context, .2),
                        color: Colors.grey[300],
                      ),
                    ),
                  )
                : Row(
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
