import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:offerapp/screens/user/bottomnavigationPage.dart';
import 'package:offerapp/screens/user/shoppingitem.dart';
import 'package:offerapp/widgets/apptext.dart';

class CreditCardClass extends StatefulWidget {
  String? id;
  var price;

  var uid;
  var name;
  var email;
  var item;

  CreditCardClass({
    Key? key,
    this.id,
    this.price,
    this.email,
    this.item,
    this.uid,
    this.name,
  }) : super(key: key);

  @override
  State<CreditCardClass> createState() => _CreditCardClassState();
}

class _CreditCardClassState extends State<CreditCardClass> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressController2 = TextEditingController();

  var idlist;
  @override
  void initState() {
    idlist = widget.item;
    print(idlist);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: "Enter delivery address",
                ),
              ),
              TextFormField(
                controller: addressController2,
                decoration: InputDecoration(
                  hintText: "Enter delivery address 2",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CreditCardWidget(
                glassmorphismConfig:
                    useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: 'Axis Bank',
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.blueGrey,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      AppText(
                          data: 'Amount Payable:${widget.price.toString()}'),
                      CreditCardForm(
                        formKey: _formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        textColor: Colors.black,
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(color: Colors.black87),
                          labelStyle: const TextStyle(color: Colors.black87),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black87),
                          labelStyle: const TextStyle(color: Colors.black87),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black87),
                          labelStyle: const TextStyle(color: Colors.black87),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black87),
                          labelStyle: const TextStyle(color: Colors.black87),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     const Text(
                      //       'Glassmorphism',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 18,
                      //       ),
                      //     ),
                      //     Switch(
                      //       value: useGlassMorphism,
                      //       inactiveTrackColor: Colors.grey,
                      //       activeColor: Colors.white,
                      //       activeTrackColor: Colors.green,
                      //       onChanged: (bool value) => setState(() {
                      //         useGlassMorphism = value;
                      //       }),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     const Text(
                      //       'Card Image',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 18,
                      //       ),
                      //     ),
                      //     Switch(
                      //       value: useBackgroundImage,
                      //       inactiveTrackColor: Colors.grey,
                      //       activeColor: Colors.white,
                      //       activeTrackColor: Colors.green,
                      //       onChanged: (bool value) => setState(() {
                      //         useBackgroundImage = value;
                      //       }),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          child: const Text(
                            'Pay Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                        onPressed: () async {
                          print(idlist);
                          var box =
                              await Hive.openBox<ShoppingItem>("shopping_cart");
                          var items = box.values
                              .map((item) => {
                                    "name": item.name,
                                    "price": item.price,
                                    "id": item.id,
                                    "sellerid": item.storeid
                                  })
                              .toList();

                          if (addressController.text == null ||
                              addressController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Address is mandatory")));
                          } else {
                            if (_formKey.currentState!.validate()) {

                              for (int i = 0; i < items!.length; i++) {
                                print(idlist[i]);

                                try {
                                  FirebaseFirestore.instance
                                      .collection('orders')
                                      .doc(idlist![i])
                                      .update({
                                    'paymentstatus': 1,
                                    'status': 1,
                                    'deladdress1': addressController.text,
                                    'deladdress2': addressController2.text,
                                  }).catchError((e) => print(e.toString()));
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationPage()),
                                      (route) => false);
                                } catch (e) {
                                  print(e);
                                }
                              }

                              box.clear();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    if (_formKey.currentState!.validate()) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
