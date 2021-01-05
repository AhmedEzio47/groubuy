import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/database_service.dart';
import 'package:path/path.dart' as path;
import 'package:random_string/random_string.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _brandController = TextEditingController();

  List _images = [];
  List _imagesUrls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _myTextField(
                  padding: 8, hint: 'Name', controller: _nameController),
              _myTextField(
                  padding: 8, hint: 'Description', controller: _descController),
              _myTextField(
                  padding: 8, hint: 'Brand', controller: _brandController),
              Expanded(
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
              RaisedButton(
                color: Colors.blue,
                onPressed: _submit,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _myTextField(
      {double padding = 8,
      String hint = 'Hint',
      TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }

  void _submit() async {
    String id = randomAlphaNumeric(20);
    for (File image in _images) {
      String url = await AppUtil().uploadFile(
          image, context, 'products/$id/${path.basename(image.path)}');
      _imagesUrls.add(url);
    }
    await DatabaseService.addProduct(id, _nameController.text,
        _descController.text, _brandController.text, _imagesUrls);
  }
}
