import 'package:flutter/material.dart';
import 'package:groubuy/app_util.dart';
import 'package:groubuy/constants/constants.dart';
import 'package:groubuy/database_service.dart';
import 'package:random_string/random_string.dart';

class NewOffer extends StatefulWidget {
  final String productId;

  const NewOffer({
    Key key,
    this.productId,
  }) : super(key: key);

  @override
  _NewOfferState createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  TextEditingController _minAmountController = TextEditingController();
  TextEditingController _discountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Offer'),
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
                      padding: 8,
                      hint: 'Minimum amount to buy',
                      controller: _minAmountController),
                  _myTextField(
                    padding: 8,
                    hint: 'Discount Percentage',
                    controller: _discountController,
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

  void _submit() async {
    if (_minAmountController.text == '') {
      AppUtil.showToast('Please insert an amount');
      return;
    }
    if (_discountController.text == '') {
      AppUtil.showToast('Please insert a discount');
      return;
    }
    String id = randomAlphaNumeric(20);

    await DatabaseService.addOffer(
        id,
        widget.productId,
        Constants.currentUserId,
        int.parse(_minAmountController.text),
        double.parse(_discountController.text),
        0);
    AppUtil.showToast('Submitted');
    Navigator.of(context).pop();
  }
}
