import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/offer.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/view_models/offer_vm.dart';
import 'package:groubuy/widgets/offer_item.dart';
import 'package:groubuy/widgets/product_item.dart';
import 'package:provider/provider.dart';

class OfferPage extends StatefulWidget {
  final Offer offer;

  const OfferPage({Key key, this.offer}) : super(key: key);
  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  OfferVM _offerVM;


  @override
  void initState() {
    _offerVM = OfferVM(offer: widget.offer);
    super.initState();
  }

  int _currentImage = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OfferVM>(
      create: (context)=>_offerVM,

      child: Consumer<OfferVM>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text(_offerVM.product?.name ?? ''),
            ),
            body: Column(
              children: [
                ProductItem(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  product: _offerVM.product,
                ),
                SizedBox(
                  height: 10,
                ),
                OfferItem(
                  offer: _offerVM.offer,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  color: MyColors.primaryColor,
                  onPressed: () {
                    _offerVM.subscribe();
                  },
                  child: Text(
                    'Subscribe',
                    style: TextStyle(color: MyColors.textLightColor),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
