import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:groubuy/constants/strings.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/pages/product_page.dart';

import 'cached_image.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final double width;
  final double height;
  final bool showDescription;
  final bool showBrand;
  final bool showSlideShow;

  const ProductItem(
      {Key key,
      this.product,
      this.width,
      this.height,
      this.showDescription = true,
      this.showBrand = true,
      this.showSlideShow = true})
      : super(key: key);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ProductPage(
          product: widget.product,
        );
      })),
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.showSlideShow
                  ? CarouselSlider.builder(
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
                    )
                  : CachedImage(
                      fit: BoxFit.contain,
                      width: widget.width - 80,
                      height: widget.height - 80,
                      imageShape: BoxShape.rectangle,
                      imageUrl: widget.product?.images[0],
                      defaultAssetImage: Strings.default_product_image,
                    ),
              SizedBox(
                height: 5,
              ),
              widget.showSlideShow
                  ? Container(
                      height: 10,
                      width: 15 *
                          (widget.product?.images?.length?.toDouble() ?? 0)
                              .toDouble(),
                      child: Center(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.fiber_manual_record,
                              color: index == _currentImage
                                  ? Colors.black
                                  : Colors.grey,
                              size: 15,
                            );
                          },
                          itemCount: widget.product?.images?.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    )
                  : Container(),
              widget.showSlideShow
                  ? SizedBox(
                      height: 10,
                    )
                  : Container(),
              Flexible(
                child: Text(
                  widget.product?.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              widget.showDescription
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Description: ',
                            style: TextStyle(),
                          ),
                          Flexible(
                            child: Text(
                              widget.product?.description ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              widget.showDescription
                  ? Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                      color: Colors.grey.shade400,
                    )
                  : Container(),
              widget.showBrand
                  ? Padding(
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
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
