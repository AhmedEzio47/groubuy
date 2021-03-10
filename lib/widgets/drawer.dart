import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/constants/strings.dart';
import 'package:groubuy/pages/new_product.dart';
import 'package:groubuy/pages/seller_home.dart';
import 'package:groubuy/pages/welcome_page.dart';

class BuildDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  @override
  Widget build(BuildContext context) {
    return buildDrawer(context);
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewProduct()));
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: null != null
                        ? CachedNetworkImageProvider('')
                        : AssetImage(Strings.default_product_image),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Username' ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    //Icon(Icons.arrow_drop_down)
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 0.5,
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return SellerHomePage();
              }));
            },
            title: Text(
              'Products',
              style: TextStyle(
                color: MyColors.primaryColor,
              ),
            ),
            leading: Icon(
              Icons.file_download,
              color: MyColors.primaryColor,
            ),
          ),
          authStatus == AuthStatus.LOGGED_IN
              ? ListTile(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return WelcomePage();
                    }));
                  },
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: MyColors.primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.power_settings_new,
                    color: MyColors.primaryColor,
                  ),
                )
              : ListTile(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return WelcomePage();
                    }));
                  },
                  title: Text(
                    'Sign In',
                    style: TextStyle(
                      color: MyColors.primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.power_settings_new,
                    color: MyColors.primaryColor,
                  ),
                ),
        ],
      ),
    );
  }
}
