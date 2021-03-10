import 'package:flutter/material.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/constants/sizes.dart';
import 'package:groubuy/custom_modal.dart';
import 'package:groubuy/models/category.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/pages/product_page.dart';
import 'package:groubuy/services/database_service.dart';
import 'package:groubuy/widgets/capsule_button.dart';
import 'package:groubuy/widgets/drawer.dart';
import 'package:groubuy/widgets/product_item.dart';

import 'new_product.dart';

class SellerHomePage extends StatefulWidget {
  @override
  _SellerHomePageState createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  List<Category> _categories = [];
  Map<Category, List<Product>> _categoryProducts = {};

  getCategories() async {
    List<Category> categories = await DatabaseService.getCategories();
    if (mounted) {
      setState(() {
        _categories = categories;
      });
    }
    for (Category category in categories) {
      List<Product> products =
          await DatabaseService.getProductsByCategory(category.name);
      if (mounted) {
        setState(() {
          _categoryProducts.putIfAbsent(category, () => products);
        });
      }
    }
  }

  TextEditingController _categoryController = TextEditingController();

  _goToNewProductPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewProduct()),
    );
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: BuildDrawer(),
      appBar: AppBar(
        leading: Constants.userType == UserTypes.SELLER
            ? InkWell(
                child: Icon(Icons.menu),
                onTap: () => _scaffoldKey.currentState.openDrawer())
            : InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () => Navigator.of(context).pop()),
        title: Text(
            Constants.userType == UserTypes.SELLER ? 'GrouBuy' : 'Products'),
      ),
      floatingActionButton: Constants.userType == UserTypes.SELLER
          ? Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: CapsuleButton(
                color: MyColors.primaryColor,
                text: '+ Add Product',
                textColor: MyColors.textLightColor,
                onPressed: _goToNewProductPage,
              ),
            )
          : Container(),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _categories?.length,
          itemBuilder: (context, index) {
            return (_categoryProducts[_categories[index]]?.length ?? 0) > 0
                ? Container(
                    height: Sizes.small_product_box + 70,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _categories[index].name,
                              style: TextStyle(
                                  color: MyColors.textDarkColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Constants.userType == UserTypes.SELLER
                                ? IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: MyColors.iconDarkColor,
                                    ),
                                    onPressed: () async {
                                      await editCategory(_categories[index]);
                                    })
                                : Container()
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(top: 8),
                                  color: Colors.black26,
                                  child: ListView.builder(
                                      itemCount:
                                          _categoryProducts[_categories[index]]
                                                  ?.length ??
                                              0 + 1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index2) {
                                        return index2 <
                                                _categoryProducts[
                                                        _categories[index]]
                                                    ?.length
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              ProductPage(
                                                                product: _categoryProducts[
                                                                        _categories[
                                                                            index]]
                                                                    [index2],
                                                              )));
                                                },
                                                child: ProductItem(
                                                  width:
                                                      Sizes.small_product_box +
                                                          50,
                                                  height: Sizes.mid_product_box,
                                                  showBrand: false,
                                                  showDescription: false,
                                                  showSlideShow: false,
                                                  product: _categoryProducts[
                                                          _categories[index]]
                                                      [index2],
                                                ),
                                              )
                                            : _categoryProducts[
                                                            _categories[index]]
                                                        ?.length ==
                                                    15
                                                ? InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/category-page',
                                                              arguments: {
                                                            'category':
                                                                _categories[
                                                                    index]
                                                          });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0,
                                                              left: 8.0,
                                                              bottom: 46),
                                                      child: Center(
                                                          child: Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        color: MyColors
                                                            .lightPrimaryColor,
                                                        child: Text(
                                                          'VIEW ALL',
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .darkPrimaryColor,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                      )),
                                                    ),
                                                  )
                                                : Container();
                                      }),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Container();
          }),
    );
  }

  editCategory(Category category) async {
    setState(() {
      _categoryController.text = category.name;
    });
    Navigator.of(context).push(CustomModal(
        child: Container(
      height: 200,
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _categoryController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: 'New name'),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            onPressed: () async {
              if (_categoryController.text.trim().isEmpty) {
                AppUtil.showToast('Please enter a name');
                return;
              }
              Navigator.of(context).pop();
              List<Product> products =
                  await DatabaseService.getProductsByCategory(category.name);
              for (Product product in products) {
                await productsRef
                    .doc(product.id)
                    .update({'category': _categoryController.text});
              }
              await categoriesRef.doc(category.id).update({
                'name': _categoryController.text,
              });
              AppUtil.showToast('Name Updated');
              Navigator.of(context).pushReplacementNamed('/');
            },
            color: MyColors.primaryColor,
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    )));
  }
}
