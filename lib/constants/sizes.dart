import 'package:flutter/material.dart';

class Sizes {
  static const double small_product_box = 80;
  static const double mid_product_box = 150;
  BuildContext context;
  setHeight(BuildContext context, double size) {
    return MediaQuery.of(context).size.height * size;
  }

  setWidth(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * size;
  }
}
