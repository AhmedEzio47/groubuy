import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/pages/new_wish.dart';
import 'package:groubuy/widgets/offer_item2.dart';

import '../database_service.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getOffers();
    super.initState();
  }

  List<Offer> _offers = [];
  getOffers() async {
    List<Offer> offers = await DatabaseService.getAvailableOffers();
    setState(() {
      _offers = offers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            child: Icon(Icons.menu),
            onTap: () => _scaffoldKey.currentState.openDrawer()),
        title: Text('GrouBuy'),
      ),
      body: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _offers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.2,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return OfferItem2(
            offer: _offers[index],
          );
        },
      ),
      floatingActionButton: Container(
        height: 50,
        width: 110,
        child: RawMaterialButton(
          fillColor: MyColors.primaryColor,
          onPressed: _goToNewWishPage,
          child: Text(
            '+ Add Wish',
            style: TextStyle(color: MyColors.textLightColor),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: MyColors.primaryColor)),
        ),
      ),
    );
  }

  _goToNewWishPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return NewWish();
    }));
  }
}
