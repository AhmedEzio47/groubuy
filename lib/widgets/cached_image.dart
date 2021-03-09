import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class CachedImage extends StatefulWidget {
  final String imageUrl;
  final BoxShape imageShape;
  final double width;
  final double height;
  final BoxFit fit;
  final String defaultAssetImage;

  const CachedImage({
    Key key,
    this.imageUrl,
    this.imageShape,
    this.width,
    this.height,
    this.fit,
    this.defaultAssetImage,
  }) : super(key: key);

  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return _cacheRoundedImage(widget.imageUrl, widget.imageShape, widget.width,
        widget.height, widget.defaultAssetImage);
  }

  Widget _cacheRoundedImage(String imageUrl, BoxShape boxShape, double width,
      double height, String defaultAssetImage) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: boxShape,
      ),
      child: imageUrl != null
          ? CachedNetworkImage(
              fit: widget.fit,
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  shape: boxShape,
                  image: DecorationImage(image: imageProvider, fit: widget.fit),
                ),
              ),
              placeholder: (context, loggedInProfileImageURL) => Center(
                  child: Image.asset(
                defaultAssetImage,
                height: height,
                width: width,
              )),
              errorWidget: (context, loggedInProfileImageURL, error) =>
                  Icon(Icons.error),
            )
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: boxShape,
                image: DecorationImage(
                    image: AssetImage(defaultAssetImage), fit: widget.fit),
              ),
            ),
    );
  }
}
