import 'package:flutter/material.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/constants/sizes.dart';
import 'package:groubuy/constants/strings.dart';
import 'package:groubuy/custom_modal.dart';
import 'package:groubuy/database_service.dart';
import 'package:groubuy/models/category.dart';
import 'package:groubuy/models/product.dart';
import 'package:groubuy/pages/product_page.dart';
import 'package:groubuy/widgets/cached_image.dart';
import 'package:groubuy/widgets/capsule_button.dart';
import 'package:groubuy/widgets/drawer.dart';

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
        leading: InkWell(
            child: Icon(Icons.menu),
            onTap: () => _scaffoldKey.currentState.openDrawer()),
        title: Text('GrouBuy'),
      ),
      floatingActionButton: CapsuleButton(
        color: MyColors.primaryColor,
        text: '+ Add Product',
        textColor: MyColors.textLightColor,
        onPressed: _goToNewProductPage,
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _categories?.length,
          itemBuilder: (context, index) {
            return (_categoryProducts[_categories[index]]?.length ?? 0) > 0
                ? Container(
                    height: Sizes.product_box + 70,
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
                            IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: MyColors.iconDarkColor,
                                ),
                                onPressed: () async {
                                  await editCategory(_categories[index]);
                                })
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
                                                child: Container(
                                                  height: Sizes.product_box,
                                                  width: Sizes.product_box,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CachedImage(
                                                        defaultAssetImage: Strings
                                                            .default_product_image,
                                                        width:
                                                            Sizes.product_box -
                                                                10,
                                                        height:
                                                            Sizes.product_box -
                                                                10,
                                                        imageShape:
                                                            BoxShape.rectangle,
                                                        imageUrl: _categoryProducts[
                                                                    _categories[
                                                                        index]]
                                                                [index2]
                                                            ?.images[0],
                                                      ),
                                                      Text(
                                                        _categoryProducts[
                                                                    _categories[
                                                                        index]]
                                                                [index2]
                                                            ?.name,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                    .document(product.id)
                    .updateData({'category': _categoryController.text});
              }
              await categoriesRef.document(category.id).updateData({
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
