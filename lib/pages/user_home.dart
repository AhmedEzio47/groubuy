import 'package:flutter/material.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/widgets/drawer.dart';
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
      drawer: BuildDrawer(),
      key: _scaffoldKey,
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
    );
  }
}
