import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:groubuy/constants/strings.dart';
import 'package:groubuy/models/product.dart';

import 'cached_image.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: widget.product?.images?.length,
            itemBuilder: (context, index) {
              return CachedImage(
                fit: BoxFit.fitHeight,
                width: MediaQuery.of(context).size.width,
                height: 300,
                imageShape: BoxShape.rectangle,
                imageUrl: widget.product?.images[index],
                defaultAssetImage: Strings.default_product_image,
              );
            },
            options: CarouselOptions(
              onPageChanged: (page, x) {
                setState(() {
                  _currentImage = page;
                });
              },
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 0,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 10,
            width: 15 *
                (widget.product?.images?.length?.toDouble() ?? 0).toDouble(),
            child: Center(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.fiber_manual_record,
                    color: index == _currentImage ? Colors.black : Colors.grey,
                    size: 15,
                  );
                },
                itemCount: widget.product?.images?.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.product?.name ?? '',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Description: ',
                  style: TextStyle(),
                ),
                Text(
                  widget.product?.description ?? '',
                  style: TextStyle(),
                ),
              ],
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            thickness: 1,
            color: Colors.grey.shade400,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Brand: ',
                  style: TextStyle(),
                ),
                Text(
                  widget.product?.brand ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
