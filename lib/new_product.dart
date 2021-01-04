import 'package:flutter/material.dart';
import 'package:groubuy/database_service.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
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
              RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  await DatabaseService.addProduct(_nameController.text,
                      _descController.text, _brandController.text);
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
}
