import 'package:flutter/material.dart';

class Sizes {
  static const double product_box = 80;
  BuildContext context;
  setHeight(BuildContext context, double size) {
    return MediaQuery.of(context).size.height * size;
  }

  setWidth(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * size;
  }
}
