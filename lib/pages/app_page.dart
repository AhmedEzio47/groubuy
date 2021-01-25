import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/pages/profile.dart';
import 'package:groubuy/pages/seller_home.dart';
import 'package:groubuy/pages/user_home.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var _body;
  int _index = 0;
  @override
  initState() {
    _body = Constants.userType == UserTypes.BUYER
        ? UserHomePage()
        : SellerHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomNavigationBar(
          backgroundColor: Colors.grey.shade300,
          currentIndex: _index,
          onTap: (index) {
            switch (index) {
              case 0:
                setState(() {
                  _index = index;
                  _body = Constants.userType == UserTypes.BUYER
                      ? UserHomePage()
                      : SellerHomePage();
                });
                break;
              case 1:
                setState(() {
                  _index = index;
                  _body = ProfilePage();
                });
                break;
            }
          },
          items: [
            CustomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            CustomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile')),
          ],
        ),
      ),
    );
  }
}
