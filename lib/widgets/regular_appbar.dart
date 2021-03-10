import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';

class RegularAppbar extends PreferredSize {
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final double height;

  RegularAppbar(
      {this.leading, this.title, this.trailing, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: MyColors.primaryColor,
      alignment: Alignment.center,
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: leading ??
                Padding(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(left: 8.0),
                ),
          ),
          title ?? Image.asset('assets/images/logo.png'),
          trailing ??
              Container(
                height: 50,
                width: 50,
              )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
