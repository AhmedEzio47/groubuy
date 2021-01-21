import 'package:flutter/material.dart';

class CapsuleButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String text;
  final textColor;

  const CapsuleButton(
      {Key key, this.color, this.onPressed, this.text, this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      child: RawMaterialButton(
        fillColor: color,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: color)),
      ),
    );
  }
}
