import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/custom_modal.dart';
import 'package:groubuy/models/category.dart';
import 'package:groubuy/services/database_service.dart';
import 'package:groubuy/view_models/product_vm.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _catController = TextEditingController();

  String _chosenCat;
  List _images = [];
  List _imagesUrls = [];
  List<String> _categories = [];

  double _gridHeight;

  int _descMaxLines = 15;
  int _descMinLines = 5;
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  getCategories() async {
    List<Category> categories = await DatabaseService.getCategories();
    categories.forEach((element) {
      setState(() {
        _categories.add(element.name);
      });
    });
  }

  ProductVM _productVM = ProductVM();

  @override
  Widget build(BuildContext context) {
    _gridHeight = MediaQuery.of(context).size.height / 4;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
        actions: [
          InkWell(
            child: Center(child: Text('add category')),
            onTap: () {
              Navigator.push(
                  context,
                  CustomModal(
                      child: Container(
                    color: Colors.white,
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                              controller: _catController,
                              decoration:
                                  InputDecoration(hintText: 'new category')),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            await DatabaseService.addCategory(
                                _catController.text);
                            Navigator.pop(context);
                          },
                          child: Text('submit'),
                        )
                      ],
                    ),
                  )));
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _myTextField(
                      padding: 8, hint: 'Name', controller: _nameController),
                  _myTextField(
                      padding: 8,
                      hint: 'Description',
                      controller: _descController,
                      maxLines: _descMaxLines,
                      minLines: _descMinLines),
                  _myTextField(
                      padding: 8, hint: 'Brand', controller: _brandController),
                  DropdownButton(
                    hint: Text('Category'),
                    value: _chosenCat,
                    onChanged: (text) async {
                      setState(() {
                        _chosenCat = text;
                      });
                    },
                    items: (_categories)
                        .map<DropdownMenuItem<dynamic>>((dynamic value) {
                      return DropdownMenuItem<dynamic>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: _gridHeight,
                      child: GridView.builder(
                        itemCount: _images.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 50,
                            width: 50,
                            color: Colors.grey.shade400,
                            child: index == _images.length
                                ? InkWell(
                                    child: Icon(Icons.add),
                                    onTap: () async {
                                      File image =
                                          await AppUtil.pickImageFromGallery();
                                      setState(() {
                                        _images.add(image);
                                      });
                                    },
                                  )
                                : Image.file(
                                    _images[index],
                                    fit: BoxFit.fill,
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () async {
                      await _productVM.submit(
                          _nameController.text,
                          _descController.text,
                          _brandController.text,
                          _chosenCat,
                          _images);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _myTextField(
      {double padding = 8,
      String hint = 'Hint',
      TextEditingController controller,
      int maxLines = 1,
      int minLines = 1}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextField(
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }
}
