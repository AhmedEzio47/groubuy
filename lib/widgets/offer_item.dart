import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
      color: Color.fromRGBO(254,
          (254 * ((100 - widget.offer.discount) / 100)).ceil() - 50, 0, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Seller name',
            style: TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            widget.offer.price,
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontFamily: 'Arial',
                decoration: TextDecoration.lineThrough),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${double.parse(widget.offer.price) * ((100 - widget.offer.discount) / 100)}',
                style: TextStyle(
                  fontSize: 20,
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
          SizedBox(
            height: 15,
          ),
          LinearPercentIndicator(
            progressColor: MyColors.primaryColor,
            backgroundColor: Colors.white,
            percent: widget.offer.subscribers.toDouble() /
                widget.offer.minAmount.toDouble(),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
              '${widget.offer.subscribers} of ${widget.offer.minAmount} subscribed')
        ],
      ),
    );
  }
}
