import 'package:flutter/material.dart';
import 'package:groubuy/constants/colors.dart';
import 'package:groubuy/custom_modal.dart';
import 'package:groubuy/view_models/offer_vm.dart';

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
  TextEditingController _priceController = TextEditingController();
  bool _isAvailable = true;

  DateTime _expireDate;
  OfferVM _offerVM = OfferVM();
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
                    hint: 'Price before discount',
                    controller: _priceController,
                  ),
                  _myTextField(
                    padding: 8,
                    hint: 'Discount Percentage',
                    controller: _discountController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Available:'),
                        Switch(
                            value: _isAvailable,
                            onChanged: (value) {
                              setState(() {
                                _isAvailable = !_isAvailable;
                              });
                            }),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text('Expiration date:'),
                      SizedBox(
                        width: 10,
                      ),
                      Checkbox(
                          value: _expireDate != null,
                          onChanged: (value) {
                            if (!value) {
                              setState(() {
                                _expireDate = null;
                              });
                            } else {
                              setState(() {
                                _expireDate = DateTime.now();
                              });
                            }
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: _expireDate != null
                            ? () {
                                Navigator.push(
                                    context,
                                    CustomModal(
                                        child: Container(
                                      color: Colors.white,
                                      width: 400,
                                      height: 400,
                                      child: Column(
                                        children: [
                                          CalendarDatePicker(
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now()
                                                  .add(Duration(days: 365)),
                                              onDateChanged: (date) {
                                                setState(() {
                                                  _expireDate = date;
                                                });
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      ),
                                    )));
                              }
                            : null,
                        child: Container(
                            height: 25,
                            width: 25,
                            color: _expireDate != null
                                ? MyColors.primaryColor
                                : Colors.grey,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: MyColors.iconLightColor,
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      _expireDate != null
                          ? Text(
                              '${_expireDate.day}/${_expireDate.month}/${_expireDate.year}')
                          : Container(),
                    ],
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () async {
                      await _offerVM.submit(
                          widget.productId,
                          _minAmountController.text,
                          _priceController.text,
                          _discountController.text,
                          _isAvailable,
                          _expireDate);
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
