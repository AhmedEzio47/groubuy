import 'package:flutter/material.dart';
import 'package:groubuy/pages/seller_home.dart';
import 'package:groubuy/pages/user_home.dart';

void main() {
  runApp(MyApp());
}

enum UserTypes { SELLER, BUYER }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  UserTypes _userType = UserTypes.BUYER;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _userType == UserTypes.BUYER ? UserHomePage() : SellerHomePage(),
    );
  }
}
