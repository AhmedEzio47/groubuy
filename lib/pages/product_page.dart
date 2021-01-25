import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/view_models/product_offers_vm.dart';
import 'package:groubuy/widgets/capsule_button.dart';
import 'package:groubuy/widgets/offer_item.dart';
import 'package:groubuy/widgets/product_item.dart';
import 'package:provider/provider.dart';

import 'new_offer.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key key, this.product}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    viewModel = ProductOffersVM(widget.product);
    super.initState();
  }

  ProductOffersVM viewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Column(
        children: [
          ProductItem(
            width: MediaQuery.of(context).size.width,
            height: 350,
            product: widget.product,
          ),
          Expanded(
            child: ChangeNotifierProvider<ProductOffersVM>(
              create: (context) => viewModel,
              child: Consumer<ProductOffersVM>(
                  builder: (context, model, child) => GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: viewModel.offers.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.4,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return OfferItem(
                            offer: viewModel.offers[index],
                          );
                        },
                      )),
            ),
          )
        ],
      ),
      floatingActionButton: Constants.userType == UserTypes.SELLER
          ? CapsuleButton(
              color: MyColors.primaryColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return NewOffer(
                    productId: widget.product.id,
                  );
                }));
              },
              text: '+ Add Offer',
              textColor: MyColors.textLightColor,
            )
          : CapsuleButton(
              color: MyColors.primaryColor,
              onPressed: () async {
                await DatabaseService.addWish(widget.product.id);
              },
              text: '+ Add Wish',
              textColor: MyColors.textLightColor,
            ),
    );
  }
}
