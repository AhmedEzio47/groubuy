import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/strings.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/widgets/cached_image.dart';

import 'new_offer.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key key, this.product}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  CarouselController buttonCarouselController;

  int _currentImage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: widget.product.images.length,
              itemBuilder: (context, index) {
                return CachedImage(
                  fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  imageShape: BoxShape.rectangle,
                  imageUrl: widget.product.images[index],
                  defaultAssetImage: Strings.default_product_image,
                );
              },
              carouselController: buttonCarouselController,
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
              width: 15 * widget.product.images.length.toDouble(),
              child: Center(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Icon(
                      Icons.fiber_manual_record,
                      color:
                          index == _currentImage ? Colors.black : Colors.grey,
                      size: 15,
                    );
                  },
                  itemCount: widget.product.images.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.product.name,
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
                    widget.product.description,
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
                    widget.product.brand,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
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
